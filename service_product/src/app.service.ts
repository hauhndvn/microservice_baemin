import { Injectable } from '@nestjs/common';
import { PrismaService } from './prisma/prisma.service';
import { PaginationLibsService } from './pagination_libs/pagination_libs.service';
import { ElasticsearchService } from '@nestjs/elasticsearch';

@Injectable()
export class AppService {
  constructor(
    private prismaService: PrismaService,
    private readonly paginationService: PaginationLibsService,
    private elasticService: ElasticsearchService
  ) {}

  async findAll(
    page: number,
    limit: number,
    featured?: string,
    name_food?: string,
  ) {
    try {
      // Chuyển đổi dữ liệu query từ string sang kiểu thích hợp
      const currentPage = Number(page) || 1;
      const pageSize = Number(limit) || 10;
      const skip = (currentPage - 1) * pageSize;
  
      // Tạo điều kiện truy vấn với Prisma
      const where: any = {};
  
      if (featured !== undefined) {
        where.featured = featured === 'true'; // Chuyển thành boolean
      }
  
      if (name_food) {
        where.name_food = { contains: name_food, mode: 'insensitive' }; // Tìm kiếm không phân biệt hoa thường
      }
  
      // Truy vấn danh sách món ăn, lấy toàn bộ trường của bảng food + address từ eatery
      const foods = await this.prismaService.food.findMany({
        where,
        select: {
          food_id: true,
          thumbnail: true,
          description: true,
          name_food: true,
          price: true,
          inventory: true,
          featured: true,
          promotion: true,
          kind: true,
          eatery_id: true,
          category_id: true,
          eatery: {
            select: {
              address: true, // Lấy địa chỉ từ bảng eatery
            },
          },
        },
        orderBy: { food_id: 'desc' },
        skip,
        take: pageSize,
      });
  
      // Định dạng dữ liệu đầu ra
      const formattedFoods = foods.map((food) => ({
        ...food, // Giữ nguyên toàn bộ thông tin của food
        address: food.eatery.address, // Thêm địa chỉ vào kết quả
        eatery: undefined, // Xóa key `eatery` thừa trong dữ liệu trả về
      }));
  
      // Gọi PaginationService để lấy thông tin phân trang
      const paginationMeta = await this.paginationService.paginate(
        this.prismaService.food, // Model Prisma
        currentPage,
        pageSize,
        where,
      );
  
      return {
        status: 'success',
        filters: {
          featured: featured || null,
          limit: pageSize,
        },
        data: {
          docs: formattedFoods,
          pages: paginationMeta,
        },
      };
    } catch (error) {
      throw new Error(error.message);
    }
  }
    
  async findEatery(eatery_id: number, featured?: string) {
    const query: any = { eatery_id };

    // Nếu featured được truyền vào, kiểm tra và thêm vào query
    if (featured !== undefined) {
        query.featured = featured === 'true'; // Chuyển đổi chuỗi "true" thành boolean
    }

    // Thực hiện truy vấn trong Prisma
    const foods = await this.prismaService.food.findMany({
        where: query, // Áp dụng bộ lọc eatery_id và featured (nếu có)
    });

    return {
        status: 'success',
        filters: {
            eatery_id,
            featured: featured !== undefined ? query.featured : undefined,
        },
        data: {
            docs: foods,
        },
    };
}

async findCategory(category_id: number, featured?: string) {
  const query: any = { category_id };

  // Nếu featured được truyền vào, kiểm tra và thêm vào query
  if (featured !== undefined) {
      query.featured = featured === 'true'; // Chuyển đổi chuỗi "true" thành boolean
  }

  // Thực hiện truy vấn trong Prisma
  const foods = await this.prismaService.food.findMany({
      where: query, // Áp dụng bộ lọc category_id và featured (nếu có)
  });

  return {
      status: 'success',
      filters: {
          category_id,
          featured: featured !== undefined ? query.featured : undefined,
      },
      data: {
          docs: foods,
      },
  };
}

  async findFood(name: string) {
    let result = await this.elasticService.search({
      index: "food-index",
      query:{
        match:{
          name_food: name
        }
      }
    })
    return result;
    // const foods = await this.prismaService.food.findMany({
    //   where:{
    //     name_food:{
    //       contains: name //LIKE '%name%'
    //     }
    //   },
    //   select: {
    //     food_id: true,
    //     thumbnail: true,
    //     description: true,
    //     name_food: true,
    //     price: true,
    //     inventory: true,
    //     featured: true,
    //     promotion: true,
    //     kind: true,
    //     eatery_id: true,
    //     category_id: true,
    //     eatery: {
    //       select: {
    //         address: true, // Lấy địa chỉ từ bảng eatery
    //       },
    //     },
    //   },
    // });
    // // Định dạng dữ liệu đầu ra
    // const formattedFoods = foods.map((food) => ({
    //   ...food, // Giữ nguyên toàn bộ thông tin của food
    //   address: food.eatery.address, // Thêm địa chỉ vào kết quả
    //   eatery: undefined, // Xóa key `eatery` thừa trong dữ liệu trả về
    // }));
    // return formattedFoods;
  }

}

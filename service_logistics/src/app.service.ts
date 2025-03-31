import { Injectable } from '@nestjs/common';
import { PrismaService } from './prisma/prisma.service';

@Injectable()
export class AppService {
  constructor(private prismaService:PrismaService){}
  async saveLogistics(model) {
    let {
      customer_id, 
      order_id,//dữ liệu mới
      logistics_name,
      fee,
      total_payment2 }= model;
    // Lưu dữ liệu vào bảng logistics
    // Lấy thông tin khách hàng từ bảng customer
    const customer = await this.prismaService.customer.findUnique({
      where: { customer_id },
      select: { email: true, phone: true, address: true, surname: true, name: true },
    });
    
    if (logistics_name && fee && customer) {
      await this.prismaService.logistics.create({
        data: {
          order_id,
          logistics_name,
          fee,
          start_date: new Date(), 
          expected_end_date: new Date(new Date().setHours(new Date().getHours() + 2)), // Cộng thêm 2 giờ
          surname: customer.surname,
          name: customer.name,
          email: customer.email,
          address: customer.address,
          phone: customer.phone,
          total_payment: total_payment2,
        },
      });
    }
    //gọi service_notify lần nữa để thông báo thành công
    //sendMailSuccess(data){...}
  }
}

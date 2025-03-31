import { Injectable } from '@nestjs/common';
import { PrismaService } from './prisma/prisma.service';

@Injectable()
export class AppService {
  constructor(private prismaService:PrismaService){}
  async saveOrder(model) {
    let {
      customer_id, 
      statusOrder, 
      logistics_name,
      fee, 
      order_items }= model;
      
    // Tạo đơn hàng mới
    const created_at = new Date(); 

    let total_price2 = 0;
    const orderItemsPromises2 = order_items.map (async (item) => {
      total_price2 += item.price; 
    });

    let newModel = {
      customer_id,
      total_price: total_price2,
      statusOrder,
      created_at
    }

    const newOrder = await this.prismaService.orderfood.create({
      data:newModel,
      select: { order_id: true }, // Chỉ lấy order_id sau khi tạo đơn hàng để dùng cho orderItems
    });

    // Tạo danh sách order items
    let total_payment2 = 0;
    const orderItemsPromises = order_items.map (async (item) => {
        let newItem = {
          order_id: newOrder.order_id,// Sử dụng order_id vừa tạo
          food_id: item.food_id,
          qty: item.qty,
          price: Math.max(1, item.price * (1 - item.discount) * item.qty) // áp mã giảm giá, đảm bảo price >= 1 khi giảm giá 100%
        }
        total_payment2 += newItem.price; //để lưu vào logistics, khách hàng trả tiền thực tế
        
        await this.prismaService.orderItems.create({
            data: newItem
        });
        
      // trừ tồn kho: Giảm inventory trong bảng food
          await this.prismaService.food.update({
            where: { 
              food_id: item.food_id,
              inventory: { gte: item.qty }, // Chỉ giảm nếu inventory >= qty
            },
            data: { inventory: { decrement: item.qty } },
            });
      }
    );

    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    //------------------------------------

    // gọi service_logistics để lưu dữ liệu vào bảng logistics
    // Lấy thông tin khách hàng từ bảng customer
    const customer = await this.prismaService.customer.findUnique({
      where: { customer_id },
      select: { email: true, phone: true, address: true, surname: true, name: true },
    });
    
    if (logistics_name && fee && customer) {
      await this.prismaService.logistics.create({
        data: {
          order_id: newOrder.order_id,
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
    await Promise.all(orderItemsPromises);
    //------------------------------------
    return {
      message: "Order success",
      newOrder
    };
  }
}

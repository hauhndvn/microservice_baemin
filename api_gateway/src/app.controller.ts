import { Body, Controller, Get, Inject, Param, Post } from '@nestjs/common';
import { AppService } from './app.service';
import { ClientProxy } from '@nestjs/microservices';
import { lastValueFrom } from 'rxjs';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService,
    @Inject("PRODUCT_NAME") private productService: ClientProxy,
    @Inject("USER_NAME") private userService: ClientProxy,

  ) {}

  @Get("/food/:name")
 async getFood(@Param('name') name: string) {
    //gọi đến service product để lấy data
    let productData = await lastValueFrom(this.productService.send("get_food", name));
    // console.log(productData);
    
    return productData;
  }
  @Post("/auth/sign-up")
  async signUp(@Body() body){
    //body chứa họ tên, sđt, email, password, address
    //qua service bóc tách sau
      let newUserData = await lastValueFrom(this.userService.send("post_new_user", body));
      return newUserData;
    }
  @Post("/auth/login")
  async login(@Body() body){
    //body chứa userName/sđt/email, password
    //qua service bóc tách sau
    // console.log(body);
    
    let userData = await lastValueFrom(this.userService.send("post_user", body));
    return userData;
    }
  @Post("/order")
  order(@Body() info){
    //gọi service_order để lưu data --> saveOrder(data)
    //gọi service_notify để gửi email xác nhận đơn --> sendMailOrder(data)
    //gọi tiếp service_logistics --> saveLogistics() 
    //       thành công thì gọi service_notify để gửi email báo đã giao hàng --> sendMailSuccess(data)
  }
}

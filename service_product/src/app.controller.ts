import { Controller, Get, Param, Query } from '@nestjs/common';
import { AppService } from './app.service';
import { MessagePattern, Payload } from '@nestjs/microservices';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  
  findAll(
    @Query('page') page: string,
    @Query('limit') limit: string,
    @Query('featured') featured?: string,
    @Query('name_food') name_food?: string,
  ) {
    return this.appService.findAll(
      Number(page),
      Number(limit),
      featured,
      name_food,
    );
  }

  @Get('/eatery/:eatery_id')
  findEatery(
    @Param('eatery_id') eatery_id: number,
    @Query('featured') featured?: string
) {
    return this.appService.findEatery(Number(eatery_id), featured);
  }

  @Get('/category/:category_id')
  findCategory(
    @Param('category_id') category_id: number,
    @Query('featured') featured?: string
  ) {
    return this.appService.findCategory(Number(category_id), featured);
  }

  @MessagePattern("get_food")
 async findFood(@Payload() data:string) {
    return this.appService.findFood(data);
  }
}

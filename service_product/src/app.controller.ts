import { Controller, Get, Inject, Param, Query } from '@nestjs/common';
import { AppService } from './app.service';
import { MessagePattern, Payload } from '@nestjs/microservices';
import { CACHE_MANAGER } from '@nestjs/cache-manager';
import { Cache } from 'cache-manager';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService,
    @Inject(CACHE_MANAGER) private cacheManager: Cache 
  ) {}

  @MessagePattern("get_all_food")
  async findAll(@Payload() data) {
    let {page, limit, featured} = data;
    let dataCache = await this.cacheManager.get("get_all_food");
    //lần 2
    if (dataCache){
      return dataCache;
    }
    let dataGet = await this.appService.findAll(
      Number(page),
      Number(limit),
      featured,
    );
    //lần 1
    this.cacheManager.set("get_all_food", dataGet);
    return dataGet;
  }

  @MessagePattern("get_all_name_food")
  async findAllFood(@Payload() data) {
    let {page, limit, featured, name_food} = data
    let dataCache = await this.cacheManager.get("get_all_name_food");
    //lần 2
    if (dataCache){
      return dataCache;
    }
    let dataGet = await this.appService.findAll(
      Number(page),
      Number(limit),
      featured,
      name_food,
    );
    //lần 1
    this.cacheManager.set("get_all_name_food", dataGet);
    return dataGet;
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

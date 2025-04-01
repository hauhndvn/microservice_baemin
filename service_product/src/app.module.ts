import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { PrismaModule } from './prisma/prisma.module';
import { ConfigModule } from '@nestjs/config';
import { PaginationLibsModule } from './pagination_libs/pagination_libs.module';
import { RedisCacheModule } from './redis_cache/redis_cache.module';
import { ElasticModule } from './elastic/elastic.module';


@Module({
  imports: [PrismaModule, PaginationLibsModule, ConfigModule.forRoot({isGlobal:true}),
    RedisCacheModule,
    ElasticModule
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}

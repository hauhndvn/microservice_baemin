import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { ClientsModule, Transport } from '@nestjs/microservices';

@Module({
  imports: [ClientsModule.register([{
    name: "PRODUCT_NAME",
      transport: Transport.RMQ,
      options: {
        //url kết nối đến server RabbitMQ
        urls: ['amqp://admin:1234@localhost:5672'],
        //tên queue xử lý
        queue: 'product_queue',
        queueOptions: {
          durable: true
        }
      }
    },{
      name: "USER_NAME",
      transport: Transport.RMQ,
      options: {
        //url kết nối đến server RabbitMQ
        urls: ['amqp://admin:1234@localhost:5672'],
        //tên queue xử lý
        queue: 'user_queue',
        queueOptions: {
          durable: true
        }
      }
    }])
  ],    
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}

import { Controller, Get } from '@nestjs/common';
import { AppService } from './app.service';
import { EventPattern, Payload } from '@nestjs/microservices';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @EventPattern("send_mail_signUp_success")
  sendMailRegister(@Payload() data) {
    return this.appService.sendMailRegister(data);
  }

  sendMailOrder(@Payload() data) {
    return this.appService.sendMailOrder(data);
  }

  sendMailSuccess(@Payload() data) {
    return this.appService.sendMailSuccess(data);
  }

}

import { Controller, UploadedFile, UseInterceptors } from "@nestjs/common";
import { AuthService } from "../services/auth.service";
import { GrpcMethod } from "@nestjs/microservices";
import { Metadata, ServerUnaryCall } from "@grpc/grpc-js";
import { LoginUserDto } from "../dto/login-user.dto";

@Controller('auth')
export class AuthGrpcController {

  constructor(private authService: AuthService) { }

  @GrpcMethod('AuthService', 'Login')
  async Login(data: { email: string, password: string }, metadata: Metadata, call: ServerUnaryCall<LoginUserDto, any>) {
    return await this.authService.login(data.email, data.password);
  }

}
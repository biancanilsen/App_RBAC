import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { GrpcOptions, MicroserviceOptions, Transport } from '@nestjs/microservices';
import { join } from 'path';
import * as path from 'path';

async function bootstrap() {
  const app = await NestFactory.createMicroservice<MicroserviceOptions>(AppModule, {
    transport: Transport.GRPC,
    options: {
      url: '172.26.32.1:3000',
      package: ['user', 'auth'],
      protoPath: [path.join(__dirname, 'app/proto/user.proto'), path.join(__dirname, 'app/proto/auth.proto')],
      loaders: {
        enums: String,
        objects: true,
        arrays: true,
      },
    },
  } as GrpcOptions);
  await app.listen();
}
bootstrap();

import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { GrpcOptions, MicroserviceOptions, Transport } from '@nestjs/microservices';
import { join } from 'path';
import * as path from 'path';

async function bootstrap() {
  const app = await NestFactory.createMicroservice<MicroserviceOptions>(AppModule, {
    transport: Transport.GRPC,
    options: {
      url: 'localhost:3000',
      package: ['user', 'auth', 'upload'],
      protoPath: [path.join(__dirname, 'app/proto/user.proto'), path.join(__dirname, 'app/proto/auth.proto'), path.join(__dirname, 'app/proto/upload.proto')],
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

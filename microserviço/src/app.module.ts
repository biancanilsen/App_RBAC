import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { UserModule } from './app/module/user.module';
import { AuthModule } from './app/module/auth.module';
import { APP_FILTER } from '@nestjs/core';


@Module({
  imports: [ConfigModule.forRoot(),
  TypeOrmModule.forRoot({
    type: 'postgres',
    host: process.env.DB_HOST,
    port: Number(process.env.DB_PORT),
    database: process.env.DB_DATABASE,
    username: process.env.DB_USERNAME,
    password: process.env.DB_PASSWORD,
    synchronize: true,
    entities: [__dirname + '/**/*.entity{.js,.ts}']
  }), UserModule, AuthModule]
  , controllers: [],
  providers: [

  ],
})
export class AppModule { }

import { Module } from "@nestjs/common";
import { TypeOrmModule } from "@nestjs/typeorm";
import { UserEntity } from "../entities/user.entity";
import { UserGrpcController } from "../controllers/user.controller";
import { UserService } from "../services/user.service";
import { RolesGuard } from "../guards/roles.guard";
import { AuthService } from "../services/auth.service";
import { JwtService } from "@nestjs/jwt";
import { ConfigService } from "@nestjs/config";
import { UserAbilityFactory } from "../factory/user-abiility.factory";
import { PoliciesGuard } from "../guards/polices.guard";

@Module({
    imports: [TypeOrmModule.forFeature([UserEntity])],
    controllers: [UserGrpcController],
    providers: [UserService, RolesGuard, AuthService, JwtService, ConfigService, UserAbilityFactory, PoliciesGuard],
    exports: [UserService],
})
export class UserModule { }
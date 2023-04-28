import { Injectable } from "@nestjs/common";
import { UserService } from "./user.service";
import { JwtService } from "@nestjs/jwt";
import { compareSync } from "bcrypt";
import { Role } from "../enum/role.enum";
import { ConfigService } from "@nestjs/config";
import { Algorithm, Jwt, Secret, SignOptions, VerifyOptions, sign, verify } from "jsonwebtoken";
import { readFileSync } from "fs";
import { join } from "path";

@Injectable()
export class AuthService {
    private verifyOptions: VerifyOptions; constructor(
        private readonly userService: UserService,
        private readonly jwtService: JwtService,
    ) { }

    async validateUser(email: string, password: string) {
        let user: any;
        try {
            user = await this.userService.findOne(email);
        } catch (error) {
            return console.log(error.message);
        }
        console.log(user.password);
        const isPasswordValid = compareSync(password, user.password);
        if (!isPasswordValid) return null;
        return user;
    }


    async login(email: string, password: string) {
        let validate = await this.validateUser(email, password);
        const payload = { sud: validate.id, login: validate.email };
        let token = this.jwtService.sign(payload)
        let user = await this.userService.findOneOrFail(validate.id);
        console.log(user.role);

        let data = {
            token: token,
            role: user.role,
        }
        return data
    }



    async verifyToken(jwt: any) {

        const verify = this.jwtService.verify(jwt, {
            secret: process.env.JWT_SECRET_KEY,
        });
        return verify ?? null;
    }
}

import { Injectable } from "@nestjs/common";
import { UserService } from "./user.service";
import { JwtService } from "@nestjs/jwt";
import { compareSync } from "bcrypt";

@Injectable()
export class AuthService {
    constructor(
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
        const isPasswordValid = compareSync(password, user.password);
        if (!isPasswordValid) return null;
        return user;
    }



    async login(email: string, password: string) {
        let validate = await this.validateUser(email, password);
        const payload = { sud: validate.id, login: validate.email };
        let token = this.jwtService.sign(payload)

        let data = {
            token: token
        }
        return data
    }

    verifyToken(jwt: any) {
        const verify = this.jwtService.verify(jwt, {
            secret: process.env.JWT_SECRET_KEY,
        });
        console.log(verify)
        return verify ?? null;
    }
}

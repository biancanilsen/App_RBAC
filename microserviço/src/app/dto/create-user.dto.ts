import { IsNotEmpty } from "class-validator";
import { Role } from "../enum/role.enum";

export class CreateUserDto {

    @IsNotEmpty()
    name: string;

    @IsNotEmpty()
    email: string;

    @IsNotEmpty()
    password: string;

    @IsNotEmpty()
    role: Role;
}
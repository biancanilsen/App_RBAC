import { IsOptional } from "class-validator";
import { Role } from "../enum/role.enum";

export class UpdateUserDto {
    @IsOptional()
    id: string;

    @IsOptional()
    name: string;

    @IsOptional()
    email: string;

    @IsOptional()
    password: string;

    @IsOptional()
    role: Role;
}
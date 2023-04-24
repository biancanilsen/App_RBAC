import { IsOptional } from "class-validator";

export class UpdateUserDto {
    @IsOptional()
    id: string;

    @IsOptional()
    name: string;

    @IsOptional()
    email: string;

    @IsOptional()
    password: string;
}
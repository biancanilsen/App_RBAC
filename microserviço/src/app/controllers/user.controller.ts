import { Controller } from "@nestjs/common";
import { UserService } from "../services/user.service";
import { GrpcMethod } from "@nestjs/microservices";
import { CreateUserDto } from "../dto/create-user.dto";
import { Metadata, ServerUnaryCall } from "@grpc/grpc-js";
import { UpdateUserDto } from "../dto/update-user.dto";

@Controller('user')
export class UserGrpcController {

    constructor(private userService: UserService) { }

    @GrpcMethod('UserService', 'Create')
    async Create(data: CreateUserDto, metadata: Metadata, call: ServerUnaryCall<CreateUserDto, any>) {
        return await this.userService.store(data);
    }

    @GrpcMethod('UserService', 'Update')
    async Update(data: UpdateUserDto, metadata: Metadata, call: ServerUnaryCall<UpdateUserDto, any>) {
        return await this.userService.update(data.id, data);
    }

    @GrpcMethod('UserService', 'ShowAll')
    async Index(data) {
        const users = await this.userService.findAll();
        return users;
    }

    @GrpcMethod('UserService', 'ShowOne')
    async Show(data: { id: string }) {
        const { id } = data;
        return await this.userService.findOneOrFail(id);
    }

    @GrpcMethod('UserService', 'Delete')
    async Delete(data: { id: string }) {
        const { id } = data;
        return await this.userService.destroy(id);
    }

}
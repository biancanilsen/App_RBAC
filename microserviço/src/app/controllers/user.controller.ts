import { Controller, HttpException, HttpStatus, UseFilters, UseGuards, UseInterceptors } from "@nestjs/common";
import { UserService } from "../services/user.service";
import { GrpcMethod, RpcException } from "@nestjs/microservices";
import { CreateUserDto } from "../dto/create-user.dto";
import { Metadata, ServerUnaryCall } from "@grpc/grpc-js";
import { UpdateUserDto } from "../dto/update-user.dto";
import { RolesGuard } from "../guards/roles.guard";
import { Roles } from "../decorators/roles.decorators";
import { Role } from "../enum/role.enum";
import { PoliciesGuard } from "../guards/polices.guard";
import { CheckPolicies } from "../decorators/check-policies.decorator";
import { AllUserPolicyHandler, CreateUserPolicyHandler, ReadUserPolicyHandler, UpdateUserPolicyHandler } from "../policy-handle/policy-handler ";


@Controller('user')
@CheckPolicies(new AllUserPolicyHandler())
export class UserGrpcController {

    constructor(private userService: UserService) { }

    @GrpcMethod('UserService', 'Create')
    async Create(data: CreateUserDto, metadata: Metadata, call: ServerUnaryCall<CreateUserDto, any>) {
        return await this.userService.store(data);
    }

    @GrpcMethod('UserService', 'Update')
    @UseGuards(PoliciesGuard)
    @CheckPolicies(new UpdateUserPolicyHandler())
    async Update(data: UpdateUserDto, metadata: Metadata, call: ServerUnaryCall<UpdateUserDto, any>) {
        try {
            return await this.userService.update(data.id, data)
        } catch (error) {
        }
    }

    @GrpcMethod('UserService', 'ShowAll')
    @UseGuards(PoliciesGuard)
    @CheckPolicies(new ReadUserPolicyHandler())
    async Index(data) {
        const users = await this.userService.findAll();
        return users;
    }

    @GrpcMethod('UserService', 'ShowOne')
    @UseGuards(PoliciesGuard)
    async Show(data: { id: string }) {
        const { id } = data;
        return await this.userService.findOneOrFail(id);
    }

    @GrpcMethod('UserService', 'Delete')
    @UseGuards(PoliciesGuard)
    async Delete(data: { id: string }) {
        const { id } = data;
        return await this.userService.destroy(id);
    }

}
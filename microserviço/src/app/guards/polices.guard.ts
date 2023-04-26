import { CanActivate, ExecutionContext, Injectable, UnauthorizedException } from "@nestjs/common";
import { Reflector } from "@nestjs/core";
import { AppAbility, UserAbilityFactory } from "../factory/user-abiility.factory";
import { CHECK_POLICIES_KEY } from "../decorators/check-policies.decorator";
import { PolicyHandler } from "../policy-handle/policy-handler ";
import { Metadata } from "@grpc/grpc-js";
import { AuthService } from "../services/auth.service";
import { UserService } from "../services/user.service";

@Injectable()
export class PoliciesGuard implements CanActivate {
    constructor(
        private reflector: Reflector,
        private userAbilityFactory: UserAbilityFactory,
        private readonly authService: AuthService,
        private readonly userService: UserService
    ) { }

    async canActivate(context: ExecutionContext): Promise<boolean> {
        const request: Metadata = context.switchToRpc().getContext();
        const policyHandlers =
            this.reflector.get<PolicyHandler[]>(
                CHECK_POLICIES_KEY,
                context.getHandler(),
            ) || [];
        const bearerToken = request.get('authorization').toString();
        const authToken: string[] = bearerToken.split(' ');
        if (authToken[0] != 'Bearer') {
            throw new UnauthorizedException('Invalid Auth Strategy');
        }

        const verify = await this.authService.verifyToken(authToken[1]);

        const user = await this.userService.findOneOrFail(verify.sud);
        const ability = this.userAbilityFactory.createForUser(user);

        return policyHandlers.every((handler) =>
            this.execPolicyHandler(handler, ability),
        );
    }

    private execPolicyHandler(handler: PolicyHandler, ability: AppAbility) {
        if (typeof handler === 'function') {
            return handler(ability);
        }
        return handler.handle(ability);
    }
}
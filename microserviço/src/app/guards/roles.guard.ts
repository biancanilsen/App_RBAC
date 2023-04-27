import { CanActivate, ExecutionContext, ForbiddenException, Injectable, UnauthorizedException } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { Observable } from 'rxjs';
import { Role } from '../enum/role.enum';
import { ROLES_KEY } from '../decorators/roles.decorators';
import { AuthService } from '../services/auth.service';
import { RpcException } from '@nestjs/microservices';
import { Metadata } from '@grpc/grpc-js';
import { JwtPayload } from 'jsonwebtoken';
import { UserService } from '../services/user.service';

@Injectable()
export class RolesGuard implements CanActivate {

  constructor(private reflector: Reflector, private readonly authService: AuthService, private readonly userService: UserService) { }

  async canActivate(
    context: ExecutionContext,
  ): Promise<boolean> {
    let pass = false;
    try {
      const request: Metadata = context.switchToRpc().getContext();
      const requiredRoles = this.reflector.getAllAndOverride<Role[]>(ROLES_KEY, [
        context.getHandler(),
        context.getClass(),
      ]);
      if (!requiredRoles) {
        return true;
      }

      console.log(requiredRoles)
      const bearerToken = request.get('authorization').toString();
      const authToken: string[] = bearerToken.split(' ');
      if (authToken[0] != 'Bearer') {
        throw new UnauthorizedException('Invalid Auth Strategy');
      }

      const verify = await this.authService.verifyToken(authToken[1]);

      const user = await this.userService.findOneOrFail(verify.sud);
      console.log(user)

      for (let i = 0; i < requiredRoles.length; i++) {
        if (requiredRoles[i] === user.role) {
          pass = true;
        } else {
          pass = false
        }
      }


      console.log(pass)
      return pass
    } catch (error) {
      throw new RpcException(error);
    }
  }
}

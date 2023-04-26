import { Action } from "../enum/action.enum";
import { AppAbility } from "../factory/user-abiility.factory";

interface IPolicyHandler {
    handle(ability: AppAbility): boolean;
}

type PolicyHandlerCallback = (ability: AppAbility) => boolean;

export type PolicyHandler = IPolicyHandler | PolicyHandlerCallback;


export class CreateUserPolicyHandler implements IPolicyHandler {
    handle(ability: AppAbility) {
        return ability.can(Action.Create, 'all') && ability.can(Action.Read, 'all');
    }
}

export class ReadUserPolicyHandler implements IPolicyHandler {
    handle(ability: AppAbility) {
        return ability.can(Action.Read, 'all');
    }
}


export class UpdateUserPolicyHandler implements IPolicyHandler {
    handle(ability: AppAbility) {
        return ability.can(Action.Update, 'all') && ability.can(Action.Read, 'all');
    }
}

export class AllUserPolicyHandler implements IPolicyHandler {
    handle(ability: AppAbility) {
        return ability.can(Action.Manage, 'all');
    }
}

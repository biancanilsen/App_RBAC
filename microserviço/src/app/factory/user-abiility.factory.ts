import { Ability, AbilityBuilder, AbilityClass, ExtractSubjectType, InferSubjects } from "@casl/ability";
import { UserEntity } from "../entities/user.entity";
import { Action } from "../enum/action.enum";
import { Injectable } from "@nestjs/common";

type Subjects = InferSubjects<typeof UserEntity> | 'all';

export type AppAbility = Ability<[Action, Subjects]>;

@Injectable()
export class UserAbilityFactory {
    createForUser(user: UserEntity) {
        const { can, cannot, build } = new AbilityBuilder<
            Ability<[Action, Subjects]>
        >(Ability as AbilityClass<AppAbility>);

        switch (user.role) {
            case 'admin':
                can(Action.Manage, 'all');
                break;
            case 'editor':
                can(Action.Update, 'all');
                break;
            case 'user':
                can(Action.Read, 'all');
                break;
            case 'creator':
                can(Action.Create, 'all');
                break;
            default:
                break;
        }
        // if (user.role === 'admin') {
        //   can(Action.Manage, 'all'); // read-write access to everything
        // } else {
        //   can(Action.Read, 'all'); // read-only access to everything
        // }

        // can(Action.Update, Article, { authorId: user.id });
        // cannot(Action.Delete, Article, { isPublished: true });

        return build({
            detectSubjectType: (item) =>
                item.constructor as ExtractSubjectType<Subjects>,
        });
    }
}

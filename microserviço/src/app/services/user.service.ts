import { Injectable, NotFoundException } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { UserEntity } from "../entities/user.entity";
import { FindManyOptions, Repository } from "typeorm";
import { CreateUserDto } from "../dto/create-user.dto";
import { UpdateUserDto } from "../dto/update-user.dto";
import { hashSync } from "bcrypt";

@Injectable()
export class UserService {
    constructor(
        @InjectRepository(UserEntity)
        private readonly userRepository: Repository<UserEntity>,
    ) { }

    async findAll() {
        // const options: FindManyOptions = {
        //     order: { createdAt: 'DESC' },
        // };
        try {
            // return await this.userRepository.find(options);
            const users = await this.userRepository.find({
                select: ['id', 'name', 'email', 'role']
            })
            let data = {
                users
            }
            console.log(data);
            return data;
        } catch (error) {
            throw new NotFoundException(error.message);
        }
    }

    async findOneOrFail(id: string) {
        try {
            return this.userRepository.findOne({
                where: { id },
                // relations: {
                //   DetailsProfile: true

                // },
            });

        } catch (error) {
            throw new NotFoundException(error.message);
        }
    }

    async findOne(email: string) {
        try {
            return await this.userRepository.findOneBy({ email });
        } catch (error) {
            throw new NotFoundException(error.message);
        }
    }

    async store(data: CreateUserDto) {
        try {
            const user = this.userRepository.create(data);
            return await this.userRepository.save(user);
        } catch (error) {
            throw new NotFoundException(error.message);
        }

    }

    async update(id: string, data: UpdateUserDto) {
        try {
            const user = await this.userRepository.findOneBy({ id });
            if (data.password === null) {
                data.password = hashSync(user.password, 10);
            }
        } catch (error) {
            throw new NotFoundException(error.message);
        }
        return await this.userRepository.save({ id: id, ...data });
    }

    async destroy(id: string) {
        try {
            await this.userRepository.findOneById(id);
        } catch (error) {
            throw new NotFoundException(error.message);
        }
        return await this.userRepository.softDelete({ id });
    }
}
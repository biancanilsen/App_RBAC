import { Controller } from "@nestjs/common";
import { UploadService } from "../services/upload.service";
import { GrpcMethod } from "@nestjs/microservices";

@Controller('upload')
export class UpdateGrpcController {

    constructor(private uploadService: UploadService) { }

    @GrpcMethod('UploadService', 'Upload')
    async upload(data) {
        return await this.uploadService.uploadWithConverter(data.data);
    }
}

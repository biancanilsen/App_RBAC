import { Module } from "@nestjs/common";
import { UploadService } from "../services/upload.service";
import { UpdateGrpcController } from "../controllers/upload.controller";

@Module({
    imports: [],
    controllers: [UpdateGrpcController],
    providers: [UploadService],
    exports: [],
})
export class UploadModule { }
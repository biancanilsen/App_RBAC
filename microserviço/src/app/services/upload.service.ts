import { Injectable } from "@nestjs/common";
import * as fs from 'fs';

@Injectable()
export class UploadService {
    constructor() { }

    async uploadWithConverter(data: string) {
        const buffer = Buffer.from(data, "base64");
        let name = "files/" + Date.now() + ".WebP"
        fs.writeFileSync(name, buffer);
        const base64 = fs.readFileSync(name, "base64");
        return { message: base64 }
    }
}
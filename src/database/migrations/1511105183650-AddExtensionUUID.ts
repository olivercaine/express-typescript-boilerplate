import { MigrationInterface, QueryRunner } from 'typeorm';

export class AddExtensionUUID1511105183650 implements MigrationInterface {

    public async up(queryRunner: QueryRunner): Promise<any> {
        queryRunner.query('CREATE EXTENSION IF NOT EXISTS "uuid-ossp";');
    }

    public async down(queryRunner: QueryRunner): Promise<any> {
        queryRunner.query('DROP EXTENSION "uuid-ossp";');
    }

}

import { MigrationInterface, QueryRunner, TableForeignKey } from 'typeorm';

export class AddUserRelationToPetTable1512663990063 implements MigrationInterface {

    private tableForeignKey = new TableForeignKey(
        'fk_user_pet',  // foreign key name
        ['user_id'],    // column names
        ['id'],         // referenced column names
        'user',         // referenced table
        'user'          // referenced table path
    );

    public async up(queryRunner: QueryRunner): Promise<any> {
        await queryRunner.createForeignKey('pet', this.tableForeignKey);
    }

    public async down(queryRunner: QueryRunner): Promise<any> {
        await queryRunner.dropForeignKey('pet', this.tableForeignKey);
    }

}

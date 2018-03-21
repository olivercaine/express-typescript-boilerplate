import * as Faker from 'faker';
import * as uuid from 'uuid';

import { Pet } from '../../../src/api/models/Pet';
import { Factory } from '../../lib/seeds';

const factory = Factory.getInstance();

factory.define(Pet, (faker: typeof Faker) => {
    const gender = faker.random.number(1);
    const name = faker.name.firstName(gender);

    const pet = new Pet();
    pet.id = uuid.v4(); // TODO: remove/automate this
    pet.name = name;
    pet.age = faker.random.number();
    return pet;
});

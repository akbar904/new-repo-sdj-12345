
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_pet_app/models/pet_model.dart';

void main() {
	group('Pet Model', () {
		test('should correctly create a Pet instance', () {
			final pet = Pet(name: 'Cat', icon: Icons.pets);
			expect(pet.name, 'Cat');
			expect(pet.icon, Icons.pets);
		});

		test('should correctly serialize and deserialize a Pet instance', () {
			final pet = Pet(name: 'Dog', icon: Icons.person);
			final json = pet.toJson();
			final newPet = Pet.fromJson(json);

			expect(newPet.name, 'Dog');
			expect(newPet.icon, Icons.person);
		});

		test('should support value equality for Pet instances', () {
			final pet1 = Pet(name: 'Cat', icon: Icons.pets);
			final pet2 = Pet(name: 'Cat', icon: Icons.pets);

			expect(pet1, equals(pet2));
		});
	});
}

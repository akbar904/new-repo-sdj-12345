
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.simple_pet_app/cubits/pet_cubit.dart';

// Mock Pet Model
class MockPet extends Mock implements Pet {}

void main() {
	group('PetCubit', () {
		// Create an instance of PetCubit for testing
		late PetCubit petCubit;

		setUp(() {
			petCubit = PetCubit();
		});

		tearDown(() {
			petCubit.close();
		});

		test('initial state is Cat', () {
			expect(petCubit.state, Pet(name: 'Cat', icon: Icons.pets));
		});

		blocTest<PetCubit, Pet>(
			'emits [Dog] when togglePet is called while state is Cat',
			build: () => petCubit,
			act: (cubit) => cubit.togglePet(),
			expect: () => [Pet(name: 'Dog', icon: Icons.person)],
		);

		blocTest<PetCubit, Pet>(
			'emits [Cat] when togglePet is called while state is Dog',
			build: () => petCubit,
			act: (cubit) {
				cubit.togglePet(); // first toggle to Dog
				cubit.togglePet(); // second toggle to Cat
			},
			expect: () => [
				Pet(name: 'Dog', icon: Icons.person),
				Pet(name: 'Cat', icon: Icons.pets),
			],
		);
	});
}

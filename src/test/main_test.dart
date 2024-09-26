
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:com.example.simple_pet_app/main.dart';

class MockPetCubit extends MockCubit<Pet> implements PetCubit {}

void main() {
	group('MainApp Initialization', () {
		testWidgets('MainApp initializes correctly', (WidgetTester tester) async {
			await tester.pumpWidget(MainApp());

			expect(find.byType(MaterialApp), findsOneWidget);
			expect(find.byType(HomeScreen), findsOneWidget);
		});
	});

	group('PetCubit', () {
		late PetCubit petCubit;

		setUp(() {
			petCubit = PetCubit();
		});

		tearDown(() {
			petCubit.close();
		});

		blocTest<PetCubit, Pet>(
			'emits Dog when togglePet is called after initial state Cat',
			build: () => petCubit,
			act: (cubit) => cubit.togglePet(),
			expect: () => [Pet(name: 'Dog', icon: Icons.person)],
		);

		blocTest<PetCubit, Pet>(
			'emits Cat when togglePet is called after Dog state',
			build: () => petCubit,
			seed: () => Pet(name: 'Dog', icon: Icons.person),
			act: (cubit) => cubit.togglePet(),
			expect: () => [Pet(name: 'Cat', icon: Icons.access_time)],
		);
	});

	group('HomeScreen', () {
		late MockPetCubit mockPetCubit;

		setUp(() {
			mockPetCubit = MockPetCubit();
		});

		testWidgets('displays initial PetTextWidget with Cat', (WidgetTester tester) async {
			when(() => mockPetCubit.state).thenReturn(Pet(name: 'Cat', icon: Icons.access_time));

			await tester.pumpWidget(
				BlocProvider<PetCubit>(
					create: (_) => mockPetCubit,
					child: MaterialApp(home: HomeScreen()),
				),
			);

			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});

		testWidgets('displays PetTextWidget with Dog after toggle', (WidgetTester tester) async {
			whenListen(mockPetCubit, Stream.fromIterable([Pet(name: 'Dog', icon: Icons.person)]), initialState: Pet(name: 'Cat', icon: Icons.access_time));

			await tester.pumpWidget(
				BlocProvider<PetCubit>(
					create: (_) => mockPetCubit,
					child: MaterialApp(home: HomeScreen()),
				),
			);

			await tester.tap(find.text('Cat'));
			await tester.pumpAndSettle();

			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});
	});
}

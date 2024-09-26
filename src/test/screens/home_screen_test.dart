
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:simple_pet_app/screens/home_screen.dart';
import 'package:simple_pet_app/cubits/pet_cubit.dart';
import 'package:simple_pet_app/models/pet_model.dart';

class MockPetCubit extends MockCubit<Pet> implements PetCubit {}

void main() {
	group('HomeScreen Widget Tests', () {
		testWidgets('shows Cat text and icon initially', (WidgetTester tester) async {
			final mockPetCubit = MockPetCubit();
			when(() => mockPetCubit.state).thenReturn(Pet(name: 'Cat', icon: Icons.pets));

			await tester.pumpWidget(
				BlocProvider<PetCubit>(
					create: (_) => mockPetCubit,
					child: MaterialApp(
						home: HomeScreen(),
					),
				),
			);

			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.pets), findsOneWidget);
		});

		testWidgets('shows Dog text and icon when clicked', (WidgetTester tester) async {
			final mockPetCubit = MockPetCubit();
			when(() => mockPetCubit.state).thenReturn(Pet(name: 'Cat', icon: Icons.pets));
			
			await tester.pumpWidget(
				BlocProvider<PetCubit>(
					create: (_) => mockPetCubit,
					child: MaterialApp(
						home: HomeScreen(),
					),
				),
			);

			when(() => mockPetCubit.state).thenReturn(Pet(name: 'Dog', icon: Icons.person));
			when(() => mockPetCubit.togglePet()).thenAnswer((_) {
				mockPetCubit.emit(Pet(name: 'Dog', icon: Icons.person));
			});

			await tester.tap(find.text('Cat'));
			await tester.pump();

			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});
	});
}

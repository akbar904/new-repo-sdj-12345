
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../models/pet_model.dart';

class PetCubit extends Cubit<Pet> {
	PetCubit() : super(Pet(name: 'Cat', icon: Icons.pets));

	void togglePet() {
		if (state.name == 'Cat') {
			emit(Pet(name: 'Dog', icon: Icons.person));
		} else {
			emit(Pet(name: 'Cat', icon: Icons.pets));
		}
	}
}

class Pet {
	final String name;
	final IconData icon;

	Pet({required this.name, required this.icon});

	@override
	List<Object> get props => [name, icon];

	@override
	bool get stringify => true;
}

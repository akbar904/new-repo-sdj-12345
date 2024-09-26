
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_pet_app/widgets/pet_text_widget.dart';
import 'package:simple_pet_app/cubits/pet_cubit.dart';

class HomeScreen extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Simple Pet App'),
			),
			body: Center(
				child: BlocBuilder<PetCubit, Pet>(
					builder: (context, pet) {
						return GestureDetector(
							onTap: () => context.read<PetCubit>().togglePet(),
							child: PetTextWidget(pet: pet),
						);
					},
				),
			),
		);
	}
}

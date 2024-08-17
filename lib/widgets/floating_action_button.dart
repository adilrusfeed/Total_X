import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalx/controller/user_controller.dart';

import 'package:totalx/widgets/add_dialogue_box.dart';

class FloatingActoionWidget extends StatelessWidget {
  const FloatingActoionWidget({
    super.key,
    required this.nameController,
    required this.ageController,
    required this.phoneController,
  });

  final TextEditingController nameController;
  final TextEditingController ageController;
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Consumer<DataController>(
              builder: (context, homePro, child) => AddDialogueBox(
                nameController: nameController,
                ageController: ageController,
                phoneController: phoneController,
                homeProvider: homePro,
              ),
            );
          },
        );
      },
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      shape: const CircleBorder(),
     
      child: const Icon(Icons.add, color: Colors.white),
    );
  }
}

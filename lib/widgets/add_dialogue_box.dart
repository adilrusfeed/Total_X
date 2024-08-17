import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:totalx/controller/user_controller.dart';
import 'package:totalx/widgets/custom_text_field.dart';

class AddDialogueBox extends StatelessWidget {
  const AddDialogueBox({
    super.key,
    required this.nameController,
    required this.ageController,
    required this.phoneController,
    required this.homeProvider,
  });

  final TextEditingController nameController;
  final TextEditingController ageController;
  final TextEditingController phoneController;
  final DataController homeProvider;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 5,
      shadowColor: Colors.red,
      title: const Text("Add User"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: homeProvider.selectedImage != null
                        ? FileImage(
                            File(homeProvider.selectedImage?.path ?? ''))
                        : const AssetImage('assets/download.png')
                            as ImageProvider,
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.black,
                            title: const Text(
                              'Select Image!',
                              style: TextStyle(color: Colors.white),
                            ),
                            actions: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: InkWell(
                                      onTap: () {
                                        homeProvider
                                            .pickImage(ImageSource.camera);
                                        Navigator.pop(context);
                                      },
                                      child: const Icon(
                                        Icons.camera_alt_outlined,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    ),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: InkWell(
                                      onTap: () {
                                        homeProvider
                                            .pickImage(ImageSource.gallery);
                                        Navigator.pop(context);
                                      },
                                      child: const Icon(
                                        Icons.image_outlined,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      height: 35,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.4),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(200),
                          bottomRight: Radius.circular(200),
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            CustomTextField(nameController: nameController, hintText: 'Name'),
            const SizedBox(height: 10),
            CustomTextField(nameController: ageController, hintText: 'Age'),
            const SizedBox(height: 10),
            CustomTextField(nameController: phoneController, hintText: 'Phone'),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.green),
          ),
          onPressed: () {
            // Check if all fields are filled
            if (nameController.text.isEmpty ||
                ageController.text.isEmpty ||
                phoneController.text.isEmpty ||
                homeProvider.selectedImage == null) {
              // Show an alert dialog if any field is missing
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Error"),
                  content: const Text(
                      "All fields including the image must be filled!"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("OK"),
                    ),
                  ],
                ),
              );
              return;
            }

            // Save user data
            homeProvider.addUsersCollection(
              name: nameController.text,
              age: ageController.text,
              phoneNumber: phoneController.text,
              imageFile: homeProvider.selectedImage!,
            );

            // Clear fields
            nameController.clear();
            ageController.clear();
            phoneController.clear();
            homeProvider.selectedImage = null;

            // Close the dialog
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}

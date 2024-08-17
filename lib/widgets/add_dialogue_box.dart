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
    required this.homePro,
  });

  final TextEditingController nameController;
  final TextEditingController ageController;
  final DataController homePro;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Add User's",
      ),
      actions: [
        Center(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: homePro.selectedImage != null
                    ? FileImage(File(homePro.selectedImage?.path ?? ''))
                    : const AssetImage('assets/profile_icon.png') as ImageProvider,
              ),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Select Image'),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  homePro.pickImage(ImageSource.camera);
                                },
                                child: const Icon(Icons.camera_alt_outlined),
                              ),
                              InkWell(
                                onTap: () {
                                  homePro.pickImage(ImageSource.gallery);
                                },
                                child: const Icon(Icons.image_outlined),
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
                          bottomRight: Radius.circular(200))),
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
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.blue)),
              onPressed: () {
                if (homePro.selectedImage == null) {
                  return;
                }else{
                homePro.addUsersCollection(
                  name: nameController.text,
                  age: ageController.text,
                  imageFile: homePro.selectedImage!,
                );
                nameController.clear();
                ageController.clear();
                homePro.selectedImage==null;
                }


                Navigator.pop(context);
              },
              child: Text(
                'Save',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

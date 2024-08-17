import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalx/controller/user_controller.dart';
import 'package:totalx/model/user_model.dart';

class DeleteWidget extends StatelessWidget {
  const DeleteWidget({
    super.key,
    required this.user,
  });

  final AppModel user;

  @override
  Widget build(BuildContext context) {
    // final imageprovider = Provider.of<ImagesProvider>(context);
    final homeController = Provider.of<DataController>(context);

    return AlertDialog(
      title: const Text('Delete User'),
      content: const Text('Are you sure you want to delete this user?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(context);
            try {
              await homeController.deleteUser(user.id!);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('User deleted successfully')),
              );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error deleting user: $e')),
              );
            }
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}

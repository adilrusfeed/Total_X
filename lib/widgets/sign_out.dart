import 'package:flutter/material.dart';
import 'package:totalx/service/auth_service.dart';

void signOutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Sign Out"),
        content: const Text("Are you sure you want to sign out?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop(); // Close the dialog
              await AuthService().signOut(context); // Proceed with sign out
            },
            child: const Text("Sign Out"),
          ),
        ],
      );
    },
  );
}

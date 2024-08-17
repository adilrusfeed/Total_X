import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalx/controller/user_controller.dart';

PopupMenuItem<String> sortItem(
    String value, String text, BuildContext context) {
  return PopupMenuItem<String>(
    value: value,
    child: Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: Provider.of<DataController>(context, listen: false)
              .selectedFilter,
          activeColor: Colors.blue,
          onChanged: (value) {
            Provider.of<DataController>(context, listen: false)
                .setFilter(value!);
          },
        ),
        Text(text),
      ],
    ),
  );
}

import 'package:ebtik_tok/core/extensions.dart';
import 'package:flutter/material.dart';

class ExitDialog extends StatelessWidget {
  const ExitDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Exit App'),
        content: const Text('Do you want to exit the ebtik_tok app?'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).closeApp();
            },
            child: const Text('Exit'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Back'),
          ),
        ],
      );
  }
}
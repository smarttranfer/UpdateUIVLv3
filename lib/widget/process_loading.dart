import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReconnectingOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularProgressIndicator(),
        SizedBox(height: 12),
        Text(
          'Loading...',
        ),
      ],
    ),
  );
}
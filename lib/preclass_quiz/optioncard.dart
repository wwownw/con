import 'package:flutter/material.dart';
import 'constants.dart';

class OptionCard extends StatelessWidget {
  const OptionCard(
      {Key? key,
      required this.option,
      required this.color,
      required this.onTap})
      : super(key: key);
  final String option;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              option,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:heat_is_on_flutter/constants/app_colors.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      color: primaryColorLight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              '© 2024 Heat is On',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'Privacy Policy',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'Terms of Service',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

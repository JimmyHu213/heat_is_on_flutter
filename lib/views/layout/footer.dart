import 'package:flutter/material.dart';
import 'package:heat_is_on_flutter/constants/app_colors.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 8, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset('assets/images/utas.png', height: 60),
                Image.asset('assets/images/cms.png', height: 60),
                Image.asset('assets/images/est.png', height: 60),
                Image.asset('assets/images/coh.png', height: 100),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '© 2024 Heat is On',
                  style: TextStyle(color: primaryColor),
                ),
                Text(
                  'Privacy Policy',
                  style: TextStyle(color: primaryColor),
                ),
                Text(
                  'Terms of Service',
                  style: TextStyle(color: primaryColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

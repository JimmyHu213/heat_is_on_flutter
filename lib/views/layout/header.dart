import 'package:flutter/material.dart';
import 'package:heat_is_on_flutter/constants/app_colors.dart';
import 'package:heat_is_on_flutter/views/controls/control_view.dart';
import 'package:heat_is_on_flutter/views/intro/intro_view.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        actions: [
          IconButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            icon: const Icon(
              Icons.info_outline,
              size: 40,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const IntroView()),
              );
            },
            tooltip: 'Information',
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ControlView()));
            },
            tooltip: 'Admin Control',
            icon: const Icon(Icons.person_2_outlined, size: 40),
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.white)),
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/web-banner.png'),
                fit: BoxFit.fill),
            //border: Border.all(color: Colors.red, width: 3),
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
        ),
        backgroundColor: primaryColor,
        elevation: 0);
  }
}

import 'package:flutter/material.dart';
import 'package:heat_is_on_flutter/constants/app_colors.dart';
import 'package:heat_is_on_flutter/widgets/center_view.dart';

class IntroView extends StatelessWidget {
  const IntroView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const Text(
          'Introduction',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: CenterView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            const Text(
              'Welcome to the Heat is On App',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'This app is designed to help you understand the impact of climate change on your community. You can use the app to explore the potential risks and plan for the future.',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            const Text(
              'The app provides information on the potential risks of climate change in your area. You can use the app to explore the potential risks and plan for the future.',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            const Text(
              'The app provides information on the potential risks of climate change in your area. You can use the app to explore the potential risks and plan for the future.',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back'),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:heat_is_on_flutter/constants/app_colors.dart';

class MobilePage extends StatelessWidget {
  const MobilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: primaryColor, // Using the green color you specified
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.phone_android,
                  size: 100,
                  color: Colors.white70,
                ),
                SizedBox(height: 24),
                Text(
                  'Mobile Access Unavailable',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Text(
                  'We apologize, but this application is not currently available on mobile devices/screen size.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                // ElevatedButton.icon(
                //   icon: const Icon(Icons.computer),
                //   label: const Text('Use Desktop Version'),
                //   style: ElevatedButton.styleFrom(
                //     foregroundColor: const Color(0xFF006341),
                //     backgroundColor: Colors.white,
                //     padding: const EdgeInsets.symmetric(
                //         horizontal: 24, vertical: 12),
                //   ),
                //   onPressed: () {
                //     // Add logic to direct to desktop version or show more info
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

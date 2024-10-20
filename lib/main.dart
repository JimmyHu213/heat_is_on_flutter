import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:heat_is_on_flutter/constants/config.dart' as config;
import 'package:heat_is_on_flutter/constants/app_colors.dart';
import 'package:heat_is_on_flutter/model/town.dart';
import 'package:heat_is_on_flutter/views/layout/layout_template.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('Initialized Firebase $app');
  runApp((const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TownModel()),
      ],
      child: MaterialApp(
        title: config.TITLE,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: primaryColor,
              primary: primaryColor,
              secondary: secondaryColor),
          useMaterial3: true,
        ),
        //home: const Contr PolView()
        home: const LayOutTemplate(),
      ),
    );
  }
}

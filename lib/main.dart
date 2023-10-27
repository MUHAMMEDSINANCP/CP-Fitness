import 'package:cp_fitness_app/view/on_boarding/started_view.dart';
import 'package:flutter/material.dart';

import 'common/colo_extension.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CP Fitness App',
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(primaryColor: TColor.primaryColor1, fontFamily: "Poppins"),
      home: const StartedView(),
    );
  }
}

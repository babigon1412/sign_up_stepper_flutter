import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stepper_flutter/pages/home_page.dart';
import 'package:stepper_flutter/pages/users_page.dart';
import 'package:stepper_flutter/providers/stepper_providers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MaterialColor mycolor = const MaterialColor(
      0xFF345c66,
      <int, Color>{
        50: Color(0xFF345c66),
        100: Color(0xFF345c66),
        200: Color(0xFF345c66),
        300: Color(0xFF345c66),
        400: Color(0xFF345c66),
        500: Color(0xFF345c66),
        600: Color(0xFF345c66),
        700: Color(0xFF345c66),
        800: Color(0xFF345c66),
        900: Color(0xFF345c66),
      },
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StepperProvider())
      ],
      child: MaterialApp(
        title: 'Stepper App',
        theme: ThemeData(primarySwatch: mycolor),
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );
  }
}

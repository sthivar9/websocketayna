import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:websocketayna/bloc/login_bloc.dart';
import 'package:websocketayna/bloc/register_bloc.dart';
import 'package:websocketayna/firebase_options.dart';
import 'package:websocketayna/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LoginBloc>(create: (context) => LoginBloc()),
        Provider<RegisterBloc>(create: (context) => RegisterBloc()),
      ],
      child: const MaterialApp(
        title: 'Flutter Demo',
        home: MainPage(),
      ),
    );
  }
}

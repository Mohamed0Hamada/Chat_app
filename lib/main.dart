import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folder/firebase_options.dart';
import 'package:folder/pages/chat_page.dart';
import 'package:folder/pages/cubits/chat_cubit/chat_cubit.dart';
import 'package:folder/pages/cubits/login_cubit.dart';
import 'package:folder/pages/cubits/register_cubit.dart';
import 'package:folder/pages/login_page.dart';
import 'package:folder/pages/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => ChatCubit()),
      ],
      child: MaterialApp(
        routes: {
          LoginPage.id: (context) => LoginPage(),
          RegisterPage.id: (context) => RegisterPage(),
          ChatPage.id: (context) => ChatPage(),
        },
        initialRoute: LoginPage.id,

        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
    );
  }
}

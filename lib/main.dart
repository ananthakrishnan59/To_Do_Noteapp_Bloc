import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_note_bloc/Bloc/note_bloc.dart';
import 'package:to_do_note_bloc/Presentation/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NoteBloc(),
        )
      ],
      child: MaterialApp(
          title: 'My Note',
          theme: ThemeData(
              fontFamily: 'poppins',
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory),
          debugShowCheckedModeBanner: false,
          home: const HomePage()),
    );
  }
}

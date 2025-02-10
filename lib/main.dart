import 'dart:developer';
import 'dart:html' as html;
import 'package:assignment/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart'
    if (dart.library.html) 'dart:ui' as ui;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/image_cubit.dart';

void main() {
  runApp(const MyApp());
}

/// The root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ImageCubit(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Web Image Viewer',
        home: HomePage(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/image_cubit.dart';
import '../../cubit/image_state.dart';

/// A widget that displays an image loaded from a URL using [ImageCubit].
///
/// This widget listens to the `ImageCubit` state and updates the UI based on:
/// - [ImageLoaded]: Displays the image inside an `HtmlElementView`.
/// - [ImageError]: Displays an error message if the image fails to load.
/// - Default (Initial/Loading): Shows a placeholder message instructing users to enter an image URL.
class ImageViewer extends StatelessWidget {
  const ImageViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageCubit, ImageState>(
      builder: (context, state) {
        if (state is ImageLoaded) {
          return HtmlElementView(viewType: state.viewType);
        } else if (state is ImageError) {
          return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
        } else {
          return const Center(child: Text("Enter URL to load image"));
        }
      },
    );
  }
}

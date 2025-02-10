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

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   final TextEditingController _urlController = TextEditingController();
//   String? _imageUrl;
//   OverlayEntry? _overlayEntry;
//   bool _isMenuOpen = false;
//
//   void _showImage() {
//     setState(() {
//       _imageUrl = _urlController.text;
//       log('_imageUrl::: $_imageUrl');
//
//       if (_imageUrl != null && _imageUrl!.isNotEmpty) {
//         String viewType = 'image-view-${DateTime.now().millisecondsSinceEpoch}';
//
//         ui.platformViewRegistry.registerViewFactory(
//           viewType,
//           (int viewId) {
//             final imgElement = html.ImageElement()
//               ..src = _imageUrl!
//               ..style.width = '100%'
//               ..style.height = '100%'
//               ..style.borderRadius = '12px'; // Optional styling
//
//             return imgElement;
//           },
//         );
//
//         setState(() {
//           _currentViewType = viewType;
//         });
//       }
//     });
//   }
//
//   String _currentViewType = 'image-view';
//
//   void _toggleFullScreen() {
//     final element = html.document.documentElement;
//     if (html.document.fullscreenElement == null) {
//       element?.requestFullscreen();
//     } else {
//       html.document.exitFullscreen();
//     }
//   }
//
//   void _toggleContextMenu(BuildContext context) {
//     if (_isMenuOpen) {
//       _closeContextMenu();
//     } else {
//       _openContextMenu(context);
//     }
//   }
//
//   void _openContextMenu(BuildContext context) {
//     final overlayState = Overlay.of(context);
//     final renderBox = context.findRenderObject() as RenderBox?;
//     final position = renderBox?.localToGlobal(Offset.zero) ?? Offset.zero;
//
//     _overlayEntry = OverlayEntry(
//       builder: (context) {
//         return Stack(
//           children: [
//             GestureDetector(
//               onTap: _closeContextMenu,
//               child: Container(
//                 color: Colors.black54,
//                 width: double.infinity,
//                 height: double.infinity,
//               ),
//             ),
//             Positioned(
//               right: 16,
//               bottom: 80,
//               child: Material(
//                 color: Colors.white,
//                 elevation: 4,
//                 borderRadius: BorderRadius.circular(8),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     _menuItem("Enter Fullscreen", () {
//                       _toggleFullScreen();
//                       _closeContextMenu();
//                     }),
//                     _menuItem("Exit Fullscreen", () {
//                       _toggleFullScreen();
//                       _closeContextMenu();
//                     }),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//
//     overlayState.insert(_overlayEntry!);
//     _isMenuOpen = true;
//   }
//
//   Widget _menuItem(String text, VoidCallback onTap) {
//     return InkWell(
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         child: Text(text, style: const TextStyle(fontSize: 16)),
//       ),
//     );
//   }
//
//   void _closeContextMenu() {
//     _overlayEntry?.remove();
//     _overlayEntry = null;
//     _isMenuOpen = false;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Flutter Web Image Viewer")),
//       body: Padding(
//         padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Expanded(
//               child: AspectRatio(
//                 aspectRatio: 1,
//                 child: GestureDetector(
//                   onDoubleTap: _toggleFullScreen,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.grey,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: _imageUrl != null && _imageUrl!.isNotEmpty
//                         ? HtmlElementView(
//                             viewType: _currentViewType,
//                           )
//                         : const Center(child: Text("Enter URL to load image")),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 8),
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _urlController,
//                     decoration: const InputDecoration(hintText: 'Image URL'),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: _showImage,
//                   child: const Padding(
//                     padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
//                     child: Icon(Icons.arrow_forward),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 64),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _toggleContextMenu(context),
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

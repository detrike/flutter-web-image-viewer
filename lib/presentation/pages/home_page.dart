import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/image_cubit.dart';
import '../widgets/image_viewer.dart';
import 'dart:html' as html;

/// The main home page containing the UI for image input and display.
///
/// This page allows users to input an image URL, display the image,
/// and toggle fullscreen mode via a context menu.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Controller for managing the text input field.
  final TextEditingController _urlController = TextEditingController();

  /// Tracks whether the context menu is open.
  bool _isMenuOpen = false;

  /// Overlay entry for displaying the context menu.
  OverlayEntry? _overlayEntry;

  /// Loads the image from the given URL using [ImageCubit].
  ///
  /// Retrieves the text from [_urlController], trims any whitespace,
  /// and triggers the [ImageCubit] to load the image.
  void _loadImage(BuildContext context) {
    final imageUrl = _urlController.text.trim();
    context.read<ImageCubit>().loadImage(imageUrl);
  }

  /// Toggles the browser's fullscreen mode.
  ///
  /// If the document is not in fullscreen mode, it requests fullscreen.
  /// Otherwise, it exits fullscreen.
  void _toggleFullScreen() {
    final element = html.document.documentElement;
    if (html.document.fullscreenElement == null) {
      element?.requestFullscreen();
    } else {
      html.document.exitFullscreen();
    }
  }

  /// Toggles the visibility of the context menu.
  ///
  /// Opens or closes the overlay containing the fullscreen options.
  void _toggleContextMenu(BuildContext context) {
    if (_isMenuOpen) {
      _closeContextMenu();
    } else {
      _openContextMenu(context);
    }
  }

  /// Opens the context menu as an overlay.
  ///
  /// The menu provides options for entering and exiting fullscreen mode.
  void _openContextMenu(BuildContext context) {
    final overlayState = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox?;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            GestureDetector(
              onTap: _closeContextMenu,
              onDoubleTap: _toggleFullScreen,
              child: Container(
                color: Colors.black54,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Positioned(
              right: 16,
              bottom: 80,
              child: Material(
                color: Colors.white,
                elevation: 4,
                borderRadius: BorderRadius.circular(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _menuItem("Enter Fullscreen", () {
                      _toggleFullScreen();
                      _closeContextMenu();
                    }),
                    _menuItem("Exit Fullscreen", () {
                      _toggleFullScreen();
                      _closeContextMenu();
                    }),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );

    overlayState.insert(_overlayEntry!);
    _isMenuOpen = true;
  }

  /// Creates a menu item for the context menu.
  ///
  /// - [text]: The label of the menu item.
  /// - [onTap]: The function to execute when the item is tapped.
  Widget _menuItem(String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Text(text, style: const TextStyle(fontSize: 16)),
      ),
    );
  }

  /// Closes the context menu overlay.
  void _closeContextMenu() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _isMenuOpen = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flutter Web Image Viewer")),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
        child: Column(
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: GestureDetector(
                  onDoubleTap: _toggleFullScreen,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const ImageViewer(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _urlController,
                    decoration: const InputDecoration(hintText: 'Image URL'),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _loadImage(context),
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                    child: Icon(Icons.arrow_forward),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 64),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _toggleContextMenu(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

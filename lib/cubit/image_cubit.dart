import 'package:bloc/bloc.dart';
import 'dart:html' as html;
import 'image_state.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart'
if (dart.library.html) 'dart:ui' as ui;

/// A [Cubit] responsible for managing image loading state in a Flutter web application.
///
/// This cubit handles:
/// - **Image Initialization**: Starts with an initial state.
/// - **Image Loading**: Takes a URL and dynamically registers an HTML `<img>` element.
/// - **Error Handling**: Emits an error state if the URL is empty.
///
/// The UI listens to this cubit and updates accordingly.
class ImageCubit extends Cubit<ImageState> {
  ImageCubit() : super(ImageInitial());

  /// Loads a new image from the provided [url].
  ///
  /// - If the [url] is empty, it emits an [ImageError] state with an appropriate message.
  /// - Otherwise, it dynamically creates a unique `viewType` and registers an
  ///   `HtmlElementView` with the Flutter Web engine.
  ///
  /// The [ImageLoaded] state is then emitted with the generated `viewType` for UI display.
  ///
  /// Example:
  /// ```dart
  /// context.read<ImageCubit>().loadImage("https://example.com/image.jpg");
  /// ```
  void loadImage(String url) {
    if (url.isEmpty) {
      emit(ImageError('Image URL cannot be empty.'));
      return;
    }

    final viewType = 'image-view-${DateTime.now().millisecondsSinceEpoch}';

    // Registers a new image view dynamically.
    ui.platformViewRegistry.registerViewFactory(
      viewType,
          (int viewId) => html.ImageElement()
        ..src = url
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.borderRadius = '12px',
    );

    // Emits an [ImageLoaded] state with the registered `viewType` for UI rendering.
    emit(ImageLoaded(viewType));
  }
}

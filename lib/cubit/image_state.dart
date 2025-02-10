import 'package:equatable/equatable.dart';

/// Base class for different image states.
abstract class ImageState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Initial state when no image is loaded.
class ImageInitial extends ImageState {}

/// State when an image is successfully loaded.
class ImageLoaded extends ImageState {
  final String viewType;

  ImageLoaded(this.viewType);

  @override
  List<Object?> get props => [viewType];
}

/// State when an error occurs.
class ImageError extends ImageState {
  final String message;

  ImageError(this.message);

  @override
  List<Object?> get props => [message];
}

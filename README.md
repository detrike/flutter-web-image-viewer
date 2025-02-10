# flutter-web-image-viewer
A lightweight Flutter web application for viewing images from URLs using Cubit for state management.

📷 Flutter Web Image Viewer
A lightweight Flutter web application for viewing images from URLs using Cubit for state management.

🚀 Features
Load Images Dynamically: Enter an image URL to view it instantly.
State Management with Cubit: Efficient and clean architecture using flutter_bloc.
Full-Screen Mode: Double-tap on the image or use the context menu to enter full-screen mode.
Error Handling: Displays an error message if the URL is invalid or empty.
Responsive UI: Works across different screen sizes with a clean, modern UI.

🛠️ Tech Stack
Flutter Web 🌐
Cubit (flutter_bloc) 🏗️
HTML DOM Integration (dart:html) 🖼️

📂 Project Structure
/lib
│── main.dart              # Entry point of the app
│── /cubit
│   ├── image_cubit.dart   # Handles image loading state
│   ├── image_state.dart   # Defines various states (Initial, Loaded, Error)
│── /ui
│   ├── home_page.dart     # Main screen with input and image display
│   ├── image_viewer.dart  # Widget to display the loaded image
│── /widgets
│   ├── context_menu.dart  # Floating context menu for full-screen toggle

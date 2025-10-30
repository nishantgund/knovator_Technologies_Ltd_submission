# Knovator App

A Flutter-based mobile application to view posts with offline storage, pagination, and detailed post view functionality.

---

## **Table of Contents**

- [Project Overview](#project-overview)
- [Features](#features)
- [Architecture & Design Choices](#architecture--design-choices)
- [Third-Party Libraries / Dependencies](#third-party-libraries--dependencies)
- [Why Hive and Pagination](#why-hive-and-pagination)
- [Installation & Running the App](#installation--running-the-app)

---

## **Project Overview**

The Knovator App is a Flutter application that fetches posts from an API, stores them locally using Hive, and displays them with a smooth user interface. Users can:

- View a list of posts
- See detailed post content
- Mark posts as read
- Scroll through posts with pagination to improve performance

---

## **Features**

- **Hive Database Integration**: Stores posts locally for offline access.
- **Pagination / Infinite Scrolling**: Fetches posts in chunks to improve performance and reduce network load.
- **Offline Caching**: Previously loaded posts are stored in Hive and instantly available.
- **Post Read Status**: Posts can be marked as read, changing the UI appearance.
- **Detailed Post View**: Tap on a post to see its full content.
- **Dark Themed UI**: Modern dark theme for better visual comfort.
- **Loading Indicators**: Shows a progress indicator while fetching data.
- **Smooth State Management**: Uses GetX for reactive UI updates.
- **Splash Screen & App Icon**: Added using `flutter_native_splash` and `flutter_launcher_icons`.

---

## **Architecture & Design Choices**

1. **State Management**: GetX is used for reactive programming and simple state management.
2. **Local Storage**: Hive is chosen for its lightweight, fast, and offline-ready NoSQL database capabilities.
3. **Networking**: `http` package is used to fetch posts from a REST API.
4. **Pagination**: Posts are fetched in chunks using limit and skip parameters to improve performance and avoid loading all posts at once.
5. **Separation of Concerns**: Controllers (`PostListController`, `PostDetailController`) handle logic and API calls, while UI widgets only handle presentation.

---

## **Third-Party Libraries / Dependencies**

- `get: ^4.6.5` → State management and routing
- `hive: ^2.2.3` → Local database
- `hive_flutter: ^1.1.0` → Hive integration with Flutter
- `http: ^1.1.0` → API calls
- `cupertino_icons: ^1.0.8` → iOS-style icons
- `flutter_lints: ^5.0.0` → Linting rules for cleaner code
- `hive_generator: ^1.1.0` → Code generation for Hive type adapters
- `build_runner: ^2.3.3` → Code generation
- `flutter_native_splash: ^2.4.0` → Splash screen customization
- `flutter_launcher_icons: ^0.14.1` → App icon customization

---

## **Why Hive and Pagination?**

- **Hive**:
    - Provides **fast, key-value local storage**, ideal for Flutter apps.
    - Enables **offline access** to previously fetched posts.
    - Reduces network calls and improves app responsiveness.

- **Pagination**:
    - Loads posts in chunks (30 at a time) instead of all at once.
    - Reduces memory usage and improves performance.
    - Provides smooth scrolling and better user experience.

---

## **Installation & Running the App**

1. **Clone the repository**:


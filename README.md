# Hilcom - Flutter E-commerce

A high-fidelity, responsive e-commerce dashboard built with Flutter, following Clean Architecture principles. This project is a high-quality e-commerce platform, optimized for both Web and Mobile.

## 🚀 Features

-   **Clean Architecture**: Organized into features with clear separation of concerns (Presentation, Domain, Core).
-   **Responsive Design**: Seamlessly transitions between Mobile and Web interfaces using custom breakpoints.
-   **State Management**: Powered by `Provider` for efficient and scalable state handling.
-   **Navigation**: Implemented using `GoRouter` for declarative routing.
-   **Theming**: Custom theme using `Quicksand` for headings and `Lato` for body text, matching the Hilcom branding.
-   **Dynamic UI**: 
    -   Featured Categories scrollable list.
    -   Popular Products grid with badges and hover-ready layouts.
    -   Responsive Hero section with email subscription.
    -   Comprehensive multi-column footer for Web.

## 🛠️ Tech Stack

-   **Framework**: [Flutter](https://flutter.dev)
-   **State Management**: [Provider](https://pub.dev/packages/provider)
-   **Routing**: [GoRouter](https://pub.dev/packages/go_router)
-   **Fonts**: [Google Fonts](https://pub.dev/packages/google_fonts)
-   **Images**: [Cached Network Image](https://pub.dev/packages/cached_network_image)

## 📁 Project Structure

```text
lib/
├── config/
│   └── router/               # Navigation configuration (GoRouter)
├── core/
│   └── theme/                # Global styles, colors, and theme data
├── features/
│   └── home/                 # Home feature
│       ├── domain/
│       │   └── models/       # Data entities (Product, Category)
│       └── presentation/
│           ├── pages/        # UI Pages (Responsive HomePage)
│           ├── providers/    # State management logic
│           └── widgets/      # Reusable UI components (ProductCard, etc.)
└── main.dart                 # App entry point & Provider setup
```

## 🏁 Getting Started

### Prerequisites

-   Flutter SDK: `^3.10.7`
-   Dart SDK: `^3.10.7`

### Installation

1.  Clone the repository.
2.  Install dependencies:
    ```bash
    flutter pub get
    ```
3.  Run the application:
    ```bash
    flutter run
    ```

---
Developed as a showcase of Clean Architecture and Responsive UI in Flutter.

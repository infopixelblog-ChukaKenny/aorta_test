# Architecture Overview
This document serves as a critical, living template designed to equip agents with a rapid and comprehensive understanding of the codebase's architecture, enabling efficient navigation and effective contribution from day one. Update this document as the codebase evolves.

## 1. Project Structure
This section provides a high-level overview of the project's directory and file structure, categorised by architectural layer or major functional area. It is essential for quickly navigating the codebase, locating relevant files, and understanding the overall organization and separation of concerns.

[Project Root]/
```text
[Project Root]/
├── lib/                      # Main source code for the Flutter application
│   ├── core/                 # Core functionalities, common utilities, network setup
│   │   ├── navigation/       # App navigation configurations, routes, and interceptors
│   │   ├── di/               # Global dependency injections
│   │   ├── theme/            # App theme, colors, material theme, etc.
│   │   └── utils/            # Utility functions
│   ├── data/                 # Data layer (repositories, data sources - local/remote)
│   │   ├── local/            # Local data sources (database, shared preferences)
│   │   ├── datasources/      # Remote data sources (API clients)
│   │   ├── repositories/     # Repository implementations
│   │   ├── banking_service/  # Core banking service functions
│   │   └── dto/              # Data models for serialization/deserialization
│   ├── features/             # Feature-specific modules
│   │   ├── [feature_name]/   # Individual feature module
│   │   │   ├── di/           # Dependencies layer for the feature
│   │   │   ├── domain/       # Domain layer for the feature
│   │   │   └── presentation/ # Presentation layer (UI, BLoC/Provider/Riverpod)
│   └── main.dart             # Application entry point
├── assets/                   # Static assets (images, fonts, etc.)
├── test/                     # Unit and widget tests
├── pubspec.yaml              # Project dependencies and metadata
├── README.md                 # Project overview and quick start guide
└── ARCHITECTURE.md           # This document
```

## 2. High-Level System Diagram
The `aorta` application is a sample test application for simulating real life transactions with account to network unreliability

[User] <--> [aorta Mobile App] <--> [Banking Service API]
                      |
                      +--> [Local Database/Drift]
                      |
                      +--> [Local Secure Storage]

## 3. Core Components
Auto Route for Navigation
Material Components
Bloc for state management


### 4. Local Secure Storage

Name: Secure Key-Value Storage

Type: Key-Value Store (`get_secure_storage`)

Purpose: Stores sensitive information such as authentication tokens or user preferences securely on the device.

## 5. Future Considerations / Roadmap

"Implement push notifications for transaction alerts."
"Encrypting locally stored transactions."


## 6. Project Identification

Project Name: aorta

Repository URL: https://github.com/TuleSimon/aorta_test

Primary Contact/Team: Tule Simon

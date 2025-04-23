# 🚀 Flutter Auth App with Clean Architecture & GetX

This is a Flutter project implementing **Firebase Authentication** using **Clean Architecture** and **GetX** for state management and navigation.

---

## 📦 Project Structure

```
lib/
│
├── core/               # App-wide constants, services, regex, utilities
├── data/               # API + Firebase implementation (models, repositories)
│   └── models/
│   └── repositories/
│
├── domain/             # Pure logic (entities, repositories, usecases)
│   └── entities/
│   └── repositories/
│   └── usecases/
│
├── controller/         # GetX controllers for each screen (UI logic)
├── presentation/       # UI screens and widgets
│   └── pages/
│
├── routes/             # GetX route definitions
├── bindings/           # Bindings that inject dependencies
└── main.dart           # App entry point
```

---

## 🔐 Features

- ✅ Firebase Email & Password Authentication
- ✅ Clean Architecture (separation of concerns)
- ✅ GetX for state management, routing, and DI
- ✅ Form validation
- ✅ Deep linking support
- ✅ Reactive UI with loading states
- ✅ Modular and scalable project structure

---

## 🧠 Technologies Used

- [Flutter](https://flutter.dev/)
- [Firebase Auth](https://firebase.flutter.dev/)
- [GetX](https://pub.dev/packages/get)

---

## 🧰 Setup Instructions

### 🔧 Prerequisites

- Flutter SDK installed
- Firebase project set up
- Android/iOS setup completed

### 📥 Clone the Repo

```bash
git clone https://github.com/your-username/flutter-auth-app.git
cd flutter-auth-app
```

### 🔥 Firebase Setup

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a project
3. Add Android/iOS app
4. Download `google-services.json` or `GoogleService-Info.plist`
5. Place them in your project under `android/app/` or `ios/Runner/`
6. Enable **Email/Password Authentication** in Firebase Auth

### 📦 Install Dependencies

```bash
flutter pub get
```

### 🚀 Run the App

```bash
flutter run
```

---

## ✨ Screens Included

- 🔐 **Login Screen** with validation and error handling
- 📝 **Register Screen** with password confirmation and terms checkbox
- 🏠 **Main Navigation Screen** post-authentication

---

## 📚 Clean Architecture Layers

| Layer        | Role                                  | Example Files              |
|--------------|----------------------------------------|----------------------------|
| **Domain**   | Business rules, logic, entities        | `login_usecase.dart`, `user_entity.dart` |
| **Data**     | Firebase Auth logic, API calls         | `auth_repository_impl.dart`, `user_model.dart` |
| **Controller** | UI logic and state using GetX         | `login_controller.dart`, `register_controller.dart` |
| **Presentation** | Widgets and UI screens              | `login_screen.dart`, `register_screen.dart` |

---

## 🤝 Contributing

Contributions are welcome! Open an issue or submit a pull request for suggestions or improvements.

---

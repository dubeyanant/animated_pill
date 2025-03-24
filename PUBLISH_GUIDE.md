# Pub.dev Package Publishing Guide

A step-by-step guide to **publishing** and **updating** Dart/Flutter packages on [pub.dev](https://pub.dev).

---

## 🎟 **First-Time Publishing**

### **1. Prerequisites**

- A [Google account](https://accounts.google.com) (for `dart pub login`).
- A Dart/Flutter package with a valid `pubspec.yaml`.

### **2. Package Setup**

Ensure your project has this structure:

```
my_package/
├── lib/
│   └── my_package.dart   # Main library file
├── test/                 # Tests (recommended)
├── example/              # Example app (recommended)
├── README.md             # Documentation
├── CHANGELOG.md          # Version history (optional)
├── LICENSE               # Required (e.g., MIT, Apache 2.0)
└── pubspec.yaml          # Metadata & dependencies
```

### **3. Configure **``

```yaml
name: my_awesome_package  # Lowercase, underscores
version: 1.0.0            # Follow semver (e.g., 1.0.0)
description: "A package that does something awesome."
homepage: "https://github.com/yourname/my_awesome_package"
repository: "https://github.com/yourname/my_awesome_package.git"

environment:
  sdk: ">=2.17.0 <3.0.0"  # Adjust for Dart/Flutter compatibility

dependencies:
  flutter:
    sdk: flutter
```

### **4. Required Files**

| File           | Purpose                                    |
| -------------- | ------------------------------------------ |
| `README.md`    | Explain usage, installation, and examples. |
| `LICENSE`      | **Mandatory** (e.g., `MIT`, `Apache 2.0`). |
| `CHANGELOG.md` | Track changes (optional but recommended).  |

### **5. Verify Before Publishing**

```sh
# Format code
dart format .

# Analyze for errors
dart analyze

# Run tests
flutter test

# Dry-run (check for issues)
dart pub publish --dry-run
```

### **6. Publish to pub.dev**

```sh
# Log in (opens browser)
dart pub login

# Publish
dart pub publish
```

- Confirm with `y` when prompted.
- Visit your package at: `https://pub.dev/packages/<your_package_name>`

---

## 🔄 **Updating an Existing Package**

### **1. Update the Version**

Increment in `pubspec.yaml` following **semver**:

- **Patch (**``**)** for bug fixes.
- **Minor (**``**)** for new features (backward-compatible).
- **Major (**``**)** for breaking changes.

Example:

```yaml
version: 1.0.1  # Updated from 1.0.0
```

### **2. Update **``

```markdown
## [1.0.1] - 2024-05-20
### Added
- New `validateInput()` helper.
### Fixed
- Crash in `calculate()` method.
```

### **3. Publish the Update**

```sh
# Format code
dart format .

# Analyze for errors
dart analyze

# Run tests
flutter test

# Run checks
dart pub publish --dry-run

# Publish
dart pub publish
```

### **4. Verify Update**

- Check the **"Versions"** tab on your package’s pub.dev page.

---

## ⚠️ **Important Notes**

- **Never delete/modify published versions** (pub.dev immutable).
- **Breaking changes?** Major version bump (`2.0.0`).
- **Promote your package**: Share in Flutter communities!

---

## 📝 **License**

Include a `LICENSE` file (e.g., MIT):

```
Copyright (c) 2024 Your Name

Permission is hereby granted...
```

---

🚀 **Happy Publishing!**


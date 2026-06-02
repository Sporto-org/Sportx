# Sportx

A modern iOS application for managing and tracking sports activities, built with Swift and Xcode.

## 📋 Table of Contents

- [About](#about)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Requirements](#requirements)
- [Installation](#installation)
- [Project Structure](#project-structure)
- [Usage](#usage)
- [Testing](#testing)
- [Contributing](#contributing)
- [License](#license)

## About

Sportx is a comprehensive sports management application designed to help users organize, track, and manage their sports activities efficiently. Built entirely in Swift, it leverages modern iOS frameworks to deliver a smooth and intuitive user experience.

## Features

- 🏃 Activity tracking and management
- 📊 Statistics and analytics
- 🎯 Goal setting and progress monitoring
- 📱 Native iOS experience with SwiftUI/UIKit
- ⚡ Fast and responsive performance
- 🔒 Secure data management

## Tech Stack

### Language & Platform
- **Swift** (95.2% of codebase) - Modern, safe programming language
- **iOS** - Native Apple platform

### Development Tools
- **Xcode** - Official IDE for iOS development
- **SwiftUI/UIKit** - Native UI frameworks (determined by project structure)
- **Foundation** - Core iOS frameworks

### Testing
- **XCTest** - Native testing framework for unit and UI tests
- **Unit Tests** (SportXTests target)
- **UI Tests** (SportXUITests target)

### Version Control & Collaboration
- **Git** - Version control system
- **GitHub** - Repository hosting and collaboration platform

### Additional Technologies
- **Cocoa Touch** - Core iOS application framework
- **CoreData** or similar - Data persistence (if applicable)

## Requirements

### System Requirements
- **macOS** 12.0 or later
- **Xcode** 14.0 or later
- **iOS Deployment Target** 14.0 or later (typical for modern Swift projects)
- **Swift** 5.7 or later

### Development Environment
- An Apple Developer Account (for device testing and deployment)
- Git installed on your system

## Installation

### Step 1: Clone the Repository

```bash
git clone https://github.com/Sporto-org/Sportx.git
cd Sportx
```

### Step 2: Open the Project

Open the Xcode project file:

```bash
open SportX.xcodeproj
```

### Step 3: Install Dependencies (if applicable)

If the project uses CocoaPods or Swift Package Manager:

**For CocoaPods:**
```bash
pod install
open SportX.xcworkspace
```

**For Swift Package Manager:**
Dependencies should be resolved automatically by Xcode.

### Step 4: Configure Your Development Setup

1. Select a target device or simulator in Xcode
2. Ensure the correct Team ID is configured in the project settings
3. Update any configuration files with your specific environment variables (if needed)

### Step 5: Build and Run

```bash
# Using Xcode
⌘ + B  (Build)
⌘ + R  (Run)
```

Or from the command line:

```bash
xcodebuild -scheme SportX -destination 'generic/platform=iOS Simulator'
xcodebuild -scheme SportX -destination 'platform=iOS Simulator,name=iPhone 15' test
```

## Project Structure

```
Sportx/
├── SportX.xcodeproj/          # Xcode project configuration
├── SportX/                     # Main application target
│   ├── AppDelegate.swift       # App lifecycle management
│   ├── SceneDelegate.swift     # Scene lifecycle (iOS 13+)
│   ├── Controllers/            # View controllers or SwiftUI views
│   ├── Models/                 # Data models
│   ├── Views/                  # UI components
│   ├── Services/               # Business logic and API services
│   ├── Resources/              # Assets, strings, configurations
│   └── Supporting Files/       # Info.plist, etc.
├── SportXTests/                # Unit tests
│   ├── Models Tests/           # Model testing
│   ├── Services Tests/         # Service layer testing
│   └── Utilities Tests/        # Utility function testing
├── SportXUITests/              # UI and integration tests
│   └── UI Test Cases/          # Screen and flow testing
├── LICENSE                     # MIT License
└── README.md                   # This file
```

## Usage

### Running the Application

1. **Select a simulator or device** from the Xcode device selector
2. **Press Play** (⌘ + R) or use the Run button
3. The application will build and launch on your selected target

### Key Features Usage

#### Activity Tracking
- Navigate to the activities section
- Create new activity entries
- Track duration, distance, and other metrics
- View historical data and trends

#### Statistics
- Access the analytics dashboard
- Review performance metrics
- Track achievements and milestones

#### Settings
- Configure app preferences
- Manage data and notifications
- Update profile information

### Development Tips

- **Hot Reload**: SwiftUI provides real-time preview updates
- **Debugging**: Use Xcode's debugger to set breakpoints and inspect variables
- **Console Logging**: Use `print()` or `os_log()` for debugging
- **View Hierarchy**: Use the View Debugger (⌘ + option + control + I) to inspect UI elements

## Testing

### Running Tests

**Run all tests:**
```bash
⌘ + U  # In Xcode
```

**Run specific test suite:**
```bash
xcodebuild -scheme SportX -destination 'platform=iOS Simulator,name=iPhone 15' test
```

### Test Coverage

The project includes two test targets:

1. **SportXTests** - Unit tests for models, services, and utilities
2. **SportXUITests** - UI and integration tests for user workflows

### Writing Tests

Create test cases in the appropriate test target:

```swift
import XCTest
@testable import SportX

class ActivityModelTests: XCTestCase {
    func testActivityCreation() {
        let activity = Activity(name: "Running", duration: 30)
        XCTAssertEqual(activity.name, "Running")
        XCTAssertEqual(activity.duration, 30)
    }
}
```

## Contributing

We welcome contributions! Please follow these guidelines:

1. **Fork the repository** on GitHub
2. **Create a feature branch** (`git checkout -b feature/YourFeature`)
3. **Make your changes** and commit (`git commit -am 'Add new feature'`)
4. **Push to the branch** (`git push origin feature/YourFeature`)
5. **Submit a Pull Request** with a clear description

### Code Standards
- Follow Swift naming conventions (camelCase for variables/functions, PascalCase for types)
- Use meaningful variable and function names
- Add comments for complex logic
- Ensure all tests pass before submitting a PR
- Write unit tests for new features

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

### MIT License Summary
- ✅ Allowed: Commercial use, modification, distribution, private use
- ❌ Limited: Liability, warranty
- 📝 Required: License and copyright notice

---

## Getting Help

- 📖 Check the [Issues](https://github.com/Sporto-org/Sportx/issues) section for known problems
- 💬 Open a new issue if you find a bug or have a feature request
- 🤝 Join discussions in the [Wiki](https://github.com/Sporto-org/Sportx/wiki)

## Acknowledgments

Thank you to all contributors and the iOS development community for their support!

---

**Last Updated:** June 2026  
**Repository:** [Sporto-org/Sportx](https://github.com/Sporto-org/Sportx)

# Task Manager App
A modern, feature-rich task management app built with SwiftUI and Core Data. This app allows users to create, manage, and organize tasks with ease. It supports advanced features like drag-and-drop reordering, swipe gestures, animations, and theming.

# Features
# Core Features
Task Creation:

Add tasks with a title (required), description (optional), priority (Low, Medium, High), and due date (via a date picker).

Task List:

Dynamic, filterable list of tasks.


Task Details:

Detailed view for each task with options to mark it as completed or delete it.

Persistent Storage:

Uses Core Data to save tasks locally, ensuring data persists across app restarts.

# UI/UX Design
SwiftUI:

Built entirely using SwiftUI 5.

Modern components like NavigationStack, List, and Button.

Responsive layout optimized for iPhone and iPad.

Theming:

Supports light and dark modes with dynamic system colors.

Allows users to customize the accent color via a settings view.

Animations:

Fade-and-scale effect for task addition/removal.

Spring animation when opening the task details view.

Subtle pulse effect on the "Add Task" button when tapped.

Navigation:

Uses NavigationStack for seamless navigation between:

Home view (task list).

Task creation view.

Task details view.

Settings view.

# Advanced UI Features
Drag-and-Drop:

Reorder tasks in the list with haptic feedback using onMove.

Swipe Gestures:

Swipe-to-delete and swipe-to-complete actions with an undo option via Snackbar or Alert.

Custom Progress Indicator:

Animated circular progress ring showing the percentage of completed tasks, updating smoothly with withAnimation.

Empty State:

Engaging empty state UI with an illustration (e.g., SF Symbols) and a motivational message when no tasks exist.

# Accessibility

Supports Dynamic Type for text scaling.

High-contrast mode compatibility.

Keyboard navigation for task creation and list interaction.

Performance and Polish
Optimized list rendering with LazyVStack for smooth scrolling with 100+ tasks.

Efficient use of @StateObject and @FetchRequest to minimize redraws.

Placeholder shimmer effect while Core Data loads initially.

# Screenshots
Task List
![Simulator Screenshot - Clone 4 of iPhone 13 - 2025-03-04 at 22 58 25](https://github.com/user-attachments/assets/29b31ef2-f411-474f-b1f2-1372fc56d3ae)

Task Creation	
![Simulator Screenshot - Clone 4 of iPhone 13 - 2025-03-04 at 22 58 54](https://github.com/user-attachments/assets/69acf418-a01a-4767-987d-48d022727f76)

Task Details	
![Simulator Screenshot - Clone 4 of iPhone 13 - 2025-03-04 at 22 58 33](https://github.com/user-attachments/assets/7ca532d8-ba3e-495c-bbe4-83c0b675e9b7)

Settings
![Simulator Screenshot - Clone 4 of iPhone 13 - 2025-03-04 at 22 58 38](https://github.com/user-attachments/assets/4edd80db-5a91-438f-a79e-3c9c15575f41)


# Requirements
Xcode 15 or later.

iOS 17 or later.

Swift 5.9 or later.

# Installation
Clone the repository:

bash
Copy
git clone https://github.com/your-username/task-manager-app.git
Open the project in Xcode:

Navigate to the project folder and open TaskManagerApp.xcodeproj.

Build and run the app on a simulator or physical device.

# Testing
The app includes UI tests written with XCTest to verify:

Task creation flow.

Sorting and filtering functionality.

Animation triggers.

To run the tests:

Open the project in Xcode.

Select the TaskManagerAppTests target.

Press Cmd + U to run all tests.

# Contributing
Contributions are welcome! If you'd like to contribute:

Fork the repository.

Create a new branch for your feature or bugfix.

Submit a pull request with a detailed description of your changes.

# License
This project is licensed under the MIT License. See the LICENSE file for details.

#  Acknowledgments
SwiftUI for providing a modern and declarative way to build UIs.

Core Data for enabling persistent storage.

Apple for providing excellent documentation and resources.

# Contact
For questions or feedback, feel free to reach out:

Email: hirrasalim2010@gmail.com

GitHub: hirrasalimuae

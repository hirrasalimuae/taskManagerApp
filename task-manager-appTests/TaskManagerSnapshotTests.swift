//
//  TaskManagerSnapshotTests.swift
//  task-manager-app
//
//  Created by hirrasalim on 03/03/2025.
//

import XCTest
import SnapshotTesting
import SwiftUI

@testable import task_manager_app // Replace with your app's module name

class TaskManagerSnapshotTests: XCTestCase {
    
    func testTaskListViewLightMode() {
        let taskListView = TaskListView()
            .environment(\.colorScheme, .light) // Force light mode
        let hostingController = UIHostingController(rootView: taskListView)
        
        assertSnapshot(
            of: hostingController,
            as: .image(on: .iPhone13), // Specify the device
            named: "LightMode",
            record: false // Set to `true` to record a new snapshot
        )
    }
    
    func testTaskListViewDarkMode() {
        let taskListView = TaskListView()
            .environment(\.colorScheme, .dark) // Force dark mode
        let hostingController = UIHostingController(rootView: taskListView)
        assertSnapshot(
            of: hostingController,
            as: .image(on: .iPhone13), // Specify the device
            named: "DarkMode",
            record: false // Set to `true` to record a new snapshot
        )
    }
}

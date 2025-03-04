//
//  TaskManagerUITests.swift
//  task-manager-app
//
//  Created by hirrasalim on 03/03/2025.
//

import XCTest

class TaskManagerUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launch()
    }

//
//    func testSortingAndFiltering() {
//        // Add tasks
//        let addTaskButton = app.buttons["Add Task Button"]
//        addTaskButton.tap()
//        let taskTitleField = app.textFields["New Task Input"]
//        taskTitleField.tap()
//        taskTitleField.typeText("Task A")
//        app.buttons["Add"].tap()
//
//        addTaskButton.tap()
//        taskTitleField.tap()
//        taskTitleField.typeText("Task B")
//        app.buttons["Add"].tap()
//
//        // Sort tasks (assuming there's a sort button)
//        let sortButton = app.buttons["Sort Button"]
//        XCTAssertTrue(sortButton.exists)
//        sortButton.tap()
//
//        // Verify sorted order
//        let firstTask = app.staticTexts["Task A"]
//        let secondTask = app.staticTexts["Task B"]
//        XCTAssertTrue(firstTask.exists)
//        XCTAssertTrue(secondTask.exists)
//
//        // Filter tasks (assuming there's a filter button)
//        let filterButton = app.buttons["Filter Button"]
//        XCTAssertTrue(filterButton.exists)
//        filterButton.tap()
//
//        // Verify filtered tasks
//        let filteredTask = app.staticTexts["Task A"]
//        XCTAssertTrue(filteredTask.exists)
//    }
//    func testAnimationTriggers() {
//        // Add a task to trigger the animation
//        let addTaskButton = app.buttons["Add Task Button"]
//        addTaskButton.tap()
//        let taskTitleField = app.textFields["New Task Input"]
//        taskTitleField.tap()
//        taskTitleField.typeText("Animated Task")
//        app.buttons["Add"].tap()
//
//        // Verify the task is added with animation
//        let animatedTask = app.staticTexts["Animated Task"]
//        XCTAssertTrue(animatedTask.exists)
//
//        // Delete the task to trigger the removal animation
//        animatedTask.swipeLeft()
//        let deleteButton = app.buttons["Delete"]
//        XCTAssertTrue(deleteButton.exists)
//        deleteButton.tap()
//
//        // Verify the task is removed
//        XCTAssertFalse(animatedTask.exists)
//    }
}

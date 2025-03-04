//
//  task_manager_appUITests.swift
//  task-manager-appUITests
//
//  Created by hirrasalim on 27/02/2025.
//

import XCTest

final class task_manager_appUITests: XCTestCase {
    var app: XCUIApplication!
    
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("--uitesting") // Disable animations for testing
        app.launch()
    }
    
  
    
    func testAddTaskButtonPulsingAnimation() {
        // Navigate to the task list screen
        let taskList = app.navigationBars["Tasks"]
        XCTAssertTrue(taskList.waitForExistence(timeout: 5), "Task List screen did not load")

        // Tap the Add Task Button to trigger the pulsing animation
        let addTaskButton = app.buttons["Add Task Button"]
        XCTAssertTrue(addTaskButton.waitForExistence(timeout: 5), "Add Task Button does not exist")
        addTaskButton.tap()

    
    }
    
        func testShimmerEffectWhileLoading() {
        // Navigate to the task list screen
        let taskList = app.navigationBars["Tasks"]
        XCTAssertTrue(taskList.waitForExistence(timeout: 5), "Task List screen did not load")

       
    }
    
    func testTaskDeleteUpdates() {
        let taskList = app.navigationBars["Tasks"]
        XCTAssertTrue(taskList.waitForExistence(timeout: 5), "Task List screen did not load")

        // Add a task via the UI
        addTask(title: "Delete Task Demo", order: 1)

        // Print the UI hierarchy for debugging
        print(app.debugDescription)

        // Locate the task using its title
        let taskCell = app.staticTexts["Task: Delete Task Demo, This is a test task description of Delete Task Demo, Low, \(itemFormatter.string(from:Date()))"]

        XCTAssertTrue(taskCell.waitForExistence(timeout: 5), "Task cell does not exist")

        // Swipe left to reveal the complete button
        taskCell.swipeLeft()

        // Tap the Delte button
        let deleteButton = app.buttons["Delete"]
        XCTAssertTrue(deleteButton.waitForExistence(timeout: 5), "Complete button does not exist")
        deleteButton.tap()


        // Verify the task is removed
        XCTAssertFalse(deleteButton.exists)
    }
    
    func testTaskCompletionUpdatesProgressRing() {
        // Navigate to the task list screen
        let taskList = app.navigationBars["Tasks"]
        XCTAssertTrue(taskList.waitForExistence(timeout: 5), "Task List screen did not load")

        // Add a task via the UI
        addTask(title: "Completed Task Demo", order: 1)

        // Print the UI hierarchy for debugging
        print(app.debugDescription)

        // Locate the task using its title
        let taskCell = app.staticTexts["Task: Completed Task Demo, This is a test task description of Completed Task Demo, Low, \(itemFormatter.string(from:Date()))"]

        XCTAssertTrue(taskCell.waitForExistence(timeout: 5), "Task cell does not exist")

        // Swipe left to reveal the complete button
        taskCell.swipeLeft()

        // Tap the complete button
        let completeButton = app.buttons["Complete"]
        XCTAssertTrue(completeButton.waitForExistence(timeout: 5), "Complete button does not exist")
        completeButton.tap()

        // Verify the complete updates
        print(app.debugDescription)

       
    }
    private func addTask(title: String, order: Int) {
        let addTaskButton = app.buttons["Add Task Button"]
        XCTAssertTrue(addTaskButton.waitForExistence(timeout: 5), "Add Task Button does not exist")
        addTaskButton.tap()
        
        let titleTextField = app.textFields["New Task Input"]
        XCTAssertTrue(titleTextField.waitForExistence(timeout: 5), "Title Text Field does not exist")
        titleTextField.tap()
        titleTextField.typeText(title)
        // Enter task description
        let descriptionTextField = app.textFields["Description"]
        XCTAssertTrue(descriptionTextField.waitForExistence(timeout: 5), "Description Text Field does not exist")
        descriptionTextField.tap()
        descriptionTextField.typeText("This is a test task description of \(title)")
      
        app.buttons["Save Task"].tap()
        let taskCells = app.staticTexts.matching(identifier: "Task Title")
         print("Tasks after adding: \(taskCells.count)")
    }
}

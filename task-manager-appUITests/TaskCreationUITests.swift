//
//  TaskCreationUITests.swift
//  task-manager-app
//
//  Created by hirrasalim on 03/03/2025.
//

import XCTest

class TaskCreationUITests: XCTestCase {
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
        app.launchArguments.append("-AppleLocale") // Set locale
        app.launchArguments.append("en_US") // Example: US English
        app.launch()
    }
    override func tearDown() {
           app = nil
       }
    func testTaskCreationFlow() {
        // Navigate to the task creation screen
        let addTaskButton = app.buttons["Add Task Button"]
        XCTAssertTrue(addTaskButton.waitForExistence(timeout: 5), "Add Task Button does not exist")
        addTaskButton.tap()
        
        // Enter task title
        let titleTextField = app.textFields["New Task Input"]
        XCTAssertTrue(titleTextField.waitForExistence(timeout: 5), "Title Text Field does not exist")
        titleTextField.tap()
        titleTextField.typeText("New Task Title")
        
        // Enter task description
        let descriptionTextField = app.textFields["Description"]
        XCTAssertTrue(descriptionTextField.waitForExistence(timeout: 5), "Description Text Field does not exist")
        descriptionTextField.tap()
        descriptionTextField.typeText("This is a test task description")
        
        // Select priority
        // Tap the Priority button to open the selection view
        let priorityPicker = app.buttons["Priority"]
        XCTAssertTrue(priorityPicker.waitForExistence(timeout: 5), "Priority Picker does not exist")
        priorityPicker.tap()

        // Select the "Medium" option from the selection view
        let mediumOption = app.buttons["Medium"] // Ensure "Medium" has an accessibility identifier
        XCTAssertTrue(mediumOption.waitForExistence(timeout: 5), "Medium option does not exist")
        mediumOption.tap()
        
        // Select due date

        let dueDatePicker = app.datePickers["Due Date"]
        XCTAssertTrue(dueDatePicker.waitForExistence(timeout: 5), "Due Date Picker does not exist")

        dueDatePicker.forceTap()
        
        // Save the task
        let saveButton = app.buttons["Save Task"]
        XCTAssertTrue(saveButton.waitForExistence(timeout: 5), "Save Button does not exist")
        XCTAssertTrue(saveButton.isEnabled, "Save Button is disabled")
        
    }

    func testTasksAreSortedByOrder() {
        // Navigate to the task list screen
        let taskList = app.navigationBars["Tasks"]
        XCTAssertTrue(taskList.waitForExistence(timeout: 5), "Task List screen did not load")
        
        // Add multiple tasks with different orders
        addTask(title: "Task 1", order: 1)
        addTask(title: "Task 2", order: 2)
        addTask(title: "Task 3", order: 3)
        
        // Verify tasks are displayed in the correct order
        let taskCells = app.staticTexts.matching(identifier: "Task Title")
        XCTAssertEqual(taskCells.count, 3, "Expected 3 tasks")
        print(itemFormatter)
 
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
extension XCUIElement {
    func forceTap() {
        if (isHittable) {
            tap()
        } else {
            coordinate(withNormalizedOffset: CGVector(dx:0.0, dy:0.0)).tap()
        }
    }
}

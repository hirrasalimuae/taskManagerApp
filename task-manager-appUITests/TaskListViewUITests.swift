//
//  TaskListViewUITests.swift
//  task-manager-app
//
//  Created by hirrasalim on 05/03/2025.
//

import XCTest

class TaskListViewUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"] // Use a launch argument to set up mock data
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    // MARK: - Sorting Tests

    func testSortByPriority() throws {
        // Navigate to the TaskListView
        let taskList = app.navigationBars["Tasks"]
        XCTAssertTrue(taskList.exists, "Task List view should be visible")

        // Open the sorting menu
        let sortMenu = taskList.buttons["Sort"]
        XCTAssertTrue(sortMenu.exists, "Sort menu button should exist")
        sortMenu.tap()

        // Select "Priority" from the sorting options
        let priorityOption = app.buttons["Priority"]
        XCTAssertTrue(priorityOption.exists, "Priority option should exist")
        priorityOption.tap()

        // Verify the tasks are sorted by priority
        // (You need to ensure your test data has tasks with different priorities)
        let firstTask = app.staticTexts["Task Title"].firstMatch
        XCTAssertTrue(firstTask.exists, "First task should exist")
        // Add assertions to verify the sorting order
    }

    func testSortByDueDate() throws {
        // Navigate to the TaskListView
        let taskList = app.navigationBars["Tasks"]
        XCTAssertTrue(taskList.exists, "Task List view should be visible")

        // Open the sorting menu
        let sortMenu = taskList.buttons["Sort"]
        XCTAssertTrue(sortMenu.exists, "Sort menu button should exist")
        sortMenu.tap()

        // Select "Due Date" from the sorting options
        let dueDateOption = app.buttons["Due Date"]
        XCTAssertTrue(dueDateOption.exists, "Due Date option should exist")
        dueDateOption.tap()

        // Verify the tasks are sorted by due date
        // (You need to ensure your test data has tasks with different due dates)
        let firstTask = app.staticTexts["Task Title"].firstMatch
        XCTAssertTrue(firstTask.exists, "First task should exist")
        // Add assertions to verify the sorting order
    }

    func testSortByTitle() throws {
        // Navigate to the TaskListView
        let taskList = app.navigationBars["Tasks"]
        XCTAssertTrue(taskList.exists, "Task List view should be visible")

        // Open the sorting menu
        let sortMenu = taskList.buttons["Sort"]
        XCTAssertTrue(sortMenu.exists, "Sort menu button should exist")
        sortMenu.tap()

        // Select "Title" from the sorting options
        let titleOption = app.buttons["Title"]
        XCTAssertTrue(titleOption.exists, "Title option should exist")
        titleOption.tap()

        // Verify the tasks are sorted by title
        // (You need to ensure your test data has tasks with different titles)
        let firstTask = app.staticTexts["Task Title"].firstMatch
        XCTAssertTrue(firstTask.exists, "First task should exist")
        // Add assertions to verify the sorting order
    }

    // MARK: - Filtering Tests

    func testFilterAllTasks() throws {
        // Navigate to the TaskListView
        let taskList = app.navigationBars["Tasks"]
        XCTAssertTrue(taskList.exists, "Task List view should be visible")

        // Select "All" from the filter segmented control
        let allFilter = app.segmentedControls.buttons["All"]
        XCTAssertTrue(allFilter.exists, "All filter button should exist")
        allFilter.tap()

        // Verify all tasks are displayed
        let tasks = app.staticTexts.matching(identifier: "Task Title")
        XCTAssertGreaterThan(tasks.count, 0, "All tasks should be displayed")
    }

    func testFilterCompletedTasks() throws {
        // Navigate to the TaskListView
        let taskList = app.navigationBars["Tasks"]
        XCTAssertTrue(taskList.exists, "Task List view should be visible")

        // Select "Completed" from the filter segmented control
        let completedFilter = app.segmentedControls.buttons["Completed"]
        XCTAssertTrue(completedFilter.exists, "Completed filter button should exist")
        completedFilter.tap()

        // Verify only completed tasks are displayed
        let tasks = app.staticTexts.matching(identifier: "Task Title")
        XCTAssertGreaterThan(tasks.count, 0, "Completed tasks should be displayed")
        // Add assertions to verify only completed tasks are shown
    }

    func testFilterPendingTasks() throws {
        // Navigate to the TaskListView
        let taskList = app.navigationBars["Tasks"]
        XCTAssertTrue(taskList.exists, "Task List view should be visible")

        // Select "Pending" from the filter segmented control
        let pendingFilter = app.segmentedControls.buttons["Pending"]
        XCTAssertTrue(pendingFilter.exists, "Pending filter button should exist")
        pendingFilter.tap()

        // Verify only pending tasks are displayed
        let tasks = app.staticTexts.matching(identifier: "Task Title")
        XCTAssertGreaterThan(tasks.count, 0, "Pending tasks should be displayed")
        // Add assertions to verify only pending tasks are shown
    }
}

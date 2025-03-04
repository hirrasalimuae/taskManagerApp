//
//  task_manager_appApp.swift
//  task-manager-app
//
//  Created by hirrasalim on 27/02/2025.
//

import SwiftUI

@main
struct task_manager_app: App {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
      @AppStorage("accentColor") private var accentColor: String = "blue"

    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TaskListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext) 
                .tint(Color(accentColor)) // Apply the selected accent color
                .preferredColorScheme(isDarkMode ? .dark : .light)   .onAppear {
                    if ProcessInfo.processInfo.arguments.contains("-ui-testing") {
                        // Load mock data for UI testing
                        loadMockData()
                    }
                }
            
        }
    }
    private func loadMockData() {
            let context = PersistenceController.preview.container.viewContext
            // Add mock tasks here
        }
}

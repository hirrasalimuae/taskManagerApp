//
//  Persistence.swift
//  task-manager-app
//
//  Created by hirrasalim on 27/02/2025.
//


import CoreData

//struct PersistenceController {
//    static let shared = PersistenceController()
//
//    let container: NSPersistentContainer
//
//    init(inMemory: Bool = false) {
//        container = NSPersistentContainer(name: "task_manager_app") // Ensure this matches the .xcdatamodeld file name
//
//        if inMemory {
//            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
//            
//        }
//        if let storeURL = container.persistentStoreDescriptions.first?.url {
//            print("Core Data Store URL: \(storeURL)")
//        }
//        // Enable lightweight migration
//        let description = NSPersistentStoreDescription()
//        description.shouldMigrateStoreAutomatically = true // Enable automatic migration
//        description.shouldInferMappingModelAutomatically = true // Enable automatic schema inference
//        container.persistentStoreDescriptions = [description]
//
//        container.loadPersistentStores { (storeDescription, error) in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        }
//    }
//}

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "task_manager_app") // Ensure this matches your .xcdatamodeld file name
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    // Add a static `preview` property for testing and SwiftUI previews
       static var preview: PersistenceController = {
           let result = PersistenceController(inMemory: true)
           let viewContext = result.container.viewContext

           // Add mock data for previews or testing
           for i in 0..<10 {
               let newTask = Task(context: viewContext)
               newTask.id = UUID()
               newTask.title = "Task \(i)"
               newTask.isCompleted = false
               newTask.dueDate = Date()
               newTask.priority = i % 2 == 0 ? "high" : "low"
           }

           do {
               try viewContext.save()
           } catch {
               let nsError = error as NSError
               fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
           }

           return result
       }()
}

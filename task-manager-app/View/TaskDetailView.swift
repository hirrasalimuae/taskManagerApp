//
//  AddTaskView.swift
//  task-manager-app
//
//  Created by hirrasalim on 27/02/2025.
//
import SwiftUI

struct TaskDetailsView: View {
    @ObservedObject var task: Task
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            
            VStack {
                Form {
                    Section(header: Text("Task Details")) {
                        Text(task.title ?? "")
                            .font(.headline)
                        if let description = task.taskDescription {
                            Text(description)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Text("Priority: \(task.priority ?? "")")
                        Text("Due Date: \(task.dueDate ?? Date(), style: .date)")
                    }
                    
                    Section {
                        Toggle("Completed", isOn: $task.isCompleted)
                            .onChange(of: task.isCompleted) { oldValue, newValue  in
                                saveChanges()
                            }
                    }
                    
                    Section {
                        Button("Delete Task", role: .destructive) {
                            deleteTask()
                            dismiss()
                        }
                    }
                }
            }.transition(.asymmetric(
                insertion: .scale(scale: 0.8).combined(with: .opacity),
                removal: .opacity
            ))
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: task)
            .navigationTitle("Task Details")
        }
    }
    
    private func saveChanges() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving changes: \(error.localizedDescription)")
        }
    }
    
    private func deleteTask() {
        viewContext.delete(task)
        saveChanges()
    }
}

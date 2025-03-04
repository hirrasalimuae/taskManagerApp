//
//  TaskRowView.swift
//  task-manager-app
//
//  Created by hirrasalim on 03/03/2025.
//
import SwiftUI
 
struct TaskRowView: View {
    @ObservedObject var task: Task
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showUndoAlert = false
    @State private var taskToDelete: Task? = nil

    var body: some View {
        VStack(alignment: .leading) {
            Text(task.title?.capitalized ?? "")
                .font(.body) // Supports Dynamic Type
                        .accessibilityLabel("Task: \(task.title ?? "Untitled Task")")    .accessibilityIdentifier("Task Title \(task.id?.uuidString ?? "")") // Unique identifier
                        .accessibilityHint(task.isCompleted ? "Completed" : "Pending")
            if let description = task.taskDescription {
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            HStack {
//                Spacer()

                Text(task.priority ?? "")
                    .font(.caption)
                    .padding(4)
                    .background(task.priority == "High" ? Color.red.opacity(0.2) : task.priority == "Medium" ? Color.orange.opacity(0.2) : Color.green.opacity(0.2))
                    .cornerRadius(4)
                Spacer()
                HStack() {
                    
                    Text(task.dueDate ?? Date(), style: .date)
                        .font(.caption)
                 
                    if task.isCompleted {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.body) // Supports Dynamic Type
                                    .foregroundColor(.green)
                                    .accessibilityLabel("Completed")
                            }
                }
            }
            
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                // Swipe-to-delete
                Button {
                    taskToDelete = task // Store the task to delete
                    showUndoAlert = true // Show the undo alert
                } label: {
                    Label("Delete", systemImage: "trash")
                }.accessibilityIdentifier("Delete")

                // Swipe-to-complete
                Button {
                    toggleTaskCompletion(task)
                } label: {
                    Label(task.isCompleted ? "Undo" : "Complete", systemImage: task.isCompleted ? "arrow.uturn.backward" : "checkmark")
                }.accessibilityLabel("Complete")
                .tint(task.isCompleted ? .orange : .green)
            }
            .alert("Task Deleted", isPresented: $showUndoAlert) {
                Button("Undo", role: .cancel) {
                    if let taskToDelete = taskToDelete {
                        undoDelete(task: taskToDelete)
                    }
                }
                Button("OK", role: .destructive) {
                    if let taskToDelete = taskToDelete {
                        confirmDelete(task: taskToDelete)
                    }
                }
            } message: {
                Text("Do you want to undo the deletion?")
            }
            .onChange(of: showUndoAlert) { oldValue, newValue in

                if newValue {
                    // Automatically dismiss the alert after 3 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        if showUndoAlert {
                            showUndoAlert = false
                            if let taskToDelete = taskToDelete {
                                confirmDelete(task: taskToDelete)
                            }
                        }
                    }
                }
            } .padding()
//            .background(Color(.systemBackground))
            .cornerRadius(8)
            .shadow(radius: 2)
            .padding(.horizontal).accessibilityElement(children: .combine) // Combine child elements into a single accessibility element
        }

    private func confirmDelete(task: Task) {
           viewContext.delete(task)
           do {
               try viewContext.save()
           } catch {
               print("Error deleting task: \(error)")
           }
       }

    private func undoDelete(task: Task) {
        viewContext.insert(task)
        do {
            try viewContext.save()
        } catch {
            print("Error undoing deletion: \(error)")
        }
    }

    private func toggleTaskCompletion(_ task: Task) {
        task.isCompleted.toggle()
        do {
            try viewContext.save()
        } catch {
            print("Error toggling task completion: \(error)")
        }
    }
}

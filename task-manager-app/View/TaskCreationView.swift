//
//  TaskCreationView.swift
//  task-manager-app
//
//  Created by hirrasalim on 27/02/2025.
//

import SwiftUI
struct TaskCreationView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.order, order: .forward)]
    ) private var tasks: FetchedResults<Task>
    @State private var title: String = ""
    @State private var taskDescription: String = ""
    @State private var priority: String = "Low"
    @State private var dueDate: Date = Date()
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Task Details")) {
                    TextField("Title", text: $title)
                        .focused($isTextFieldFocused)
                        .accessibilityLabel("New Task Input")
                        .accessibilityIdentifier("New Task Input") // Add accessibility identifier
                    TextField("Description", text: $taskDescription)
                        .accessibilityIdentifier("Description") // Add accessibility identifier
                    Picker("Priority", selection: $priority) {
                        Text("Low").tag("Low") .accessibilityIdentifier("Low")
                        Text("Medium").tag("Medium") .accessibilityIdentifier("Medium")
                        Text("High").tag("High") .accessibilityIdentifier("High")
                    }
                    .accessibilityIdentifier("Priority")
                    
                    DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .accessibilityIdentifier("Due Date") // Add accessibility identifier
                }
                .padding()
                
                Section {
                    Button("Save Task") {
                        let order = tasks.count + 1 // Calculate the order
                        saveTask(order: order)
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                    .accessibilityIdentifier("Save Task") // Add accessibility identifier
                }
            }.accessibilityElement(children: .contain)

            .navigationTitle("New Task")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isTextFieldFocused = false
                    }
                    .accessibilityLabel("Done Button")
                    .accessibilityIdentifier("Done Button") // Add accessibility identifier
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .accessibilityIdentifier("Cancel Button") // Add accessibility identifier
                }
            }
        }
    }
    
    private func saveTask( order: Int) {
        let newTask = Task(context: viewContext)
        newTask.id = UUID()
        newTask.title = title
        newTask.taskDescription = taskDescription
        newTask.priority = priority
        newTask.dueDate = dueDate
        newTask.isCompleted = false
        newTask.order = Int16(order) // Set the order

        do {
            try viewContext.save()
        } catch {
            print("Error saving task: \(error.localizedDescription)")
        }
    }
}

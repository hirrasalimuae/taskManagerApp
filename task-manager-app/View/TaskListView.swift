//
//  TaskDetailView.swift
//  task-manager-app
//
//  Created by hirrasalim on 27/02/2025.
//
import SwiftUI

struct TaskListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.order, order: .forward)]
    ) private var tasks: FetchedResults<Task>
    @State private var showSnackbar = false
    @State private var deletedTask: Task? = nil
    @State private var newTaskTitle: String = ""
    @State private var isLoading = true // Track loading state
    
    var taskIdentifiers: [UUID] {
        tasks.map { $0.id ?? UUID() }
    }
    @State private var showAddTaskView = false
    @State private var isPulsing = false

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                if tasks.isEmpty {
                    // Show Empty State View
                    EmptyStateView()
                } else {
                    if isLoading {
                        // Show shimmer placeholder while loading
                        ScrollView {
                            LazyVStack(spacing: 16) {
                                ForEach(0..<10, id: \.self) { _ in
                                    TaskPlaceholderView().accessibilityIdentifier("Task Placeholder")
                                }
                            }
                            .padding()
                        }
                    } else {
                        List {
                            ForEach(tasks) { task in
                                NavigationLink {
                                    TaskDetailsView(task: task) .transition(.asymmetric(
                                        insertion: .scale(scale: 0.8).combined(with: .opacity),
                                        removal: .opacity
                                    ))
                                    .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: task)
                                } label: {
                                    TaskRowView(task: task)                         .transition(.opacity.combined(with: .scale))  .accessibilityIdentifier("Task Title") // Fade and scale animation
                                    
                                }
                                
                            } .onMove(perform: moveTasks) .accessibilityLabel("Task List")
                                .accessibilityHint("Swipe left or right to delete or complete tasks.")
                            
                        } .navigationTitle("Tasks")
                           
                    }
                }
                Spacer()
                HStack{
                    let completedTasks = tasks.filter { $0.isCompleted }.count
                    let totalTasks = tasks.count
                    let progress = totalTasks > 0 ? CGFloat(completedTasks) / CGFloat(totalTasks) : 0
                    
                    ProgressRingView(progress: progress)
                        .padding().accessibilityLabel("Progress Ring")
                        .accessibilityIdentifier("Progress Ring")
                    Spacer()
                    // Add Task Button
                    Button(action: {
                        // Trigger the pulse effect
                        withAnimation(.easeInOut(duration: 0.2)) {
                            isPulsing = true
                        }
                        
                        // Reset the pulse effect after a short delay
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                isPulsing = false
                            }
                        }
                        
                        // Perform the action (e.g., add a new task)
                        showAddTaskView.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 50))
                            .scaleEffect(isPulsing ? 1.2 : 1.0) // Scale up when pulsing
                    } .accessibilityHint("Double-tap to add a new task.").accessibilityLabel("Add Task Button")
                        .accessibilityIdentifier("Add Task Button")
                   

                }
                
            } .toolbar {
                if !tasks.isEmpty {
                    EditButton()
                }
            }  .animation(.easeInOut, value: taskIdentifiers)
                .navigationTitle("Tasks")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        NavigationLink {
                            SettingsView()
                        } label: {
                            Image(systemName: "gearshape")
                        }
                        
                    }
                }
                .sheet(isPresented: $showAddTaskView) {
                    TaskCreationView()
                }.onAppear {
                    // Simulate a delay for loading data
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        isLoading = false // Stop showing the shimmer effect
                    }
                }
        }
    }
    
    
    private func moveTasks(from source: IndexSet, to destination: Int) {
        var updatedTasks = tasks.map { $0 }
        updatedTasks.move(fromOffsets: source, toOffset: destination)
        
        // Update the order in Core Data
        for (index, task) in updatedTasks.enumerated() {
            task.order = Int16(index)
        }
        
        // Save changes to Core Data
        do {
            try viewContext.save()
        } catch {
            print("Error saving context: \(error)")
        }
        
        // Provide haptic feedback
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
}


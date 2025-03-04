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
    var taskIdentifiers: [UUID] {
        tasks.map { $0.id ?? UUID() }
    }
    @State private var showSnackbar = false
    @State private var deletedTask: Task? = nil
    @State private var newTaskTitle: String = ""
    @State private var isLoading = true // Track loading state
    @State private var showAddTaskView = false
    @State private var isPulsing = false
    
    // Sorting and Filtering State
    @State private var sortOption: SortOption = .priority
    @State private var filterOption: FilterOption = .all
    
    enum SortOption: String, CaseIterable {
        case priority = "Priority"
        case dueDate = "Due Date"
        case title = "Title"
    }
    
    enum FilterOption: String, CaseIterable {
        case all = "All"
        case completed = "Completed"
        case pending = "Pending"
    }
    
    var filteredTasks: [Task] {
        switch filterOption {
        case .all:
            return Array(tasks)
        case .completed:
            return tasks.filter { $0.isCompleted }
        case .pending:
            return tasks.filter { !$0.isCompleted }
        }
    }
    
    var sortedTasks: [Task] {
        switch sortOption {
        case .priority:
            return filteredTasks.sorted { $0.priority ?? "low" > $1.priority ?? "low" }
        case .dueDate:
            return filteredTasks.sorted { $0.dueDate ?? Date() < $1.dueDate ?? Date() }
        case .title:
            return filteredTasks.sorted { $0.title ?? "" < $1.title ?? "" }
        }
    }
    
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
                            ForEach(sortedTasks) { task in
                                NavigationLink {
                                    TaskDetailsView(task: task)
                                        .transition(.asymmetric(
                                            insertion: .scale(scale: 0.8).combined(with: .opacity),
                                            removal: .opacity
                                        ))
                                        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: task)
                                } label: {
                                    TaskRowView(task: task)
                                        .transition(.opacity.combined(with: .scale))
                                        .accessibilityIdentifier("Task Title")
                                }
                            }
                            .onMove(perform: moveTasks)
                            .accessibilityLabel("Task List")
                            .accessibilityHint("Swipe left or right to delete or complete tasks.")
                        }
                        .navigationTitle("Tasks")
                    }
                }
                
                Spacer()
                
                HStack {
                    let completedTasks = tasks.filter { $0.isCompleted }.count
                    let totalTasks = tasks.count
                    let progress = totalTasks > 0 ? CGFloat(completedTasks) / CGFloat(totalTasks) : 0
                    
                    ProgressRingView(progress: progress)
                        .padding()
                        .accessibilityLabel("Progress Ring")
                        .accessibilityIdentifier("Progress Ring")
                    
                    Spacer()
                    
                    // Add Task Button
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            isPulsing = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                isPulsing = false
                            }
                        }
                        
                        showAddTaskView.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 50))
                            .scaleEffect(isPulsing ? 1.2 : 1.0)
                    }
                    .accessibilityHint("Double-tap to add a new task.")
                    .accessibilityLabel("Add Task Button")
                    .accessibilityIdentifier("Add Task Button")
                }
            }
            .toolbar {
                if !tasks.isEmpty {
                    EditButton()
                }
            }
            .animation(.easeInOut, value: taskIdentifiers)
            .navigationTitle("Tasks")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Image(systemName: "gearshape")
                    }
                }
                
                // Sorting Menu
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {
                        Picker("Sort By", selection: $sortOption) {
                            ForEach(SortOption.allCases, id: \.self) { option in
                                Text(option.rawValue).tag(option)
                            }
                        }
                    } label: {
                        Label("Sort", systemImage: "arrow.up.arrow.down")
                    }
                }
            }
            .sheet(isPresented: $showAddTaskView) {
                TaskCreationView()
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    isLoading = false
                }
            }
            
            // Filter Segmented Control
            Picker("Filter", selection: $filterOption) {
                ForEach(FilterOption.allCases, id: \.self) { option in
                    Text(option.rawValue).tag(option)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
        }
    }
    
    private func moveTasks(from source: IndexSet, to destination: Int) {
        var updatedTasks = tasks.map { $0 }
        updatedTasks.move(fromOffsets: source, toOffset: destination)
        
        for (index, task) in updatedTasks.enumerated() {
            task.order = Int16(index)
        }
        
        do {
            try viewContext.save()
        } catch {
            print("Error saving context: \(error)")
        }
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}

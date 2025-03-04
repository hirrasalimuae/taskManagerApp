//
//  TaskPlaceholderView.swift
//  task-manager-app
//
//  Created by hirrasalim on 03/03/2025.
//
import SwiftUI
struct TaskPlaceholderView: View {
    var body: some View {
        HStack {
            ShimmerView()
                .frame(width: 150) // Mimic the task title width
            Spacer()
            ShimmerView()
                .frame(width: 20, height: 20) // Mimic the checkmark icon
        }
        .padding()
    }
}

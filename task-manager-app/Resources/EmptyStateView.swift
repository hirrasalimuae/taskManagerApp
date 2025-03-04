//
//  EmptyStateView.swift
//  task-manager-app
//
//  Created by hirrasalim on 03/03/2025.
//

import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 16) {
            // Illustration (SF Symbol)
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 60))
                .scaledToFit()
                .padding()
                .accessibilityLabel("No Tasks Illustration")

            // Motivational Message
            Text("No Tasks Yet!")
                .font(.title) // Supports Dynamic Type
                .bold()
                .accessibilityLabel("No Tasks Yet")

            Text("Add a new task to get started.")
                .font(.subheadline) // Supports Dynamic Type
                .foregroundColor(.gray)
                .accessibilityLabel("Add a new task to get started")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
        .accessibilityElement(children: .combine)
    }
}

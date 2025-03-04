//
//  ShimmerView.swift
//  task-manager-app
//
//  Created by hirrasalim on 03/03/2025.
//

import SwiftUI

struct ShimmerView: View {
    @State private var isAnimating = false

    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color(.systemGray5),
                Color(.systemGray6),
                Color(.systemGray5)
            ]),
            startPoint: .leading,
            endPoint: .trailing
        )
        .mask(RoundedRectangle(cornerRadius: 8).fill())
        .frame(height: 20)
        .offset(x: isAnimating ? 200 : -200) // Move the gradient
        .animation(
            Animation.linear(duration: 1.5)
                .repeatForever(autoreverses: false),
            value: isAnimating
        )
        .onAppear {
            isAnimating = true // Start the animation
        }
    }
}

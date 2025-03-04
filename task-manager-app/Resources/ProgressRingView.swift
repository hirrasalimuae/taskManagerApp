//

//  ProgressRingView.swift
//  task-manager-app
//
//  Created by hirrasalim on 03/03/2025.
//

import SwiftUI
import CoreData

struct ProgressRingView: View {
    var progress: CGFloat // Progress value between 0 and 1

    var body: some View {
        ZStack {
            // Background Circle
            Circle()
                .stroke(lineWidth: 5)
                .opacity(0.3)
//                .foregroundColor(.blue)

            // Progress Circle
            Circle()
                .trim(from: 0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
//                .foregroundColor(.blue)
                .rotationEffect(Angle(degrees: -90)) // Start from the top
                .animation(.easeInOut, value: progress) // Smooth animation

            // Percentage Text
            Text("\(Int(progress * 100))%")
                .font(.system(size: 15)).minimumScaleFactor(8)
                .padding(5).lineLimit(1)
        }
        .frame(width: 50, height: 50)
        .accessibilityElement(children: .combine) // Combine child elements into a single accessibility element
              .accessibilityLabel("Progress Ring")
              .accessibilityValue("\(Int(progress * 100)) percent completed")
    }
}

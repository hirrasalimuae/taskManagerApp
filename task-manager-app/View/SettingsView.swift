//
//  SettingsView.swift
//  task-manager-app
//
//  Created by hirrasalim on 03/03/2025.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("accentColor") private var accentColor: String = "blue"
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false

    let accentColors = [
        ("Blue", Color.blue),
        ("Green", Color.green),
        ("Orange", Color.orange),
        ("Purple", Color.purple),
        ("Red", Color.red)
    ]

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Appearance")) {
                    Toggle("Dark Mode", isOn: $isDarkMode)
                        .onChange(of: isDarkMode) { oldValue, newValue in
                            setAppearance(newValue)
                        }
                    
                    Picker("Accent Color", selection: $accentColor) {
                        ForEach(accentColors, id: \.0) { color in
                            Text(color.0)
                                .tag(color.0.lowercased())
                        }
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }

    private func setAppearance(_ isDarkMode: Bool) {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        windowScene?.windows.forEach { window in
            window.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        }
    }
}

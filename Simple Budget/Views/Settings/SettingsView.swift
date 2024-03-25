//
//  SettingsView.swift
//  Simple Budget
//
//  Created by Adam Reed on 3/24/24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                HStack {
                    Text("Default Currency")
                    Spacer()
                    Text("$")
                }
                Text("Linked Bank Accounts - Plaid (Coming soon)")
                
                // TODO: Update links with proper URLs
                Link("Rate the App", destination: URL(string: "wwww.google.com")!)
                Link("Share the App", destination: URL(string: "wwww.google.com")!)
                Link("Go Premium", destination: URL(string: "wwww.google.com")!)
                Link("Restore Purchases", destination: URL(string: "wwww.google.com")!)
            }
            .listStyle(.plain)
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}

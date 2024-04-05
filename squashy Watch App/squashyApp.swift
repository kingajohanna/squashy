//
//  squashyApp.swift
//  squashy Watch App
//
//  Created by Szabó Kinga on 22/03/2024.
//

import SwiftUI

@main
struct squashy_Watch_AppApp: App {
    var body: some Scene {
        WindowGroup {
            Navigation()
            
        }
    }
}

struct Navigation: View {
    @State private var selection = 1
    @StateObject var userpair = UserPair(user1: UserScore(name: "Mao", started: false), user2: UserScore(name: "Brumm", started: true))
    
    var body: some View {
        TabView(selection: $selection) {
            SettingsView(userpair: userpair).tag(0)
            ContentView(userpair: userpair).tag(1)
              }
              .tabViewStyle(PageTabViewStyle())
    }
}

#Preview {
    Navigation()
}


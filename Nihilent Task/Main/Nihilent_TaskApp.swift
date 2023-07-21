//
//  Nihilent_TaskApp.swift
//  Nihilent Task
//
//  Created by Pradeep Kumar on 2023/07/20.
//

import SwiftUI

@main
struct Nihilent_TaskApp: App {
    @Environment(\.scenePhase) private var scenePhase
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(\.managedObjectContext, PersistantManager.shared.managedContext)
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .background:
                PersistantManager.shared.save()
            default: break
            }
        }
    }
}

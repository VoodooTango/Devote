//
//  DevoteApp.swift
//  Devote
//
//  Created by MAC on 11/07/22.
//

import SwiftUI

@main
struct DevoteApp: App {
    let persistenceController = PersistenceController.shared
    
    @AppStorage("isDarkMode") var IsDarkMode: Bool = false 

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(IsDarkMode ? .dark: .light )
        }
    }
}

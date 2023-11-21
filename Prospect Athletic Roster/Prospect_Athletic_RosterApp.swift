//
//  Prospect_Athletic_RosterApp.swift
//  Prospect Athletic Roster
//
//  Created by Lorenzo J. Ablis on 10/24/23.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct Prospect_Athletic_RosterApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var dataManager = DataManager()
    
    var body: some Scene {
        WindowGroup {
            DisplayView()
                .environmentObject(dataManager)
        }
    }
}

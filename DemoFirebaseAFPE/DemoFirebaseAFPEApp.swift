//
//  DemoFirebaseAFPEApp.swift
//  DemoFirebaseAFPE
//
//  Created by Kelian Daste on 22/06/2022.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        Database.database().isPersistenceEnabled = true

        return true
    }
}

@main
struct DemoFirebaseAFPEApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            if let user = Auth.auth().currentUser {
                ContentView()
            } else {
                AuthView()
            }
        }
    }
}

//
//  CatsViewerApp.swift
//  CatsViewer
//
//  Created by Danylo Burliai on 19.05.2024.
//

import SwiftUI
import FirebaseCore
import FirebaseCrashlytics

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct CatsViewerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @AppStorage("AskPermissionForCrashlytics") var askPermissionForCrashlytics = true
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .alert(isPresented: $askPermissionForCrashlytics) {
                    Alert(
                        title: Text("Do you concent to give us your personal data without thinking or reading terms and service (we don't have it)?"),
                        message: Text("We definitely won't steal your identity to buy something from Africa"),
                        primaryButton: .default(Text("Sure, Mr Devil"), action: {
                            Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(true)
                        }),
                        secondaryButton: .default(Text("I'm.. Not sure.."), action: {
                            Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(false)
                        }))
                }
        }
    }
}

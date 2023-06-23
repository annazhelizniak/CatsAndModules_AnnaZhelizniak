//
//  CatsApp.swift
//  Cats
//
//  Created by Anna on 21.05.2023.
//

import SwiftUI
import FirebaseCore
import FirebaseCrashlytics


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        let userDefaults = UserDefaults.standard
        if userDefaults.object(forKey: "user_consent") == nil {
            Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(false)
            userDefaults.set(false, forKey: "user_consent")
        } else {
            let userConsent = userDefaults.bool(forKey: "user_consent")
            Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(userConsent)
        }
        
        return true
    }
}

@main
struct CatsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State private var showAlert = UserDefaults.standard.object(forKey: "user_consent") == nil 
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    if self.showAlert {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.showAlert = true
                        }
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Enable crashlitics data collection?"),
                        message: Text("Your data will be sent to improve the performance of this app"),
                        primaryButton: .default(Text("Yes")) {
                            Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(true)
                            UserDefaults.standard.set(true, forKey: "user_consent")
                        },
                        secondaryButton: .cancel(Text("No")) {
                            Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(false)
                            UserDefaults.standard.set(false, forKey: "user_consent")
                        }
                    )
                }
        }
    }
}

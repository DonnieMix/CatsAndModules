//
//  CatsAndModulesApp.swift
//  CatsAndModules
//
//  Created by Kyrylo Derkach on 26.05.2023.
//

import SwiftUI
import Networking
import FirebaseCore

// app delegate class for Firebase setup
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct CatsAndModulesApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var animal: String? {
        return Bundle.main.object(forInfoDictionaryKey: "Animal") as? String
    }
    
    var body: some Scene {
        WindowGroup {
            switch animal {
                case "CATS":
                    CatsListView()
                case "DOGS":
                    DogsListView()
                default:
                    fatalError("Unknown app variation")
            }
        }
    }
}

//
//  AppDelegate.swift
//  FirebaseSample
//
//  Created by Masato Takamura on 2021/08/25.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        Router.shared.showRoot(window: UIWindow(frame: UIScreen.main.bounds))
        return true
    }


}


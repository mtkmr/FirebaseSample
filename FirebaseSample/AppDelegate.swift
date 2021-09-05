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
    
    //ユーザーのアクティビティに関連するデータを受け取ると呼ばれる
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        
        guard
            userActivity.activityType == NSUserActivityTypeBrowsingWeb,
            let url = userActivity.webpageURL
        else {
                return false
            }
        
        let handled = DynamicLinks.dynamicLinks()
            .handleUniversalLink(url) { dynamiclink, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                let email: String = UserDefaultsKey.email.get() ?? "Unknown"
                guard
                    let link = dynamiclink?.url?.absoluteString
                else { return }
                AuthService().signIn(email: email, link: link, completion: { result in
                    switch result {
                    case .failure(let error):
                        print(error.localizedDescription)
                    case .success(let authResult):
                        UserDefaultsKey.signIn.set(value: true)
                        Router.shared.showRoot(window: UIWindow(frame: UIScreen.main.bounds))
                    }
                })
          }

        return handled
    }

}


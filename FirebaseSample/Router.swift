//
//  Router.swift
//  FirebaseSample
//
//  Created by Masato Takamura on 2021/09/01.
//

import UIKit

final class Router {
    static let shared = Router()
    private init() {}
    
    private var window: UIWindow?
    
    func showRoot(window: UIWindow?) {
        let welcomeVC = UIStoryboard(name: "Welcome", bundle: nil).instantiateInitialViewController() as! WelcomeViewController
        let presenter = WelcomePresenter(output: welcomeVC)
        welcomeVC.inject(presenter: presenter)
        window?.rootViewController = welcomeVC
        window?.makeKeyAndVisible()
        self.window = window
    }
    
    func showRegister(from: UIViewController) {
        let registerVC = UIStoryboard(name: "Register", bundle: nil).instantiateInitialViewController() as! RegisterViewController
        let presenter = RegisterPresenter(output: registerVC)
        registerVC.inject(presenter: presenter)
        show(from: from, to: UINavigationController(rootViewController: registerVC))
    }
    
    func showPasswordSignIn(from: UIViewController) {
        let showPasswordSignInVC = UIStoryboard(name: "PasswordSignIn", bundle: nil).instantiateInitialViewController() as! PasswordSignInViewController
        let presenter = PasswordSignInPresenter(output: showPasswordSignInVC)
        showPasswordSignInVC.inject(presenter: presenter)
        show(from: from, to: UINavigationController(rootViewController: showPasswordSignInVC))
    }
}

private extension Router {
    /// 次のVCへ遷移する
    func show(
        from: UIViewController,
        to nextVC: UIViewController,
        animated: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        DispatchQueue.main.async {
            if let nav = from.navigationController {
                nav.pushViewController(nextVC,
                                       animated: animated)
                completion?()
            } else {
                from.present(nextVC,
                             animated: true,
                             completion: completion)
            }
        }
    }

}

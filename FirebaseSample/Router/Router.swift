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
        let isSignIn: Bool = UserDefaultsKey.signIn.get() ?? false
        if !isSignIn {
            //show welcome
            let welcomeVC = UIStoryboard(name: "Welcome", bundle: nil).instantiateInitialViewController() as! WelcomeViewController
            let presenter = WelcomePresenter(output: welcomeVC)
            welcomeVC.inject(presenter: presenter)
            window?.rootViewController = welcomeVC
        } else {
            //show didSignIn
            let didSignInVC = UIStoryboard(name: "DidSignIn", bundle: nil).instantiateInitialViewController() as! DidSignInViewController
            let presenter = DidSignInPresenter(output: didSignInVC)
            didSignInVC.inject(presenter: presenter)
            window?.rootViewController = didSignInVC
        }
        window?.makeKeyAndVisible()
        self.window = window
    }
    
    func showReset() {
        showRoot(window: window)
    }
    
    func showDidSignIn(from: UIViewController) {
        let didSignInVC = UIStoryboard(name: "DidSignIn", bundle: nil).instantiateInitialViewController() as! DidSignInViewController
        let presenter = DidSignInPresenter(output: didSignInVC)
        didSignInVC.inject(presenter: presenter)
        show(from: from, to: didSignInVC)
    }
    
    func showRegister(from: UIViewController) {
        let registerVC = UIStoryboard(name: "Register", bundle: nil).instantiateInitialViewController() as! RegisterViewController
        let presenter = RegisterPresenter(output: registerVC)
        registerVC.inject(presenter: presenter)
        show(from: from, to: UINavigationController(rootViewController: registerVC))
    }
    
    func showPasswordSignIn(from: UIViewController) {
        let passwordSignInVC = UIStoryboard(name: "PasswordSignIn", bundle: nil).instantiateInitialViewController() as! PasswordSignInViewController
        let presenter = PasswordSignInPresenter(output: passwordSignInVC)
        passwordSignInVC.inject(presenter: presenter)
        show(from: from, to: UINavigationController(rootViewController: passwordSignInVC))
    }
    
    func showPasswordLessSignIn(from: UIViewController) {
        let passwordLessVC = UIStoryboard(name: "PasswordLessSignIn", bundle: nil).instantiateInitialViewController() as! PasswordLessSignInViewController
        let presenter = PasswordLessSignInPresenter(output: passwordLessVC)
        passwordLessVC.inject(presenter: presenter)
        show(from: from, to: UINavigationController(rootViewController: passwordLessVC))
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
                nextVC.modalPresentationStyle = .fullScreen
                from.present(nextVC,
                             animated: true,
                             completion: completion)
            }
        }
    }

}

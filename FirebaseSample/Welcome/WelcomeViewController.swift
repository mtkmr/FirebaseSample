//
//  WelcomeViewController.swift
//  FirebaseSample
//
//  Created by Masato Takamura on 2021/09/01.
//

import UIKit

final class WelcomeViewController: UIViewController {
    
    private var welcomePresenter: WelcomePresenterInput!
    func inject(presenter: WelcomePresenterInput) {
        self.welcomePresenter = presenter
    }

    @IBOutlet private weak var anonymousSignInButton: UIButton! {
        didSet {
            anonymousSignInButton.addCornerRadius()
            anonymousSignInButton.addTarget(
                self,
                action: #selector(didTapAnonymousSignInButton(_:)),
                for: .touchUpInside
            )
        }
    }
    
    @IBOutlet private weak var registerButton: UIButton! {
        didSet {
            registerButton.addCornerRadius()
            registerButton.addTarget(
                self,
                action: #selector(didTapRegisterButton(_:)),
                for: .touchUpInside
            )
        }
    }
    
    @IBOutlet private weak var signInWithPasswordButton: UIButton! {
        didSet {
            signInWithPasswordButton.addCornerRadius()
            signInWithPasswordButton.addTarget(
                self,
                action: #selector(didTapSignInWithPasswordButton(_:)),
                for: .touchUpInside
            )
        }
    }
    
    @IBOutlet private weak var signInWithDynamicLinksButton: UIButton! {
        didSet {
            signInWithDynamicLinksButton.addCornerRadius()
            signInWithDynamicLinksButton.addTarget(
                self,
                action: #selector(didTapSignInWithDynamicLinksButton(_:)),
                for: .touchUpInside
            )
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
}

@objc
private extension WelcomeViewController {
    func didTapAnonymousSignInButton(_ sender: UIButton) {
        welcomePresenter.didTapAnonymousSignInButton()
    }
    
    func didTapRegisterButton(_ sender: UIButton) {
        welcomePresenter.didTapRegisterButton()
    }
    
    func didTapSignInWithPasswordButton(_ sender: UIButton) {
        welcomePresenter.didTapSignInWithPasswordButton()
    }
    
    func didTapSignInWithDynamicLinksButton(_ sender: UIButton) {
        welcomePresenter.didTapSignInWithDynamicLinksButton()
    }
}

extension WelcomeViewController: WelcomePresenterOutput {
    func showRegister() {
        DispatchQueue.main.async {
            Router.shared.showRegister(from: self)
        }
    }
    
    func showPasswordSignIn() {
        DispatchQueue.main.async {
            Router.shared.showPasswordSignIn(from: self)
        }
    }
    
    func showPasswordLessSignIn() {
        DispatchQueue.main.async {
            Router.shared.showPasswordLessSignIn(from: self)
        }
    }
    
    func showDidSignIn() {
        DispatchQueue.main.async {
            Router.shared.showDidSignIn(from: self)
        }
    }
    
    
}

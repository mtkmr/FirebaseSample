//
//  PasswordSignInViewController.swift
//  FirebaseSample
//
//  Created by Masato Takamura on 2021/09/01.
//

import UIKit

final class PasswordSignInViewController: UIViewController {
    
    private var passwordSignInPresenter: PasswordSignInPresenterInput!
    func inject(presenter: PasswordSignInPresenterInput) {
        self.passwordSignInPresenter = presenter
    }
    
    @IBOutlet private weak var emailTextField: UITextField! {
        didSet {
            emailTextField.addBorderBottom(height: 2.0,
                                           color: UIColor.systemTeal)
        }
    }
    
    @IBOutlet private weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.addBorderBottom(height: 2.0,
                                              color: UIColor.systemTeal)
        }
    }
    
    @IBOutlet private weak var signInButton: UIButton! {
        didSet {
            signInButton.addCornerRadius()
            signInButton.addTarget(self,
                                 action: #selector(didTapSignInButton(_:)),
                                 for: .touchUpInside)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign in with password"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close,
                                                            target: self,
                                                            action: #selector(didTapCloseButton(_:)))
    }
    

   
}

@objc
private extension PasswordSignInViewController {
    func didTapCloseButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func didTapSignInButton(_ sender: UIButton) {
        passwordSignInPresenter.didTapSignInButton(email: emailTextField.text!,
                                                   password: passwordTextField.text!)
    }
}

extension PasswordSignInViewController: PasswordSignInPresenterOutput {
    func showAlert(title: String, message: String) {
        DispatchQueue.main.async {
            Alert.okAlert(title: title,
                          message: message,
                          on: self,
                          handler: { [weak self] ok in
                            self?.passwordSignInPresenter.didTapOK()
                          }
            )
        }
    }
    
    func showDidSignIn() {
        DispatchQueue.main.async {
            Router.shared.showDidSignIn(from: self)
        }
    }
}

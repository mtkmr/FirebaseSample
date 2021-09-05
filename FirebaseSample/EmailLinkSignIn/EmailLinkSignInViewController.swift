//
//  PasswordLessSignInViewController.swift
//  FirebaseSample
//
//  Created by Masato Takamura on 2021/09/03.
//

import UIKit

final class EmailLinkSignInViewController: UIViewController {
    
    private var passwordLessSignInPresenter: EmailLinkSignInPresenterInput!
    func inject(presenter: EmailLinkSignInPresenterInput) {
        self.passwordLessSignInPresenter = presenter
    }
    
    @IBOutlet private weak var emailTextField: UITextField! {
        didSet {
            emailTextField.addBorderBottom(height: 2.0,
                                           color: UIColor.systemPurple)
        }
    }
    @IBOutlet private weak var sendButton: UIButton! {
        didSet {
            sendButton.addCornerRadius()
            sendButton.addTarget(self,
                                 action: #selector(didTapSendButton(_:)),
                                 for: .touchUpInside)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Password Less Sign In"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(didTapCloseButton(_:))
        )
    }
    
}

@objc
private extension EmailLinkSignInViewController {
    func didTapSendButton(_ sender: UIButton) {
        passwordLessSignInPresenter.didTapSendButton(email: emailTextField.text!)
    }
    
    func didTapCloseButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension EmailLinkSignInViewController: EmailLinkSignInPresenterOutput {
    func showAlert(title: String, message: String) {
        DispatchQueue.main.async {
            Alert.okCancelAlert(title: title,
                                message: message,
                                on: self,
                                handler: { [weak self] OK in
                                  self?.dismiss(animated: true, completion: nil)
                                  self?.passwordLessSignInPresenter.didTapOK()
                                  
                                }
            )
        }
    }
    
    func openUrl(url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            print("メールアプリが開けません")
        }
    }
}

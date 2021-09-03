//
//  PasswordLessSignInViewController.swift
//  FirebaseSample
//
//  Created by Masato Takamura on 2021/09/03.
//

import UIKit

final class PasswordLessSignInViewController: UIViewController {
    
    private var passwordLessSignInPresenter: PasswordLessSignInPresenterInput!
    func inject(presenter: PasswordLessSignInPresenterInput) {
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
private extension PasswordLessSignInViewController {
    func didTapSendButton(_ sender: UIButton) {
        
    }
    
    func didTapCloseButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension PasswordLessSignInViewController: PasswordLessSignInPresenterOutput {
    
}

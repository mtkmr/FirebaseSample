//
//  RegisterViewController.swift
//  FirebaseSample
//
//  Created by Masato Takamura on 2021/09/01.
//

import UIKit

final class RegisterViewController: UIViewController {
    
    private var registerPresenter: RegisterPresenterInput!
    func inject(presenter: RegisterPresenterInput) {
        self.registerPresenter = presenter
    }
    
    @IBOutlet private weak var emailTextField: UITextField! {
        didSet {
            emailTextField.addBorderBottom(height: 2.0,
                                           color: UIColor.systemRed)
        }
    }
    
    @IBOutlet private weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.addBorderBottom(height: 2.0,
                                              color: UIColor.systemRed)
        }
    }
    
    @IBOutlet private weak var sendButton: UIButton! {
        didSet {
            sendButton.addCornerRadius()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Register"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close,
                                                            target: self,
                                                            action: #selector(didTapCloseButton(_:)))
    }
    
}

@objc
private extension RegisterViewController {
    func didTapCloseButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

extension RegisterViewController: RegisterPresenterOutput {
    
}

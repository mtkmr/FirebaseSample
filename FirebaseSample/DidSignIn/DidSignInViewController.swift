//
//  DidSignInViewController.swift
//  FirebaseSample
//
//  Created by Masato Takamura on 2021/09/03.
//

import UIKit

final class DidSignInViewController: UIViewController {
    
    private var didSignInPresenter: DidSignInPresenterInput!
    func inject(presenter: DidSignInPresenterInput) {
        self.didSignInPresenter = presenter
    }
    
    @IBOutlet private weak var signOutButton: UIButton! {
        didSet {
            signOutButton.addCornerRadius()
            signOutButton.addTarget(self,
                                    action: #selector(didTapSignOutButton(_:)),
                                    for: .touchUpInside)
        }
    }
    
    @IBOutlet private weak var deleteAccountButton: UIButton! {
        didSet {
            deleteAccountButton.addTarget(self,
                                          action: #selector(didTapDeleteAccountButton(_:)),
                                          for: .touchUpInside)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign In Success!"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
}

@objc
private extension DidSignInViewController {
    func didTapSignOutButton(_ sender: UIButton) {
        didSignInPresenter.didTapSignOutButton()
    }
    
    func didTapDeleteAccountButton(_ sender: UIButton) {
        didSignInPresenter.didTapDeleteAccountButton()
    }
}

extension DidSignInViewController: DidSignInPresenterOutput {
    
    func showSignOutAlert(title: String, message: String) {
        DispatchQueue.main.async {
            Alert.okCancelAlert(title: title,
                                message: message,
                                on: self,
                                handler:  { [weak self] signOut in
                                  self?.didSignInPresenter.willSignOut()
                                }
            )
        }
    }
    
    func showDeleteAccountAlert(title: String, message: String) {
        DispatchQueue.main.async {
            Alert.okCancelAlert(title: title,
                                message: message,
                                on: self,
                                handler:  { [weak self] delete in
                                  self?.didSignInPresenter.willDelete()
                                }
            )
        }
    }
    
    func showReset() {
        DispatchQueue.main.async {
            Router.shared.showReset()
        }
    }
}

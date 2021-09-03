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
}

extension DidSignInViewController: DidSignInPresenterOutput {
    
    func showAlert(title: String, message: String) {
        DispatchQueue.main.async {
            Alert.okCancelAlert(title: title,
                                message: message,
                                on: self,
                                handler:  { [weak self] ok in
                                  self?.didSignInPresenter.didTapOK()
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

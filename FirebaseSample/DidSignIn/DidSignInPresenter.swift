//
//  DidSignInPresenter.swift
//  FirebaseSample
//
//  Created by Masato Takamura on 2021/09/03.
//

import Foundation

protocol DidSignInPresenterInput {
    func didTapSignOutButton()
    func didTapDeleteAccountButton()
    func willSignOut()
    func willDelete()
}

protocol DidSignInPresenterOutput: AnyObject {
    func showSignOutAlert(title: String, message: String)
    func showDeleteAccountAlert(title: String, message: String)
    func showReset()
}

final class DidSignInPresenter {
    private var output: DidSignInPresenterOutput!
    private let authService: AuthServiceInput!
    
    init(output: DidSignInPresenterOutput, authService: AuthServiceInput = AuthService()) {
        self.output = output
        self.authService = authService
    }
}

extension DidSignInPresenter: DidSignInPresenterInput {
    
    func didTapSignOutButton() {
        output.showSignOutAlert(title: "ログアウトしますか", message: "")
    }
    
    func willSignOut() {
        authService.signOut { [weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let message):
                print(message)
                UserDefaultsKey.signIn.set(value: false)
                self?.output.showReset()
            }
        }
    }
    
    func willDelete() {
        authService.deleteAccount { [weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let message):
                print(message)
                UserDefaultsKey.signIn.remove()
                self?.output.showReset()
            }
        }
    }
    
    func didTapDeleteAccountButton() {
        output.showDeleteAccountAlert(title: "アカウントを削除しますか", message: "")
    }
    
}

//
//  PasswordSignInPresenter.swift
//  FirebaseSample
//
//  Created by Masato Takamura on 2021/09/01.
//

import Foundation

protocol PasswordSignInPresenterInput {
    func didTapSignInButton(email: String, password: String)
    func didTapOK()
}

protocol PasswordSignInPresenterOutput: AnyObject {
    func showAlert(title: String, message: String)
    func showDidSignIn()
}

final class PasswordSignInPresenter {
    private var output: PasswordSignInPresenterOutput!
    private let authService: AuthServiceInput!
    
    init(output: PasswordSignInPresenterOutput, authService: AuthServiceInput = AuthService()) {
        self.output = output
        self.authService = authService
    }
}

extension PasswordSignInPresenter: PasswordSignInPresenterInput {
    func didTapSignInButton(email: String, password: String) {
        authService.signIn(email: email,
                           password: password,
                           completion: { [weak self] result in
                            switch result {
                            case .failure(let error):
                                print(error.localizedDescription)
                            case .success(let authResult):
                                guard let user = authResult?.user else { return }
                                print("\(user.uid)がログインしました")
                                UserDefaultsKey.signIn.set(value: true)
                                self?.output.showAlert(title: "ログインします", message: "")
                            }
                           }
        )
    }
    
    func didTapOK() {
        output.showDidSignIn()
    }
    
    
    
    
}

//
//  WelcomePresenter.swift
//  FirebaseSample
//
//  Created by Masato Takamura on 2021/09/01.
//

import Foundation

protocol WelcomePresenterInput {
    func didTapAnonymousSignInButton()
    func didTapRegisterButton()
    func didTapSignInWithPasswordButton()
    func didTapSignInWithDynamicLinksButton()
}

protocol WelcomePresenterOutput: AnyObject {
    func showRegister()
    func showPasswordSignIn()
    func showPasswordLessSignIn()
    func showDidSignIn()
}

final class WelcomePresenter {
    private var output: WelcomePresenterOutput!
    private let authService: AuthServiceInput!
    
    init(output: WelcomePresenterOutput, authService: AuthServiceInput = AuthService()) {
        self.output = output
        self.authService = authService
    }
}

extension WelcomePresenter: WelcomePresenterInput {
    
    func didTapAnonymousSignInButton() {
        //anonymous sign in
        authService.anonymousSignIn(completion: { [weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let authResult):
                guard let user = authResult?.user else { return }
                UserDefaultsKey.signIn.set(value: true)
                self?.output.showDidSignIn()
            }
            
        })
    }
    
    func didTapRegisterButton() {
        output.showRegister()
    }
    
    func didTapSignInWithPasswordButton() {
        output.showPasswordSignIn()
    }
    
    func didTapSignInWithDynamicLinksButton() {
        output.showPasswordLessSignIn()
    }
    
    
}

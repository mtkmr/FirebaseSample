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
}

final class WelcomePresenter {
    private var output: WelcomePresenterOutput!
    
    init(output: WelcomePresenterOutput) {
        self.output = output
    }
}

extension WelcomePresenter: WelcomePresenterInput {
    
    func didTapAnonymousSignInButton() {
        //anonymous sign in
    }
    
    func didTapRegisterButton() {
        output.showRegister()
    }
    
    func didTapSignInWithPasswordButton() {
        output.showPasswordSignIn()
    }
    
    func didTapSignInWithDynamicLinksButton() {
        
    }
    
    
}

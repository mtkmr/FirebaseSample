//
//  PasswordLessSignInPresenter.swift
//  FirebaseSample
//
//  Created by Masato Takamura on 2021/09/03.
//

import Foundation

protocol PasswordLessSignInPresenterInput {
    
}

protocol PasswordLessSignInPresenterOutput: AnyObject {
    
}

final class PasswordLessSignInPresenter {
    private var output: PasswordLessSignInPresenterOutput!
    
    init(output: PasswordLessSignInPresenterOutput) {
        self.output = output
    }
}

extension PasswordLessSignInPresenter: PasswordLessSignInPresenterInput {
    
    
}

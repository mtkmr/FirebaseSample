//
//  PasswordSignInPresenter.swift
//  FirebaseSample
//
//  Created by Masato Takamura on 2021/09/01.
//

import Foundation

protocol PasswordSignInPresenterInput {
    
}

protocol PasswordSignInPresenterOutput: AnyObject {
    
}

final class PasswordSignInPresenter {
    private var output: PasswordSignInPresenterOutput!
    
    init(output: PasswordSignInPresenterOutput) {
        self.output = output
    }
}

extension PasswordSignInPresenter: PasswordSignInPresenterInput {
    
    
}

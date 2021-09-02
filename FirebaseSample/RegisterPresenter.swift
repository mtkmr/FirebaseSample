//
//  RegisterPresenter.swift
//  FirebaseSample
//
//  Created by Masato Takamura on 2021/09/01.
//

import Foundation

protocol RegisterPresenterInput {
    
}

protocol RegisterPresenterOutput: AnyObject {
    
}

final class RegisterPresenter {
    private var output: RegisterPresenterOutput!
    
    init(output: RegisterPresenterOutput) {
        self.output = output
    }
}

extension RegisterPresenter: RegisterPresenterInput {
    
    
}

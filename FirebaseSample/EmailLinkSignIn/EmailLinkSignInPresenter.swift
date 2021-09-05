//
//  PasswordLessSignInPresenter.swift
//  FirebaseSample
//
//  Created by Masato Takamura on 2021/09/03.
//

import Foundation

protocol EmailLinkSignInPresenterInput {
    func didTapSendButton(email: String)
    func didTapOK()
}

protocol EmailLinkSignInPresenterOutput: AnyObject {
    func showAlert(title: String, message: String)
    func openUrl(url: URL)
}

final class EmailLinkSignInPresenter {
    private var output: EmailLinkSignInPresenterOutput!
    private let authService: AuthServiceInput!
    
    init(output: EmailLinkSignInPresenterOutput, authService: AuthServiceInput = AuthService()) {
        self.output = output
        self.authService = authService
    }
}

extension EmailLinkSignInPresenter: EmailLinkSignInPresenterInput {
    func didTapSendButton(email: String) {
        authService.sendSignInLink(email: email) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let message):
                UserDefaultsKey.email.set(value: email) //ユーザーがリンクをクリックしてログインを完了するときに使用したい
                self?.output.showAlert(title: "認証メールを送りました",
                                       message: message)
            }
        }
    }
    
    func didTapOK() {
        if let url = URL(string: "message://") {
            output.openUrl(url: url)
        }
    }
    
    
    
}

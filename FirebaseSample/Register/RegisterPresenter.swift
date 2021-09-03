//
//  RegisterPresenter.swift
//  FirebaseSample
//
//  Created by Masato Takamura on 2021/09/01.
//

import Foundation

protocol RegisterPresenterInput {
    func didTapSendButton(email: String, password: String)
    func didTapOK()
}

protocol RegisterPresenterOutput: AnyObject {
    func showAlert(title: String, message: String)
    func dismiss()
}

final class RegisterPresenter {
    private var output: RegisterPresenterOutput!
    private let authService: AuthServiceInput!
    
    init(output: RegisterPresenterOutput, authService: AuthServiceInput = AuthService()) {
        self.output = output
        self.authService = authService
    }
}

extension RegisterPresenter: RegisterPresenterInput {
    
    func didTapSendButton(email: String, password: String) {
        authService.registerUser(email: email,
                                 password: password,
                                 completion: { [weak self] result in
                                  switch result {
                                  case .failure(let error):
                                    print(error.localizedDescription)
                                  case .success(let authResult):
                                    guard let user = authResult?.user else { return }
                                    print("\(user.uid) 登録完了")
                                    
                                    self?.output.showAlert(title: "登録完了しました",
                                                           message: "確認メールを送信しましたので、ご確認ください")
                                  }
                                 }
        )
    }
    
    func didTapOK() {
        output.dismiss()
    }
    
}

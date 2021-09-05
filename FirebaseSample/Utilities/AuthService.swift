//
//  AuthService.swift
//  FirebaseSample
//
//  Created by Masato Takamura on 2021/09/01.
//

import Firebase

protocol AuthServiceInput: AnyObject {
    func addUserStateChecker(completion: @escaping (User?) -> Void)
    func removeUserStateChecker()
    func anonymousSignIn(completion: ((Result<AuthDataResult?, Error>) -> Void)?)
    func registerUser(email: String,
                      password: String,
                      completion: ((Result<AuthDataResult?, Error>) -> Void)?)
    func sendEmail(completion: ((Result<String, Error>) -> Void)?)
    func sendSignInLink(email: String, completion: ((Result<String, Error>) -> Void)?)
    func signIn(email: String,
                password: String,
                completion: ((Result<AuthDataResult?, Error>) -> Void)?)
    func signOut(completion: ((Result<String, Error>) -> Void)?)
    func linkAccount(email: String,
                     password: String,
                     completion: ((Result<AuthDataResult?, Error>) -> Void)?
    )
    func sendPasswordReset(email: String, completion: ((Result<String, Error>) -> Void)?)
    func deleteAccount(completion: ((Result<String, Error>) -> Void)?)
}

final class AuthService {
    private var authHandle: AuthStateDidChangeListenerHandle?
    private let auth = Auth.auth()
}

extension AuthService: AuthServiceInput {
    /// リスナーを追加
    func addUserStateChecker(completion: @escaping (User?) -> Void) {
        authHandle = auth.addStateDidChangeListener({ _, user in
            guard
                let user = user
            else {
                completion(nil)
                return
            }
            completion(user)
        })
    }

    /// リスナーを切り取る
    func removeUserStateChecker() {
        auth.removeStateDidChangeListener(authHandle!)
    }

    /// 匿名ログイン
    func anonymousSignIn(completion: ((Result<AuthDataResult?, Error>) -> Void)? = nil) {
        auth.signInAnonymously { authResult, error in
            if let error = error {
                completion?(.failure(error))
                return
            }

            completion?(.success(authResult))
        }
    }

    /// ユーザー登録
    func registerUser(
        email: String,
        password: String,
        completion: ((Result<AuthDataResult?, Error>) -> Void)?
    ) {
        auth.createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion?(.failure(error))
                return
            }

            completion?(.success(authResult))
        }
    }

    /// アカウント認証メールを送信する
    func sendEmail(completion: ((Result<String, Error>) -> Void)?) {
        auth.currentUser?.sendEmailVerification(completion: { error in
            if let error = error {
                completion?(.failure(error))
                return
            }

            completion?(.success("メールのリンクから認証を完了してください"))
        })
    }
    
    /// メールリンクを送信する
    func sendSignInLink(email: String, completion: ((Result<String, Error>) -> Void)?) {
        let actionCodeSettings = ActionCodeSettings() //メールリンクの作成方法をFirebaseに伝えるオブジェクト
        actionCodeSettings.handleCodeInApp = true //ログインをアプリ内で完結させる必要がある
        actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!) //iOSデバイス内でログインリンクを開くアプリのBundleID
        //リンクURL
        var components = URLComponents()
        components.scheme = "https"
        components.host = "firebasesample01.page.link" //Firebaseコンソールで作成したダイナミックリンクURLドメイン
        let queryItemEmailName = "email" //URLにemail情報(パラメータ)を追加する
        let emailTypeQueryItem = URLQueryItem(name: queryItemEmailName, value: email)
        components.queryItems = [emailTypeQueryItem]
        guard let linkParameter = components.url else { return }
        actionCodeSettings.url = linkParameter
        //ユーザーのメールアドレスに認証リンクを送信
        auth.sendSignInLink(
            toEmail: email,
            actionCodeSettings: actionCodeSettings,
            completion: { error in
                if let error = error {
                    completion?(.failure(error))
                    return
                }
                completion?(.success("メールアプリを開きますか？"))
            }
        )
        
    }

    /// パスワードログイン
    func signIn(
        email: String,
        password: String,
        completion: ((Result<AuthDataResult?, Error>) -> Void)?
    ) {
        auth.signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion?(.failure(error))
                return
            }

            completion?(.success(authResult))
        }
    }
    
    ///メールリンクログイン
    func signIn(email: String,
                link: String,
                completion: ((Result<AuthDataResult?, Error>) -> Void)?
    ) {
        auth.signIn(withEmail: email,
                    link: link) { authResult, error in
            if let error = error {
                completion?(.failure(error))
                return
            }
            completion?(.success(authResult))
        }
    }

    /// ログアウト
    func signOut(completion: ((Result<String, Error>) -> Void)?) {
        do {
            try auth.signOut()
            completion?(.success("ログアウトします"))
        } catch {
            completion?(.failure(error))
        }
    }

    // 匿名アカウントから永久アカウントに
    func linkAccount(
        email: String,
        password: String,
        completion: ((Result<AuthDataResult?, Error>) -> Void)?
    ) {
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        guard let user = auth.currentUser else { return }
        user.link(with: credential) { authResult, error in
            if let error = error {
                completion?(.failure(error))
                return
            }

            completion?(.success(authResult))
        }
    }

    /// パスワードをリセットするためのメールを送信する
    func sendPasswordReset(
        email: String,
        completion: ((Result<String, Error>) -> Void)?
    ) {
        auth.sendPasswordReset(withEmail: email) { error in
            if let error = error {
                completion?(.failure(error))
                return
            }

            completion?(.success("パスワード再設定用のメールを送信しました"))
        }
    }

    /// アカウントを削除する
    func deleteAccount(completion: ((Result<String, Error>) -> Void)?) {
        guard let user = auth.currentUser else { return }
        user.delete { error in
            if let error = error {
                completion?(.failure(error))
                return
            }

            completion?(.success("アカウントが削除されました"))
        }
    }

}

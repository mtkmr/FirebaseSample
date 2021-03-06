//
//  Alert.swift
//  FirebaseSample
//
//  Created by Masato Takamura on 2021/09/01.
//

import UIKit

enum Alert {
    /// OK Alert
    static func okAlert(
        title: String,
        message: String,
        on viewController: UIViewController,
        handler: ((UIAlertAction) -> Void)? = nil
    ) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK",
                                     style: .default,
                                     handler: handler)
        alertController.addAction(okAction)
        viewController.present(alertController,
                               animated: true,
                               completion: nil)
    }

    /// OK & Cancel Alert
    static func okCancelAlert(
        title: String,
        message: String,
        on viewController: UIViewController,
        handler: ((UIAlertAction) -> Void)? = nil
    ) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK",
                                     style: .default,
                                     handler: handler)
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        viewController.present(alertController,
                               animated: true,
                               completion: nil)
    }
}


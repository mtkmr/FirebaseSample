//
//  UserDefaults.swift
//  FirebaseSample
//
//  Created by Masato Takamura on 2021/09/04.
//

import Foundation

protocol UserDefaultsProtocol: RawRepresentable {
    var rawValue: String { get }
}

extension UserDefaultsProtocol {
    func get<T>() -> T? {
        UserDefaults.standard.object(forKey: self.rawValue) as? T
    }

    func set<T>(value: T) {
        UserDefaults.standard.setValue(value, forKey: self.rawValue)
    }

    func remove() {
        UserDefaults.standard.removeObject(forKey: self.rawValue)
    }
}

enum UserDefaultsKey: String {
    case signIn
}

extension UserDefaultsKey: UserDefaultsProtocol {}

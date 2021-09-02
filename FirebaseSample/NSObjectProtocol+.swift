//
//  NSObjectProtocol+.swift
//  FirebaseSample
//
//  Created by Masato Takamura on 2021/09/01.
//

import Foundation

extension NSObjectProtocol {
    static var className: String {
        String(describing: self)
    }
}

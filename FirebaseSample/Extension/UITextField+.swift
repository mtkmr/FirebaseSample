//
//  UITextField+.swift
//  FirebaseSample
//
//  Created by Masato Takamura on 2021/09/01.
//

import UIKit

extension UITextField {
    // 下線をつける
    func addBorderBottom(height: CGFloat, color: UIColor) {
        let border = CALayer()
        border.frame = CGRect(x: 0,
                              y: self.frame.height - height,
                              width: self.frame.width,
                              height: height)
        border.backgroundColor = color.cgColor
        self.layer.addSublayer(border)
    }
}

//
//  UIView.swift
//  Bankaks-Assessment
//
//  Created by Fábio Maciel de Sousa on 03/12/20.
//

import UIKit

extension UIView{
    /// Shake animation used when textFields validations aren't fullfilled.
    func shakeAnimation() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: center.x - 10, y: center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: center.x + 10, y: center.y))
        layer.add(animation, forKey: "position")
    }
}

//
//  Extensions.swift
//  bottom-sheet-dialog
//
//  Created by Wallace Baldenebre on 04/10/21.
//


import Foundation
import UIKit

extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let roundedLayer = CAShapeLayer()
        roundedLayer.path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        ).cgPath
        layer.mask = roundedLayer
    }
    
    func fadeTo(
        _ alpha: CGFloat,
        duration: TimeInterval = 0.2,
        delay: TimeInterval = 0,
        completion: (() -> Void)? = nil) {
            
            UIView.animate(
                withDuration: duration,
                delay: delay,
                options: .curveEaseInOut,
                animations: {
                    self.alpha = alpha
                },
                completion: nil
            )
            
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                completion?()
            }
        }
    
    func fadeIn(duration: TimeInterval = 0.2, delay: TimeInterval = 0, completion: (() -> Void)? = nil) {
        fadeTo(1, duration: duration, delay: delay, completion: completion)
    }
    
    func fadeOut(duration: TimeInterval = 0.2, delay: TimeInterval = 0, completion: (() -> Void)? = nil) {
        fadeTo(0, duration: duration, delay: delay, completion: completion)
    }
}

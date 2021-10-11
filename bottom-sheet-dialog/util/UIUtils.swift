//
//  UIUtils.swift
//  bottom-sheet-dialog
//
//  Created by Wallace Baldenebre on 04/10/21.
//

import Foundation
import UIKit

func hexStringToUIColor(hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

extension String {
    func onExecute(_ onExecute: (String) -> Void) {
        onExecute(self)
    }
}

extension UIImage {
    func onExecute(_ onExecute: (UIImage) -> Void) {
        onExecute(self)
    }
}

extension UIView {
    func onExecute(_ onExecute: (UIView) -> Void) {
        onExecute(self)
    }
}

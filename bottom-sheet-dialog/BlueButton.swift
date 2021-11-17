//
//  BlueButton.swift
//  bottom-sheet-dialog
//
//  Created by Wallace Baldenebre on 07/10/21.
//

import Foundation
import UIKit

@IBDesignable
class BlueButton: Button {
    @IBInspectable open var leftColor: UIColor? = hexStringToUIColor(hex: "007cc3")
    @IBInspectable open var rightColor: UIColor? = hexStringToUIColor(hex: "285ec2")
    
    override init(context: UIViewController, title: String, selector: Selector) {
        super.init(context: context, title: title, selector: selector)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func build() -> UIButton {
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 25
        layer.masksToBounds = true
        return self
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.addGradientBackground()
    }
    
    private func addGradientBackground(){
        if let top = self.leftColor, let bottom = self.rightColor{
            self.setGradientBackground(top, bottom)
            self.layoutIfNeeded()
        }
    }
    
    func setGradientBackground(_ leftColor: UIColor?, _ rightColor: UIColor?) -> Void {
        if let leftColor = leftColor, let rightColor = rightColor {
            if leftColor == rightColor {
                return
            }
        }
        
        let colorLeft =  (leftColor ?? .clear).cgColor
        let colorRight = (rightColor ?? .clear).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ colorLeft, colorRight]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

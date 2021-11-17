//
//  BlueButton.swift
//  bottom-sheet-dialog
//
//  Created by Wallace Baldenebre on 07/10/21.
//

import Foundation
import UIKit

class BlueButton: Button {
    override init(context: UIViewController, title: String, selector: Selector) {
        super.init(context: context, title: title, selector: selector)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func build() -> UIButton {
        button?.setTitleColor(.white, for: .normal)
        button?.layer.cornerRadius = 25
        button?.layer.masksToBounds = true
        button?.backgroundColor =  hexStringToUIColor(hex: "#1565C0")
        return button!
    }
}

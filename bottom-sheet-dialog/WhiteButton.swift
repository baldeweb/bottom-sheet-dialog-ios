//
//  WhiteButton.swift
//  bottom-sheet-dialog
//
//  Created by Wallace Baldenebre on 07/10/21.
//

import Foundation
import UIKit

class WhiteButton: Button {
    override init(context: UIViewController, title: String, selector: Selector) {
        super.init(context: context, title: title, selector: selector)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func build() -> UIButton {
        button?.setTitleColor(hexStringToUIColor(hex: "#616161"), for: .normal)
        button?.backgroundColor = hexStringToUIColor(hex: "#FFFFFF")
        button?.layer.borderWidth = 1
        button?.layer.borderColor = hexStringToUIColor(hex: "#D8D8D8").cgColor
        return button!
    }
}

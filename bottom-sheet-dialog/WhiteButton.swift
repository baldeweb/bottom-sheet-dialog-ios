//
//  WhiteButton.swift
//  bottom-sheet-dialog
//
//  Created by Wallace Baldenebre on 07/10/21.
//

import Foundation
import UIKit

@IBDesignable
class WhiteButton: Button {
    override init(context: UIViewController, title: String, selector: Selector) {
        super.init(context: context, title: title, selector: selector)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func build() -> UIButton {
        setTitleColor(hexStringToUIColor(hex: "#666666"), for: .normal)
        backgroundColor = hexStringToUIColor(hex: "#FFFFFF")
        layer.borderWidth = 1
        layer.borderColor = hexStringToUIColor(hex: "#D8D8D8").cgColor
        return self
    }
}

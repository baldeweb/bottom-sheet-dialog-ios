//
//  WhiteButton.swift
//  bottom-sheet-dialog
//
//  Created by Wallace Baldenebre on 07/10/21.
//

import Foundation
import UIKit

class WhiteButton: Button {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func build(context: UIViewController, title: String, selector: Selector) -> UIButton {
        super.build(context: context, title: title, selector: selector)
        button?.setTitleColor(hexStringToUIColor(hex: "#616161"), for: .normal)
        button?.backgroundColor = hexStringToUIColor(hex: "#F5F5F5")
        button?.layer.borderWidth = 1
        button?.layer.borderColor = hexStringToUIColor(hex: "#BDBDBD").cgColor
        return button!
    }
}

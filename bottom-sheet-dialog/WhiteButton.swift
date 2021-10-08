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
    
    override func Build(context: UIViewController, title: String, selector: Selector) -> UIButton {
        super.Build(context: context, title: title, selector: selector)
        button?.setTitleColor(hexStringToUIColor(hex: "#616161"), for: .normal)
        button?.backgroundColor =  hexStringToUIColor(hex: "#E0E0E0")
        return button!
    }
}

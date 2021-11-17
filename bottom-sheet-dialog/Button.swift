//
//  Button.swift
//  viewcode
//
//  Created by Wallace Baldenebre on 03/10/21.
//

import Foundation
import UIKit

@IBDesignable
open class Button: UIButton {
    
    init(context: UIViewController, title: String, selector: Selector) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        addTarget(context, action: selector, for: .touchUpInside)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

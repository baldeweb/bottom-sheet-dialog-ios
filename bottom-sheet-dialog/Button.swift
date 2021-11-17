//
//  Button.swift
//  viewcode
//
//  Created by Wallace Baldenebre on 03/10/21.
//

import Foundation
import UIKit

open class Button: UIButton {
    
    open var button: UIButton?
    
    init(context: UIViewController, title: String, selector: Selector) {
        super.init(frame: .zero)
        button = UIButton(frame: .zero)
        button?.setTitle(title, for: .normal)
        button?.addTarget(context, action: selector, for: .touchUpInside)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

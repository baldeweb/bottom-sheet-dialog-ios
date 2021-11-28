//
//  BottomSheetLayoutDialog.swift
//  bottom-sheet-dialog
//
//  Created by Wallace Baldenebre on 31/10/21.
//

import UIKit
import SnapKit

open class BottomSheetLayoutDialog: BottomSheetViewController {
    private var layout: UIViewController!
    
    init?(
        style: DialogStyleEnum? = nil,
        isScrollable: Bool? = nil,
        icon: UIImage? = nil,
        titleLabel: String? = nil,
        layout: UIViewController,
        titleActionButton: String? = nil,
        actionButton: (() -> Void)? = nil,
        titleReturnButton: String? = nil,
        actionReturnButton: (() -> Void)? = nil
    ) {
        super.init(
            style: style,
            isScrollable: isScrollable,
            icon: icon,
            titleLabel: titleLabel,
            titleActionButton: titleActionButton,
            actionButton: actionButton,
            titleReturnButton: titleReturnButton,
            actionReturnButton: actionReturnButton
        )
        self.layout = layout
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        addConstraintsHeader = { make in
            if self.icon != nil {
                make.topMargin.equalTo(self.image!).offset(40)
            }
        }
        
        addMiddleComponents = {
            self.embed(self.containerView, self.layout)
        }
        
        addConstraintsMiddleComponents = {
            self.layout.view.snp.makeConstraints { make in
                if self.titleDialog != nil {
                    make.topMargin.equalTo(self.titleLabel.snp.bottomMargin).offset(20)
                }
                make.leading.equalTo(self.containerView).offset(20)
                make.trailing.equalTo(self.containerView).inset(20)
                make.height.greaterThanOrEqualTo(0)
            }
        }
        
        addConstraintsVerticalStackView = { make in
            make.topMargin.equalTo(self.layout.view.snp.bottomMargin).offset(20)
        }
        
        super.viewDidLoad()
    }
}

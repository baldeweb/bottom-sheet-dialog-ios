//
//  BottomSheetConfirmationDialog.swift
//  bottom-sheet-dialog
//
//  Created by Wallace on 08/11/21.
//

import Foundation
import SnapKit

class BottomSheetConfirmationDialog: BottomSheetDialog {
    
    init?(
        isScrollable: Bool? = nil,
        icon: UIImage? = nil,
        titleLabel: String? = nil,
        description: String? = nil,
        titleLeftButton: String? = nil,
        actionLeftButton: (() -> Void)? = nil,
        titleRightButton: String? = nil,
        actionRightButton: (() -> Void)? = nil
    ) {
        super.init(
            style: .ACTION_BY_ACTION,
            isScrollable: isScrollable,
            icon: icon,
            titleLabel: titleLabel,
            description: description,
            titleActionButton: titleRightButton,
            actionButton: actionRightButton,
            titleReturnButton: titleLeftButton,
            actionReturnButton: actionLeftButton
        )
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

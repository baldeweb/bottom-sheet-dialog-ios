//
//  BottomSheetComboViewController.swift
//  bottom-sheet-dialog
//
//  Created by Wallace Baldenebre on 28/11/21.
//

import Foundation
import SnapKit

class BottomSheetComboDialog: BottomSheetLayoutDialog {
    
    open lazy var containerInfoView: UIView = {
        let view = UIView()
        view.backgroundColor = hexStringToUIColor(hex: "#EEEEEE")
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = hexStringToUIColor(hex: "#FFFFFF")
        return view
    }()
    
    private var layoutHeader: UIViewController!
    
    init?(
        style: DialogStyleEnum? = nil,
        icon: UIImage? = nil,
        titleLabel: String?,
        layoutBody: UIViewController,
        titleActionButton: String? = nil,
        actionButton: (() -> Void)? = nil,
        titleReturnButton: String? = nil,
        actionReturnButton: (() -> Void)? = nil
    ) {
        super.init(
            style: style,
            isScrollable: false,
            icon: icon,
            titleLabel: titleLabel,
            layout: layoutBody,
            titleActionButton: titleActionButton,
            actionButton: actionButton,
            titleReturnButton: titleReturnButton,
            actionReturnButton: actionReturnButton
        )
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        addConstraintsHeader = { make in
            if self.icon != nil {
                make.topMargin.equalTo(self.image!).offset(40)
            }
        }
        
        super.viewDidLoad()
    }
    
    func showInfoHeader(layoutInfo: UIViewController) {
        self.layoutHeader = layoutInfo
        super.view.addSubview(layoutInfo.view)
        
        layoutInfo.view.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(containerView)
            make.height.greaterThanOrEqualTo(0)
        }
    }
}

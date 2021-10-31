//
//  BottomSheetDialog.swift
//  bottom-sheet-dialog
//
//  Created by Wallace Baldenebre on 31/10/21.
//

import UIKit
import SnapKit

class BottomSheetDialog: BottomSheetViewController {
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.center = .zero
        label.sizeToFit()
        return label
    }()
    
    private var descriptionDialog: String?
    
    init?(
        style: DialogStyleEnum? = nil,
        isScrollable: Bool? = nil,
        icon: UIImage? = nil,
        titleLabel: String? = nil,
        description: String? = nil,
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
        self.descriptionDialog = description
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        addConstraintsHeader = { make in
            make.bottomMargin.equalTo(self.pickBar).offset(30)
        }
        
        addMiddleComponents = {
            if self.descriptionDialog != nil {
                self.descriptionLabel.text = self.descriptionDialog
                self.containerView.addSubview(self.descriptionLabel)
            }
        }
        
        addConstraintsMiddleComponents = {
            if self.descriptionDialog != nil {
                self.descriptionLabel.snp.makeConstraints { make in
                    if self.titleDialog != nil { make.topMargin.equalTo(self.titleLabel.snp.bottom).offset(6) }
                    make.leading.equalTo(self.containerView).offset(20)
                    make.trailing.equalTo(self.containerView).inset(20)
                    make.height.greaterThanOrEqualTo(0)
                }
            }
        }
        
        addConstraintsVerticalStackView = { make in
            if self.descriptionDialog == nil && self.titleDialog != nil {
                make.topMargin.equalTo(self.titleLabel).offset(35)
            }
            if self.descriptionDialog != nil {
                make.topMargin.equalTo(self.descriptionLabel.snp.bottomMargin).offset(30)
            }
        }
        
        super.viewDidLoad()
    }
}

//
//  ViewController.swift
//  bottom-sheet-dialog
//
//  Created by Wallace Baldenebre on 04/10/21.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func openDialogPressed(_ sender: Any) {
        bottomsheetDialog(
            layout: LayoutBeautyView(
                titleLabel: "Lorem Ipsum",
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam posuere consequat magna quis consectetur. Sed lobortis ut enim in pretium. Vestibulum viverra, purus sed accumsan facilisis, turpis turpis scelerisque ex, eu ultrices odio leo in neque. Aenean euismod erat a massa egestas malesuada. Aliquam ac lacus dapibus, pulvinar sem a, laoreet justo. Morbi volutpat a neque eu semper. Etiam rutrum leo vel elit viverra accumsan. Mauris sed mattis metus. Vivamus fermentum facilisis urna."
            )!,
            icon: UIImage(named: "icon_check"),
            titleLabel: "Atenção",
            titleActionButton: "Confirmar",
            actionButton: {
                print("ACAO BOTAO")
            }
        )
    }
    
    private func bottomsheetDialog(
        layout: UIViewController,
        style: DialogStyleEnum? = nil,
        isScrollable: Bool? = nil,
        icon: UIImage? = nil,
        titleLabel: String? = nil,
        titleActionButton: String? = nil,
        actionButton: (() -> Void)? = nil,
        titleReturnButton: String? = nil,
        actionReturnButton: (() -> Void)? = nil
    ) {
        let dialog = BottomSheetDialog(
            layout: layout,
            style: style,
            icon: icon,
            titleLabel: titleLabel,
            titleActionButton: titleActionButton,
            actionButton: actionButton,
            titleReturnButton: titleReturnButton,
            actionReturnButton: actionReturnButton
        )!
        dialog.modalPresentationStyle = .overCurrentContext
        self.present(dialog, animated: false)
    }
    
    private func bottomsheetDialog(
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
        let dialog = BottomSheetDialog(
            style: style,
            icon: icon,
            titleLabel: titleLabel,
            description: description,
            titleActionButton: titleActionButton,
            actionButton: actionButton,
            titleReturnButton: titleReturnButton,
            actionReturnButton: actionReturnButton
        )!
        dialog.modalPresentationStyle = .overCurrentContext
        self.present(dialog, animated: false)
    }
}


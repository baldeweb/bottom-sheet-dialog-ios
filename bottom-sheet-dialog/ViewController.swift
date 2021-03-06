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
//        bottomsheetConfirmationDialog(
//            icon: UIImage(named: "icon_check"),
//            titleLabel: "Lorem Ipsum",
//            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam posuere consequat magna quis consectetur. Sed lobortis ut enim in pretium. Vestibulum viverra, purus sed accumsan facilisis, turpis turpis scelerisque ex, eu ultrices odio leo in neque. Aenean euismod erat a massa egestas malesuada. Aliquam ac lacus dapibus, pulvinar sem a, laoreet justo. Morbi volutpat a neque eu semper. Etiam rutrum leo vel elit viverra accumsan. Mauris sed mattis metus. Vivamus fermentum facilisis urna.",
//            titleLeftButton: "Não",
//            actionLeftButton: {
//
//            },
//            titleRightButton: "Sim",
//            actionRightButton: {
//
//            }
//        )
        
        bottomsheetDialog(
            icon: UIImage(named: "icon_check"),
            titleLabel: "Lorem Ipsum",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam posuere consequat magna quis consectetur. Sed lobortis ut enim in pretium. Vestibulum viverra, purus sed accumsan facilisis, turpis turpis scelerisque ex, eu ultrices odio leo in neque. Aenean euismod erat a massa egestas malesuada. Aliquam ac lacus dapibus, pulvinar sem a, laoreet justo. Morbi volutpat a neque eu semper. Etiam rutrum leo vel elit viverra accumsan. Mauris sed mattis metus. Vivamus fermentum facilisis urna.",
            titleActionButton: "Confirmar",
            actionButton: {

            },
            titleReturnButton: "Voltar",
            actionReturnButton: {

            }
        )
        
        //        bottomsheetLayoutDialog(
        //            icon: UIImage(named: "icon_check"),
        //            titleLabel: "Lorem Ipsum",
        //            layout: LayoutBeautyView(
        //                titleLabel: "Lorem Ipsum",
        //                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam posuere consequat magna quis consectetur. Sed lobortis ut enim in pretium. Vestibulum viverra, purus sed accumsan facilisis, turpis turpis scelerisque ex, eu ultrices odio leo in neque. Aenean euismod erat a massa egestas malesuada. Aliquam ac lacus dapibus, pulvinar sem a, laoreet justo. Morbi volutpat a neque eu semper. Etiam rutrum leo vel elit viverra accumsan. Mauris sed mattis metus. Vivamus fermentum facilisis urna."
        //            )!,
        //            titleActionButton: "Confirmar",
        //            actionButton: {
        //
        //            },
        //            titleReturnButton: "Voltar",
        //            actionReturnButton: {
        //
        //            }
        //        )
    }
    
    private func bottomsheetLayoutDialog(
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
        let dialog = BottomSheetLayoutDialog(
            style: style,
            isScrollable: isScrollable,
            icon: icon,
            titleLabel: titleLabel,
            layout: layout,
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
            isScrollable: isScrollable,
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
    
    private func bottomsheetConfirmationDialog(
        isScrollable: Bool? = nil,
        icon: UIImage? = nil,
        titleLabel: String? = nil,
        description: String? = nil,
        titleLeftButton: String? = nil,
        actionLeftButton: (() -> Void)? = nil,
        titleRightButton: String? = nil,
        actionRightButton: (() -> Void)? = nil
    ) {
        let dialog = BottomSheetConfirmationDialog(
            isScrollable: isScrollable,
            icon: icon,
            titleLabel: titleLabel,
            description: description,
            titleLeftButton: titleLeftButton,
            actionLeftButton: actionLeftButton,
            titleRightButton: titleRightButton,
            actionRightButton: actionRightButton
        )!
        dialog.modalPresentationStyle = .overCurrentContext
        self.present(dialog, animated: false)
    }
}


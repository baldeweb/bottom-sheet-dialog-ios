//
//  ViewController.swift
//  bottom-sheet-dialog
//
//  Created by Wallace Baldenebre on 04/10/21.
//

import UIKit

class ViewController: UIViewController {
    private var dialog: BottomSheetComboDialog!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showDialog()
    }
    
    private func showDialog() {
        dialog = BottomSheetComboDialog(
            icon: UIImage(named: "icon_check"),
            titleLabel: "Lorem Ipsum",
            layoutBody: LayoutBeautyView(
            titleLabel: "Lorem Ipsum",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam posuere consequat magna quis consectetur. Sed lobortis ut enim in pretium. Vestibulum viverra, purus sed accumsan facilisis, turpis turpis scelerisque ex, eu ultrices odio leo in neque. Aenean euismod erat a massa egestas malesuada. Aliquam ac lacus dapibus, pulvinar sem a, laoreet justo. Morbi volutpat a neque eu semper. Etiam rutrum leo vel elit viverra accumsan. Mauris sed mattis metus. Vivamus fermentum facilisis urna."
            )!,
            titleActionButton: "Confirmar",
            actionButton: {
                let layoutHeader = LayoutBeautyView(
                titleLabel: "Lorem Ipsum",
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam posuere consequat magna quis consectetur. Sed lobortis ut enim in pretium. Vestibulum viverra, purus sed accumsan facilisis, turpis turpis scelerisque ex, eu ultrices odio leo in neque. Aenean euismod erat a massa egestas malesuada. Aliquam ac lacus dapibus, pulvinar sem a, laoreet justo. Morbi volutpat a neque eu semper. Etiam rutrum leo vel elit viverra accumsan. Mauris sed mattis metus. Vivamus fermentum facilisis urna."
                )!
                self.dialog.showInfoHeader(layoutHeader: layoutHeader)
            },
            titleReturnButton: "Voltar",
            actionReturnButton: {

            }
        )!
        dialog.modalPresentationStyle = .overCurrentContext
        self.present(dialog, animated: false)
    }
    
    @IBAction func openDialogPressed(_ sender: Any) {
        let layoutHeader = LayoutBeautyView(
        titleLabel: "Lorem Ipsum",
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam posuere consequat magna quis consectetur. Sed lobortis ut enim in pretium. Vestibulum viverra, purus sed accumsan facilisis, turpis turpis scelerisque ex, eu ultrices odio leo in neque. Aenean euismod erat a massa egestas malesuada. Aliquam ac lacus dapibus, pulvinar sem a, laoreet justo. Morbi volutpat a neque eu semper. Etiam rutrum leo vel elit viverra accumsan. Mauris sed mattis metus. Vivamus fermentum facilisis urna."
        )!
        dialog.showInfoHeader(layoutHeader: layoutHeader)
    }
}

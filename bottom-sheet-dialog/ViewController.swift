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
        let dialog = BottomSheetDialog(
            layout: LayoutBeautyView(titleLabel: "Titulo", description: "Descricao")!,
            isScrollable: true,
            icon: UIImage(named: "icon_check")!,
            titleLabel: "Atenção",
            titleActionButton: "Entendi",
            actionButton: {
                print("LOG >> AÇAO PRIMEIRO BOTAO")
            }
        )!
        dialog.modalPresentationStyle = .overCurrentContext
        self.present(dialog, animated: false)
    }
    
}


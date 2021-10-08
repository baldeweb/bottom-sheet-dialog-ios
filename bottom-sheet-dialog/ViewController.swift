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
            style: .DEFAULT,
            isScrollable: false,
            icon: UIImage(named: "icon_check")!,
            titleLabel: "Atenção",
            description: "Estamos passando por problemas. \nVolte mais tarde.",
            titleFirstButton: "Entendi",
            actionFirstButton: {
                print("LOG >> AÇAO PRIMEIRO BOTAO")
            },
            titleSecondButton: "Voltar",
            actionSecondButton: {
                print("LOG >> AÇAO SEGUNDO BOTAO")
            }
        )!
        dialog.modalPresentationStyle = .overCurrentContext
        self.present(dialog, animated: false)
    }
    
}


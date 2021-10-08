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
        print("LOG >> CLICOU")
        let vc = BottomSheetDialog(
            style: .DEFAULT,
            isScrollable: true,
            icon: UIImage(named: "icon_check")!,
            titleLabel: "Titulo",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin iaculis massa et nisi volutpat laoreet. Mauris nec tincidunt lacus. Quisque consequat mi a sem semper malesuada. Vivamus mauris urna, interdum in urna eu, cursus consectetur est. Praesent malesuada a arcu eu tincidunt. ",
            titleFirstButton: "PRIMEIRO BOTÃO",
            actionFirstButton: {
                print("LOG >> AÇAO PRIMEIRO BOTAO")
            },
            titleSecondButton: "SEGUNDO BOTÃO",
            actionSecondButton: {
                print("LOG >> AÇAO SEGUNDO BOTAO")
            }
        )!
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
}


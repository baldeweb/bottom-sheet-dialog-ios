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
        
        let vc = BottomSheetDialog(style: .BUTTONS_SIDE_BY_SIDE, title: "Titulo", description: "Descricao")!
        vc.modalPresentationStyle = .overCurrentContext
        // keep false
        // modal animation will be handled in VC itself
        self.present(vc, animated: false)
    }
    
}


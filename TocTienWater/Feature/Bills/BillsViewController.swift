//
//  BillsViewController.swift
//  TocTienWater
//
//  Created by Nhat on 3/9/25.
//

import UIKit

class BillsViewController: BaseViewController {
    weak var coordinator: BillsCoordinator?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        showHeader(true)
        configureHeader(title: "thoi nao", leftButtonAction: {
            self.navigationController?.popViewController(animated: true)
        })
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

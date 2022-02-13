//
//  MainViewController.swift
//  Debtor
//
//  Created by Арген on 12.02.2022.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func listButton(_ sender: UIButton) {
        let vc = DebtListViewController.instantiate()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addButton(_ sender: UIButton) {
        let vc = CreatViewController.instantiate()
        navigationController?.pushViewController(vc, animated: true)
    }
}

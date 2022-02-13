//
//  MeDebtTableViewCell.swift
//  Debtor
//
//  Created by Арген on 13.02.2022.
//

import UIKit

class MyDebtTableViewCell: UITableViewCell {

    static let identifier = "MyDebtTableViewCell"
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var cashLbl: UILabel!
    
    func setup(_ debt: MyDebtor) {
        nameLbl.text = debt.name
        cashLbl.text = debt.cash.formatted()
    }
    
    override func prepareForReuse() {
        nameLbl.text = nil
        cashLbl.text = nil
    }
}

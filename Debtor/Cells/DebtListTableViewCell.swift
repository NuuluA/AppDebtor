//
//  DebtListTableViewCell.swift
//  Debtor
//
//  Created by Арген on 13.02.2022.
//

import UIKit

class DebtListTableViewCell: UITableViewCell {

  static let identifier = "DebtListTableViewCell"

    @IBOutlet weak var surName: UILabel!
    @IBOutlet weak var cashLabel: UILabel!

    func configure(_ debt: Debtor) {
        surName.text = debt.name
        cashLabel.text = debt.cash.formatted()
    }
    
    override func prepareForReuse() {
        surName.text = nil
        cashLabel.text = nil
    }
}

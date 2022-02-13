//
//  Debtor.swift
//  Debtor
//
//  Created by Арген on 13.02.2022.
//

import Foundation
import RealmSwift

class Debtor: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var cash: Int = 0
}

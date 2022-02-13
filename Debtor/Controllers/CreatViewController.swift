//
//  CreatViewController.swift
//  Debtor
//
//  Created by Арген on 12.02.2022.
//

import UIKit
import RealmSwift

class CreatViewController: UIViewController {
    
    let textField = UITextField()

    @IBOutlet weak var surName: UITextField!
    @IBOutlet weak var cash: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func addNewPerson(_ sender: UIButton) {
        handleDebtor()
        navigationController?.popViewController(animated: false)
    }
    
    @IBAction func addMydebt(_ sender: UIButton) {
        
        let myDebt = MyDebtor()
        
        if let text = surName.text,
           text.isEmpty {
            creatAlert()
        }
        
        guard let text = surName.text,
              !text.isEmpty else { return }
        myDebt.name = text
        
        if let text = cash.text,
           text.isEmpty {
            creatAlert()
        }
        
        guard let money = cash.text,
              !money.isEmpty else { return }
        myDebt.cash = Int(money) ?? 0
        
        do {
            let realm = try! Realm()
            realm.beginWrite()
            realm.add(myDebt)
            try! realm.commitWrite()
        }
        navigationController?.popViewController(animated: false)
    }
    
    private func handleDebtor() {
        let debtor = Debtor()
        
        if let text = surName.text,
           text.isEmpty {
            creatAlert()
        }
        
        guard let textSurName = surName.text,
              !textSurName.isEmpty else { return }
        debtor.name = textSurName
        
        if let text = cash.text,
           text.isEmpty {
            creatAlert()
        }
        
        guard let money = cash.text,
              !money.isEmpty else { return }
        debtor.cash = Int(money) ?? 0
        
        do {
            let realm = try! Realm()
            realm.beginWrite()
            realm.add(debtor)
            try! realm.commitWrite()
        }
    }
    
    private func creatAlert() {
        let alert = UIAlertController(title: "Ошибка", message: "Заполните поле", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

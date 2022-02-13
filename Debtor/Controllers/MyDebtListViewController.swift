//
//  TableViewController.swift
//  Debtor
//
//  Created by Арген on 12.02.2022.
//

import UIKit
import RealmSwift

class MyDebtListViewController: UIViewController {
    
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    var myDebtor: Results<MyDebtor>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBarButton()
        myDebtor = realm.objects(MyDebtor.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        segmentController.selectedSegmentIndex = 1
        tableView.reloadData()
    }
    
    private func addBarButton() {
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .stop,
                                                             target: self,
                                                             action: #selector(goToRoot)),
                                              UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))]
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit,
                                                           target: self,
                                                           action: #selector(editButton))
    }
    
    @objc private func editButton() {
        let edit = !self.tableView.isEditing
        tableView.setEditing(edit, animated: true)
    }
    
    @objc private func addNewPerson() {
        let vc = CreatViewController.instantiate()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func goToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func changeVC(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            let vc = DebtListViewController.instantiate()
            navigationController?.pushViewController(vc, animated: false)
        }
    }
}

extension MyDebtListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myDebtor.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MyDebtTableViewCell.identifier, for: indexPath) as! MyDebtTableViewCell
        let debt = myDebtor[indexPath.row]
        cell.setup(debt)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let removeObject = myDebtor[indexPath.row]
        try! self.realm.write({
            realm.delete(removeObject)
        })
        
        tableView.reloadData()
    }
}

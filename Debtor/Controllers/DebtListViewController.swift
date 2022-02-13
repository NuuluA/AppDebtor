//
//  ListViewController.swift
//  Debtor
//
//  Created by Арген on 12.02.2022.
//

import UIKit
import RealmSwift

class DebtListViewController: UIViewController {
    
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    var debtor: Results<Debtor>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBarButton()
        debtor = realm.objects(Debtor.self)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        segmentController.selectedSegmentIndex = 0
        tableView.reloadData()
    }
    
    private func addBarButton() {
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .stop,
                            target: self,
                            action: #selector(goToRoot)),
            UIBarButtonItem(barButtonSystemItem: .add,
                            target: self,
                            action: #selector(addNewPerson))]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit,
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
        
        DispatchQueue.main.async { [weak self] in
            if sender.selectedSegmentIndex == 1 {
                let vc = MyDebtListViewController.instantiate()
                self?.navigationController?.pushViewController(vc, animated: false)
            }
        }
    }
}

extension DebtListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return debtor.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DebtListTableViewCell.identifier, for: indexPath) as! DebtListTableViewCell
        let debt = debtor[indexPath.row]
        cell.configure(debt)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       
        let removeObject = (debtor?[indexPath.row])!
        
        try! self.realm.write({
            realm.delete(removeObject)
        })
        
        tableView.reloadData()
    }
    
}


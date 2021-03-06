//
//  ViewController.swift
//  Dividio
//
//  Created by Caio Teodoro on 19/01/22.
//  Copyright © 2022 Caio Teodoro. All rights reserved.
//

import UIKit

class NamesViewController: UIViewController {
    
    var names: [String] = []
    
    @IBOutlet weak var namesTableView: UITableView!
    @IBOutlet weak var inviteContact: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    class NameCell: UITableViewCell {
        @IBOutlet var cellText: UILabel?
    }
    
    @IBAction func addPerson(_ sender: Any) {
        if let newName = textField.text, !newName.isEmpty {
            names.insert(newName, at: 0);
            namesTableView.beginUpdates();
            namesTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .right);
            namesTableView.endUpdates();
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        namesTableView.dataSource = self;
        namesTableView.tableFooterView = UIView(frame: .zero);
    }
}


extension NamesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = namesTableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath)
        cell.textLabel?.text = names[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            names.remove(at: indexPath.row)
            namesTableView.deleteRows(at: [indexPath], with: .fade)
        } 
    }
    

    
    
}

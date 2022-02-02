//
//  ViewController.swift
//  Dividio
//
//  Created by Caio Teodoro on 19/01/22.
//  Copyright © 2022 Caio Teodoro. All rights reserved.
//

import UIKit

class NamesViewController: UIViewController {
    
    var names: [Person] = []
    
    @IBOutlet weak var namesTableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var addPersonButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    
    @IBAction func addPerson(_ sender: Any) {
        if let newName = textField.text, !newName.isEmpty {
            names.insert(Person.init(name: newName, payment: 0, consumedItems: []), at: 0);
            namesTableView.beginUpdates();
            namesTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .right);
            namesTableView.endUpdates();
            textField.text = "";
            allowContinueButton ()
        }
    }
    
    @IBAction func sendDataThroughContinueButton(_ sender: Any) {
        
    }
    
    
    func allowContinueButton () {
        if names.isEmpty == true { continueButton.isEnabled = false;
        } else { continueButton.isEnabled = true; }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        namesTableView.dataSource = self;
        namesTableView.tableFooterView = UIView(frame: .zero);
        allowContinueButton ()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "namesToItemsSegue" {
            let destinationViewController: ItemsViewController = segue.destination as! ItemsViewController
            destinationViewController.people = names;
        }
    }
}


extension NamesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = namesTableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath)
        cell.textLabel?.text = names[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            names.remove(at: indexPath.row)
            namesTableView.deleteRows(at: [indexPath], with: .fade)
        }
        allowContinueButton ()
    }
}



//
//  ItemsViewController.swift
//  Dividio
//
//  Created by Caio Teodoro on 20/01/22.
//  Copyright © 2022 Caio Teodoro. All rights reserved.
//

import UIKit

class ItemsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var itemsTableView: UITableView!
    @IBOutlet weak var addItemButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var totalCostLabel: UILabel!
    
    var people: [Person] = [];
    var items: [Item] = [];
    var totalCost: Double = 0;
    
    @IBAction func addItem(_ sender: Any) {
        let newItemName = nameTextField.text
        let newItemPrice = priceTextField.text
        if !newItemName!.isEmpty && !newItemPrice!.isEmpty{
            items.insert(Item.init(name: newItemName!, price: Double(newItemPrice!) ?? 0.0), at: 0);
            itemsTableView.beginUpdates();
            itemsTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .right);
            itemsTableView.endUpdates();
            nameTextField.text = "";
            priceTextField.text = "";
            totalCost += Double(newItemPrice!)!;
            totalCostLabel.text = "valor total: R$ " +  String(totalCost);
            allowContinueButton ();
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addItem(Any.self)
        return true
    }
        
    override func viewDidLoad() {
        super.viewDidLoad();
        self.itemsTableView.dataSource = self;
        self.nameTextField.delegate = self;
        self.itemsTableView.tableFooterView = UIView(frame: .zero);
        self.allowContinueButton();
        }
        
    func allowContinueButton () {
        if items.isEmpty == true { continueButton.isEnabled = false;
        } else { continueButton.isEnabled = true; }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "itemsToPaymentsSegue" {
            let destinationViewController: PaymentsViewController = segue.destination as! PaymentsViewController
            destinationViewController.items = self.items;
            destinationViewController.people = self.people;
            destinationViewController.totalCost = self.totalCost;
        }
    }
        
}


extension ItemsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = itemsTableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemCell
        cell.itemNameLabel.text = items[indexPath.row].name;
        cell.itemPriceLabel.text = String( items[indexPath.row].price);
        return cell
    }
        
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            totalCost -= items[indexPath.row].price
            totalCostLabel.text = "valor total: R$ " + String(totalCost);
            items.remove(at: indexPath.row)
            itemsTableView.deleteRows(at: [indexPath], with: .fade)
        }
        allowContinueButton ()
    }
    
}

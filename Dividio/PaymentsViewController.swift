//
//  PaymentsViewController.swift
//  Dividio
//
//  Created by Caio Teodoro on 23/01/22.
//  Copyright © 2022 Caio Teodoro. All rights reserved.
//

import UIKit

class PaymentsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var people: [Person] = [];
    var items: [Item] = [];
    var listOfPayments: [Double] = [];
    var totalCost: Double = 0;
    var selected = 0;
    var position = 0;
    
    @IBOutlet weak var paymentTextField: WhiteTextField!
    @IBOutlet weak var personPicker: CustomPickerView!
    @IBOutlet weak var paymentsTableView: TableLayout!
    @IBOutlet weak var continueButton: PurpleButton!
    @IBOutlet weak var missingPaymentsLabel: UILabel!
    
    @IBAction func addPaymentButton(_ sender: Any) {
        
        let newPayment = Double(paymentTextField.text!)
        if newPayment != nil && (totalCost - newPayment!) >= 0 {
            listOfPayments.insert(newPayment!, at: 0);
            people[selected].payments.insert(newPayment!, at: people[selected].payments.count);
            
            
            paymentsTableView.beginUpdates();
            position = 0
            for i in 0...selected{
                position += people[i].payments.count;
            }
            position -= 1;
            
            paymentsTableView.insertRows(at: [IndexPath(row: position, section: 0)], with: .right);
            
            if let cell = paymentsTableView.cellForRow(at: IndexPath(row: position - people[selected].payments.count + 1, section: 0)) as? ItemCell {
                cell.itemPriceLabel.text = String(people[selected].payments.reduce(0, +));
            }
            paymentsTableView.endUpdates();
            
            
            paymentTextField.text = "";
            totalCost -= newPayment!;
            if (totalCost - newPayment!) != 0{
                missingPaymentsLabel.text = "ainda faltam: R$ " + String(totalCost)
            } else {
                missingPaymentsLabel.text =  "total atingido :)"
            }
            allowContinueButton ()
        } else {
            print("Não pode!!!")
            //set alert for user
        }
    }
    
    //PickerView Functions
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected = row
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return people.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100
    }
    
    func paymentsPickerViewSettings () {
        personPicker.transform = CGAffineTransform(rotationAngle: -90  * (.pi/180));
        personPicker.frame = CGRect(x: 0, y: 0, width: view.frame.width - 94, height: 45)
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let modeView = UIView()
        modeView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let modeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        modeLabel.textColor = .black
        modeLabel.text = people[row].name
        modeLabel.textAlignment = .center
        modeView.addSubview(modeLabel)
        modeView.transform = CGAffineTransform(rotationAngle: 90 * (.pi/180))
        return modeView
    }
    
    //Custom Functions
    func allowContinueButton () {
        if totalCost != 0 { continueButton.isEnabled = false;
        } else { continueButton.isEnabled = true; }
    }
    
    func dismissKeyboard () {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap);
    }
    
    //Essential Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.missingPaymentsLabel.text = "ainda faltam: R$ " + String(totalCost);
        self.personPicker.delegate = self;
        self.personPicker.dataSource = self;
        self.paymentsPickerViewSettings();
        
        self.paymentsTableView.dataSource = self;
        self.paymentsTableView.tableFooterView = UIView(frame: .zero);
        self.allowContinueButton();
        self.dismissKeyboard();
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "paymentsToAssignmentsSegue" {
            let destinationViewController: AssignmentsViewController = segue.destination as! AssignmentsViewController
            destinationViewController.items = self.items;
            destinationViewController.people = self.people;
        }
    }
}


extension PaymentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfPayments.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if people[selected].payments.count < 2 {
            let cell = paymentsTableView.dequeueReusableCell(withIdentifier: "paymentCell", for: indexPath) as! ItemCell
            cell.itemNameLabel.text = people[selected].name;
            cell.itemPriceLabel.text = String( people[selected].payments[0]);
            return cell
        } else {
            let cell = paymentsTableView.dequeueReusableCell(withIdentifier: "paymentCell", for: indexPath) as! ItemCell
            cell.itemNameLabel.text = "";
            cell.itemPriceLabel.text = String( people[selected].payments[people[selected].payments.count - 1]);
            cell.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1);
            return cell
        }
    }
        
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            listOfPayments.remove(at: indexPath.row)
            totalCost += people[indexPath.row].payments[0];
            people[indexPath.row].payments.remove(at: 0); //corrigir
            paymentsTableView.deleteRows(at: [indexPath], with: .fade)
            missingPaymentsLabel.text = "ainda faltam: R$ " + String(totalCost)
        }
        allowContinueButton ()
    }
    
}

//
//  AssignmentViewController.swift
//  Dividio
//
//  Created by Caio Teodoro on 30/01/22.
//  Copyright © 2022 Caio Teodoro. All rights reserved.
//

import UIKit

class PaymentsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    var people: [Person] = [];
    var items: [Item] = [];
    var listOfPayments: [Double] = [];
    var selected = 0;
    
    
    @IBOutlet weak var paymentTextField: WhiteTextField!
    @IBOutlet weak var personPicker: CustomPickerView!
    @IBOutlet weak var paymentsTableView: TableLayout!
    @IBOutlet weak var continueButton: PurpleButton!
    @IBOutlet weak var testLabel: UILabel!
    
    @IBAction func addPaymentButton(_ sender: Any) {
        let newPayment = Double(paymentTextField.text!)
        if newPayment != nil {
            people[selected].payment = newPayment!
            listOfPayments.insert(newPayment!, at: 0);
            paymentsTableView.beginUpdates();
            paymentsTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .right);
            paymentsTableView.endUpdates();
            //nameTextField.text = ""; tem como mover o seletor de nomes automaticamente?
            //personPicker.selectRow(0, inComponent: 1, animated: true)
            paymentTextField.text = "";
            allowContinueButton ()
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected = row
    }
    
    func allowContinueButton () {
        if listOfPayments == [] { continueButton.isEnabled = false;
        } else { continueButton.isEnabled = true; }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.personPicker.delegate = self;
        self.personPicker.dataSource = self;
        paymentsPickerViewSettings();
        
        paymentsTableView.dataSource = self;
        paymentsTableView.tableFooterView = UIView(frame: .zero);
        allowContinueButton ()
    }
    
    //PickerView Functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return people.count
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
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
      return 100
    }
    
    func paymentsPickerViewSettings () {
        personPicker.transform = CGAffineTransform(rotationAngle: -90  * (.pi/180));
        personPicker.frame = CGRect(x: 0, y: 0, width: view.frame.width - 94, height: 45)
    }
}


extension PaymentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfPayments.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //if nome já existe, return outro tipo
        
        let cell = paymentsTableView.dequeueReusableCell(withIdentifier: "paymentCell", for: indexPath) as! ItemCell
        cell.itemNameLabel.text = people[selected].name;
        cell.itemPriceLabel.text = String( people[selected].payment);
        // cell.backgroundColor = #colorLiteral(red: 0.9163278907, green: 0.9163278907, blue: 0.9163278907, alpha: 1);
        return cell
    }
        
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            listOfPayments.remove(at: indexPath.row)
            people[indexPath.row].payment = 0;
            paymentsTableView.deleteRows(at: [indexPath], with: .fade)
        }
        allowContinueButton ()
    }
    
}


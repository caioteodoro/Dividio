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
    var selected = 0;
    
    
    @IBOutlet weak var paymentTextField: WhiteTextField!
    @IBOutlet weak var personPicker: CustomPickerView!
    @IBOutlet weak var paymentsTableView: TableLayout!
    @IBOutlet weak var continueButton: PurpleButton!
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected = row
    }
    
    
    @IBAction func addPaymentButton(_ sender: Any) {
        let newPersonName = people[selected].name
        let newPayment = Double(paymentTextField.text!)
        if !newPersonName.isEmpty && newPayment != nil {
            people[selected].payment = newPayment!
            listOfPayments.insert(newPayment!, at: 0);
            paymentsTableView.beginUpdates();
            paymentsTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .right);
            paymentsTableView.endUpdates();
            //nameTextField.text = ""; tem como mover o seletor de nomes automaticamente?
            paymentTextField.text = "";
            allowContinueButton ()
        }
    }
    
    func allowContinueButton () {
        //var paymentsAmount: Double = 0;
        //for i in 0..<(people.count-1) {
        //    paymentsAmount += people[i].payment;
        //}
        //if paymentsAmount == 0
        if listOfPayments == [] { continueButton.isEnabled = false;
        } else { continueButton.isEnabled = true; }
    }
    
    
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
        let rotationAngle: CGFloat! = -90  * (.pi/180)
            let y = personPicker.frame.origin.y;
            personPicker.layer.shadowColor = #colorLiteral(red: 0.4705882353, green: 0.3529411765, blue: 0.8078431373, alpha: 1)
            personPicker.layer.shadowOffset = CGSize(width: -4, height: 4);
            personPicker.transform = CGAffineTransform(rotationAngle: rotationAngle);
            personPicker.frame = CGRect(x: paymentTextField.frame.origin.x, y: y - 15, width: view.frame.width - 94, height: 45)
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
}

extension PaymentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = paymentsTableView.dequeueReusableCell(withIdentifier: "paymentCell", for: indexPath) as! ItemCell
        cell.itemNameLabel.text = people[selected].name;
        cell.itemPriceLabel.text = String( people[selected].payment);
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

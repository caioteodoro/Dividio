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
    
    @IBOutlet weak var paymentTextField: WhiteTextField!
    @IBOutlet weak var personPicker: CustomPickerView!
    @IBOutlet weak var paymentsTableView: TableLayout!
    @IBOutlet weak var continueButton: PurpleButton!
    
    @IBAction func addPaymentButton(_ sender: Any) {
        let newPersonName = people[selected].name
        let newPayment = Double(paymentTextField.text!)
        if !newPersonName.isEmpty && newPayment != nil {
            people[selected].payment = newPayment!
            paymentsTableView.beginUpdates();
            paymentsTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .right);
            paymentsTableView.endUpdates();
            //nameTextField.text = ""; tem como mover o seletor de nomes automaticamente?
            paymentTextField.text = "";
            allowContinueButton ()
        }
    }
    
    
    func allowContinueButton () {
        var paymentsAmount: Double = 0;
        for i in 0..<(people.count-1) {
            paymentsAmount += people[i].payment;
        }
        if paymentsAmount == 0 { continueButton.isEnabled = false;
        } else { continueButton.isEnabled = true; }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return people.count
    }
    
    var selected = 0;
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected = row
    }
    
    //func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    //    return people[row].name
    //}
    
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
    }
}

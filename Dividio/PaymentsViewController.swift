//
//  PaymentsViewController.swift
//  Dividio
//
//  Created by Caio Teodoro on 23/01/22.
//  Copyright © 2022 Caio Teodoro. All rights reserved.
//

import UIKit

class PaymentsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, SendDataDelegateProtocol {
    
    var people: [Person] = [Person(name: "Caio", payment: 1), Person(name: "Lua", payment: 2)]
    
    func sendDataToPaymentsViewController(myData: [Person]) {
        self.people = myData;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "namesToItemsSegue" {
            let secondVC: NamesViewController = segue.destination as! NamesViewController
            secondVC.delegate = self
        }
    }
    
    @IBOutlet weak var personPicker: CustomPickerView!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return people.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return people[row].name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.personPicker.delegate = self;
        self.personPicker.dataSource = self;

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

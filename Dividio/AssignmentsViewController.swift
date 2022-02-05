//
//  AssignmentViewController.swift
//  Dividio
//
//  Created by Caio Teodoro on 30/01/22.
//  Copyright © 2022 Caio Teodoro. All rights reserved.
//

import UIKit

class AssignmentsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    var people: [Person] = [];
    var items: [Item] = [];
    var listOfPayments: [Double] = [];
    var selected = 0;
    //counter to proceed
    //fill array with 0s
    
    //cada vez que rolar o pickerView: salva seleções para o item, quando voltar para o item recarrega as seleções
    //if array = 0, cell.isSelected = false
    //if cell.isSelected, array = 1
    
    
    @IBOutlet weak var itemPicker: CustomPickerView!
    @IBOutlet weak var peopleTableView: TableLayout!
    @IBOutlet weak var continueButton: PurpleButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func segmentedControlChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            peopleTableView.deselectRow(at: IndexPath(row: 0, section: 0), animated: true)
        case 1:
            for i in 0...(people.count-1) {
                let indexPath = IndexPath(row: i, section: 0)
                peopleTableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
            }
            
        default:
            break
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected = row
    }
    
    func warningContinueButton () {
        //show message if an item has not been assigned to a person
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemPicker.delegate = self;
        self.itemPicker.dataSource = self;
        paymentsPickerViewSettings();
        segmentedControlSettings();
        
        peopleTableView.dataSource = self;
        peopleTableView.delegate = self;
        peopleTableView.tableFooterView = UIView(frame: .zero);
        peopleTableView.allowsMultipleSelection = true;
        warningContinueButton ()
        
    }
    
    func segmentedControlSettings(){
        segmentedControl.setTitleTextAttributes([.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)] , for: .normal)
        segmentedControl.setTitleTextAttributes([.foregroundColor: #colorLiteral(red: 0.2705882353, green: 0.2705882353, blue: 0.2705882353, alpha: 1)] , for: .selected)
    }
    
    //PickerView Functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let modeView = UIView()
        modeView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let modeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        modeLabel.textColor = .black
        modeLabel.text = items[row].name
        modeLabel.textAlignment = .center
        modeView.addSubview(modeLabel)
        modeView.transform = CGAffineTransform(rotationAngle: 90 * (.pi/180))
        return modeView
    }
    
    //do I need this func? it's in paymentsvc as well
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
      return 100
    }
    
    func paymentsPickerViewSettings () {
        itemPicker.transform = CGAffineTransform(rotationAngle: -90  * (.pi/180));
        itemPicker.frame = CGRect(x: 0, y: 0, width: view.frame.width - 94, height: 45)
    }
}


extension AssignmentsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = peopleTableView.dequeueReusableCell(withIdentifier: "assignmentCell", for: indexPath) as! AssignmentCell
        cell.nameLabel.text = people[indexPath.row].name;
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        segmentedControl.selectedSegmentIndex = 0
    }
    
    func doSomething () {
        self.segmentedControl.selectedSegmentIndex = 0;
        self.continueButton.backgroundColor = UIColor.red
    }
    

    
    
}


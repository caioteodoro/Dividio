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
    var totalCost: Double = 0;
    var pickerViewCounter: [Bool] = [];
    var selectedPeoplePriorChanging: [Bool] = [];
    var selectedSettingsPriorChanging: Int = 1;
    var selectedItem = 0;
    
    @IBOutlet weak var itemPicker: CustomPickerView!
    @IBOutlet weak var peopleTableView: TableLayout!
    @IBOutlet weak var continueButton: PurpleButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func segmentedControlChanged(_ sender: Any) {
        
        switch segmentedControl.selectedSegmentIndex {
            
        case 0:
            for i in 0...(people.count-1) {
                people[i].consumedItems[selectedItem] = selectedPeoplePriorChanging[i]
            }
            selectionOfRows()
            
        case 1:
            for i in 0...(people.count-1) {
                selectedPeoplePriorChanging.insert(people[i].consumedItems[selectedItem], at: i)
                people[i].consumedItems[selectedItem] = true
            }
            selectionOfRows()
            
        default:
            break
        }
    }
    
    //Custom Functions
    func segmentedControlSettings(){
        segmentedControl.setTitleTextAttributes([.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)] , for: .normal)
        segmentedControl.setTitleTextAttributes([.foregroundColor: #colorLiteral(red: 0.2705882353, green: 0.2705882353, blue: 0.2705882353, alpha: 1)] , for: .selected)
    }
    
    func populateCounter () {
        for i in 0...(items.count-1) {
            pickerViewCounter.insert(false, at: i)
            for n in 0...(people.count-1) {
                people[n].consumedItems.insert(false, at: i)
            }
            people[0].consumedItems[i] = true
        }
        pickerViewCounter[0] = true
        allowContinueButton()
    }
    
    func allowContinueButton () {
        if pickerViewCounter.allSatisfy({ $0 == true }) { continueButton.isEnabled = true;
        } else { continueButton.isEnabled = false; }
    }
    
    func warningContinueButton () {
        //show message if an item has not been assigned to a person
    }

    
    //PickerView Functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedItem = row
        pickerViewCounter[row] = true
        selectionOfRows()
        allowContinueButton()
    }
    
    func paymentsPickerViewSettings () {
        itemPicker.transform = CGAffineTransform(rotationAngle: -90  * (.pi/180));
        itemPicker.frame = CGRect(x: 0, y: 0, width: view.frame.width - 94, height: 45)
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
    
    //Essential Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.itemPicker.delegate = self;
        self.itemPicker.dataSource = self;
        self.peopleTableView.dataSource = self;
        self.peopleTableView.delegate = self;
        self.peopleTableView.tableFooterView = UIView(frame: .zero);
        self.peopleTableView.allowsMultipleSelection = true;
        
        paymentsPickerViewSettings();
        segmentedControlSettings();
        populateCounter();
        warningContinueButton();
        selectionOfRows()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "assignmentsToResultsSegue" {
            let destinationViewController: ResultsViewController = segue.destination as! ResultsViewController
            destinationViewController.items = self.items;
            destinationViewController.people = self.people;
            destinationViewController.totalCost = self.totalCost;
        }
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
        people[indexPath.row].consumedItems[selectedItem] = false
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        people[indexPath.row].consumedItems[selectedItem] = true
    }
    
    func selectionOfRows () {
        for i in 0...(people.count-1){
            if people[i].consumedItems[selectedItem] == true {
                peopleTableView.selectRow(at: IndexPath(row: i, section: 0), animated: true, scrollPosition: .top)
            } else {
                peopleTableView.deselectRow(at: IndexPath(row: i, section: 0), animated: true)
            }
        }
    }
}


//
//  ResultsViewController.swift
//  Dividio
//
//  Created by Caio Teodoro on 05/02/22.
//  Copyright © 2022 Caio Teodoro. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var people: [Person] = [];
    var items: [Item] = [];
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var resultsPickerView: UIPickerView!

    //Custom Functions
    func designSaveButton() {
        self.saveButton.layer.shadowColor = #colorLiteral(red: 0.2509489954, green: 0.2509984672, blue: 0.2509458363, alpha: 1)
        self.saveButton.layer.shadowOffset = CGSize(width: -4, height: 4);
        self.saveButton.layer.shadowRadius = 0;
        self.saveButton.layer.shadowOpacity = 1;
    }
    
    //PickerView Functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return people.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 190
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //#TODO: will I need this one?
    }
    
    func resultsPickerViewSettings () {
        self.resultsPickerView.transform = CGAffineTransform(rotationAngle: -90  * (.pi/180));
        self.resultsPickerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 190)
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let around = UIView();
        
        let modeView = UIView()
        modeView.frame = CGRect(x: 0, y: 0, width: 180, height: 180)
        modeView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1);
        modeView.layer.borderColor = #colorLiteral(red: 0.2705882353, green: 0.2705882353, blue: 0.2705882353, alpha: 1);
        modeView.layer.borderWidth = 3;
        let modeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        modeLabel.textColor = .black
        modeLabel.text = people[row].name
        modeLabel.textAlignment = .center
        modeView.addSubview(modeLabel)
        modeView.transform = CGAffineTransform(rotationAngle: 90 * (.pi/180))
        
        around.addSubview(modeView)
        return around
    }
    
    //Essential Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        designSaveButton()
        resultsPickerViewSettings()
        
        self.resultsPickerView.delegate = self;
        self.resultsPickerView.dataSource = self;
    }
}

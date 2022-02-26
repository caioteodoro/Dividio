//
//  ResultsViewController.swift
//  Dividio
//
//  Created by Caio Teodoro on 05/02/22.
//  Copyright © 2022 Caio Teodoro. All rights reserved.
//

import UIKit
import iCarousel

class ResultsViewController: UIViewController, iCarouselDataSource {

    var people: [Person] = [];
    var items: [Item] = [];
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet var iCarouselView: UIView!
    
    let myCarousel: iCarousel = {
        let view = iCarousel();
        view.type = .coverFlow;
        return view
    }()
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        10
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 180, height: 180))
        view.backgroundColor = .red
        return view
    }
    
    func loadiCarousel() {
        iCarouselView.addSubview(myCarousel);
        myCarousel.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
    }
    
    
    //Custom Functions

    
    
    

    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let around = UIView();
        
        let modeView = UIView()
        modeView.frame = CGRect(x: 0, y: 0, width: 180, height: 180)
        modeView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1);
        modeView.layer.borderColor = #colorLiteral(red: 0.2705882353, green: 0.2705882353, blue: 0.2705882353, alpha: 1);
        modeView.layer.borderWidth = 3;
        
        let nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 180, height: 20))
        nameLabel.textColor = .black
        nameLabel.text = people[row].name
        nameLabel.textAlignment = .center
        
        let paymentLabel = UILabel(frame: CGRect(x: 0, y: 100, width: 180, height: 20))
        paymentLabel.textColor = .black
        paymentLabel.text = String(people[row].payments[0])
        paymentLabel.textAlignment = .center
        
        
        modeView.addSubview(nameLabel)
        modeView.addSubview(paymentLabel)
        modeView.transform = CGAffineTransform(rotationAngle: 90 * (.pi/180))
        
        around.addSubview(modeView)
        return around
    }
    
    //Essential Functions
    override func viewDidLoad() {
        super.viewDidLoad();
        myCarousel.dataSource = self;
        loadiCarousel()
    }
}

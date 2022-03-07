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
    var totalCost: Double = 0;
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet var iCarouselView: UIView!
    
    let myCarousel: iCarousel = {
        let view = iCarousel();
        view.type = .coverFlow;
        return view
    }()
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        people.count
    }
    
    func loadiCarousel() {
        iCarouselView.addSubview(myCarousel);
        myCarousel.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
    }
    
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 180, height: 180))
        view.backgroundColor = .white
        view.layer.borderColor = #colorLiteral(red: 0.2705882353, green: 0.2705882353, blue: 0.2705882353, alpha: 1);
        view.layer.borderWidth = 3.0;
        
        let nameLabel = UILabel(frame: CGRect(x: 0, y: 15, width: 180, height: 20))
        nameLabel.text = people[index].name
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont(name: "Avenir-Black", size: 17.0)
        
        let paymentLabelOne = UILabel(frame: CGRect(x: 0, y: 60, width: 180, height: 20))
        paymentLabelOne.text = "não precisa"
        paymentLabelOne.textAlignment = .center
        paymentLabelOne.font = UIFont(name: "Avenir-Book", size: 17.0)
        print(people[index].hasToPay)
        
        if people[index].hasToPay > 0  {
            paymentLabelOne.text = "pagar " + String(people[index].hasToPay)
        }
        
        let paymentLabelTwo = UILabel(frame: CGRect(x: 0, y: 85, width: 180, height: 20))
        paymentLabelTwo.text = "efetuar pagamentos"
        paymentLabelTwo.textAlignment = .center
        paymentLabelTwo.font = UIFont(name: "Avenir-Book", size: 17.0)
        print(people[index].hasToPay)
        
        if people[index].hasToPay > 0  {
            paymentLabelTwo.text = " para XXX"
        }
        
        view.addSubview(nameLabel)
        view.addSubview(paymentLabelOne)
        view.addSubview(paymentLabelTwo)
        
        return view
    }
    
    func calculateDividedPrices() {
        for i in 0...items.count-1 {
            var consumers = 0.0;
            for n in 0...people.count-1 {
                if people[n].consumedItems[i] == true {
                    consumers += 1;
                }
            }
            items[i].dividedPrice = items[i].totalPrice / consumers
        }
    }
    
    func calculatePaymentPerPerson () {
        for i in 0...people.count-1 {
            for n in 0...items.count-1 {
                if people[i].consumedItems[n] == true {
                    people[i].hasToPay += items[n].dividedPrice;
                }
            }
        }
    }
    
    func calculate() {
        self.calculateDividedPrices();
        self.calculatePaymentPerPerson();
    }
    
    
    //Custom Functions

    
    
    //Essential Functions
    override func viewDidLoad() {
        super.viewDidLoad();
        myCarousel.dataSource = self;
        loadiCarousel();
        calculate();
    }
}

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
    var receivers: [Person] = [];
    var payers: [Person] = [];
    var results: [Result] = [];
    
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
        nameLabel.numberOfLines = 0
        nameLabel.text = people[index].name
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont(name: "Avenir-Black", size: 17.0)
        
        let paymentLabel = UILabel(frame: CGRect(x: 0, y: 60, width: 180, height: 60))
        paymentLabel.numberOfLines = 0
        paymentLabel.text = "não precisa \npagar :)"
        paymentLabel.textAlignment = .center
        paymentLabel.font = UIFont(name: "Avenir-Book", size: 17.0)
        
        if people[index].hasToPay > 0  {
            paymentLabel.text = "pagar " + String(people[index].hasToPay) + "\n para XXX"
        }
        
        view.addSubview(nameLabel)
        view.addSubview(paymentLabel)
        
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
    
    func getReceiversAndPayers() {
        for i in 0...people.count-1 {
            people[i].hasToPay -= people[i].payments.reduce(0,+)
            if people[i].hasToPay > 0 {
                payers.append(people[i])
            } else {
                receivers.append(people[i])
            }
        }
    }
    
    func presentResults () {
        for i in 0...receivers.count-1 {
            while receivers[i].hasToPay > 0 {
                for n in 0...payers.count-1 {
                    if receivers[i].hasToPay + payers[n].hasToPay >= 0 {
                        let newPayment = Result(payer: payers[n].name, value: payers[n].hasToPay, receiver: receivers[i].name)
                        results.append(newPayment)
                        receivers[i].hasToPay += payers[n].hasToPay
                        payers[n].hasToPay = 0
                    }
                }
            }
        }
    }
    
    func calculate() {
        self.calculateDividedPrices();
        self.calculatePaymentPerPerson();
        self.getReceiversAndPayers();
        self.presentResults();
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

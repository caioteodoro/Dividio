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
    var receivers: [Receiver] = [];
    var payers: [Payer] = [];
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet var iCarouselView: UIView!
    
    let myCarousel: iCarousel = {
        let view = iCarousel();
        view.type = .coverFlow;
        return view
    }()
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        payers.count
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
        nameLabel.text = payers[index].name
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont(name: "Avenir-Black", size: 17.0)
        
        let paymentLabel = UILabel(frame: CGRect(x: 0, y: 60, width: 180, height: 60))
        paymentLabel.numberOfLines = 0
        paymentLabel.textAlignment = .center
        paymentLabel.font = UIFont(name: "Avenir-Book", size: 17.0)
        
        if !payers[index].paysTo.isEmpty {
            paymentLabel.text = "pagar " + String(payers[index].paysTo[0].value) + "\npara " + String(payers[index].paysTo[0].value)
        }
        
        view.addSubview(nameLabel)
        view.addSubview(paymentLabel)
        
        return view
    }
    
    func calculateDividedPrices() {
        for i in 0...items.count-1 {
            var consumers = 0.0;
            for n in 0...people.count-1 {
                if people[n].consumedItemsList[i] == true {
                    consumers += 1;
                }
            }
            items[i].pricePerPerson = items[i].totalPrice / consumers
        }
    }
    
    func calculatePaymentPerPerson () {
        for i in 0...people.count-1 {
            for n in 0...items.count-1 {
                if people[i].consumedItemsList[n] == true {
                    people[i].consumedItemsPrice += items[n].pricePerPerson;
                }
            }
        }
    }
  
    func getReceiversAndPayers() {
        for i in 0...people.count-1 {
            var finalValue = people[i].consumedItemsPrice
            finalValue -= people[i].payments.reduce(0,+)
            if finalValue > 0 {
                let payer: Payer = people[i] as! Payer
                payers.insert(payer, at: 0)
                payers[0].hasToPay = finalValue
            } else {
                let receiver: Receiver = people[i] as! Receiver
                receivers.insert(receiver, at: 0)
                receivers[0].hasToReceive = finalValue
            }
        }
    }
    
//    func presentResults () {
//        for i in 0...payers.count-1 {
//            //while payers[i].hasToPay > 0 {
//                for n in 0...receivers.count-1 {
//                    if payers[i].consumedItemsPrice + receivers[n].consumedItemsPrice >= 0 {
//                        let newPayment = Payment(payer: payers[i], value: (receivers[n].consumedItemsPrice * -1), receiver: receivers[n])
//
//                        receivers[n].receivesFrom.append(newPayment)
//                        payers[i].paysTo.append(newPayment)
//
//                        print(receivers[n].consumedItemsPrice)
//
//                        payers[i].consumedItemsPrice += receivers[n].consumedItemsPrice
//                        receivers[n].consumedItemsPrice = 0
//                    }
//                }
//            //}
//        }
//    }
    
    func presentResults () {
        for i in 0...payers.count-1 {
            //while payers[i].hasToPay > 0 {
                for n in 0...receivers.count-1 {
                    let newPayment = Payment(payer: payers[i], value: (receivers[n].hasToReceive * -1), receiver: receivers[n])
                        
                    receivers[n].receivesFrom.append(newPayment)
                    payers[i].paysTo.append(newPayment)
                        
                    payers[i].hasToPay -= newPayment.value
                    receivers[n].hasToReceive += newPayment.value
                }
            //}
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
        calculate();
        myCarousel.dataSource = self;
        loadiCarousel();
    }
}

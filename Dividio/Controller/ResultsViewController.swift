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
    var paymentsCounter = 0;
    var currentAmountOfPayments = 0;
    var currentPayer = 0;
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet var iCarouselView: UIView!
    
    let myCarousel: iCarousel = {
        let view = iCarousel();
        view.type = .coverFlow;
        return view
    }()
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        var numberOfCells = 0;
        for i in 0...payers.count-1 {
            numberOfCells += payers[i].paysTo.count
        }
        return numberOfCells
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
        
        let namesLabel = UILabel(frame: CGRect(x: 0, y: 15, width: 180, height: 20))
        namesLabel.numberOfLines = 0
        namesLabel.textAlignment = .center
        namesLabel.font = UIFont(name: "Avenir-Black", size: 18.0)
        
        let valueOfPaymentLabel = UILabel(frame: CGRect(x: 0, y: 60, width: 180, height: 60))
        valueOfPaymentLabel.numberOfLines = 0
        valueOfPaymentLabel.textAlignment = .center
        valueOfPaymentLabel.font = UIFont(name: "Avenir-Book", size: 30.0)
        
        
        currentAmountOfPayments = payers[currentPayer].paysTo.count - 1
        
        func editText() {
            namesLabel.text = payers[currentPayer].paysTo[paymentsCounter].payer.name + " para " + payers[currentPayer].paysTo[paymentsCounter].receiver.name
            valueOfPaymentLabel.text = "R$ " + String(payers[currentPayer].paysTo[paymentsCounter].value)
        }
        
        if !payers[currentPayer].paysTo.isEmpty {
            if paymentsCounter < currentAmountOfPayments {
                editText()
                paymentsCounter += 1
            } else {
                editText()
                paymentsCounter = 0
                currentPayer = index;
            }
        }
        
        view.addSubview(namesLabel)
        view.addSubview(valueOfPaymentLabel)
        
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
            var finalValue = people[i].consumedItemsPrice;
            finalValue -= people[i].payments.reduce(0,+)
            if finalValue > 0 {
                let payer = Payer(person: people[i], hasToPay: finalValue)
                payers.append(payer)
            } else {
                let receiver = Receiver(person: people[i], hasToReceive: finalValue * -1)
                receivers.append(receiver)
            }
        }
    }

    
    func presentResults () {
        for i in 0...payers.count-1 {
            while payers[i].hasToPay > 0 {
                for n in 0...receivers.count-1 {
                    var paymentValue: Double;
                    var newPayment: Payment;
                    if payers[i].hasToPay > receivers[n].hasToReceive {
                        paymentValue = receivers[n].hasToReceive
                        newPayment = Payment(payer: payers[i], value: paymentValue, receiver: receivers[i])
                    } else {
                        paymentValue = payers[i].hasToPay
                        newPayment = Payment(payer: payers[i], value: paymentValue, receiver: receivers[n])
                    }
                    payers[i].paysTo.append(newPayment)
                    payers[i].hasToPay -= paymentValue
                    receivers[n].receivesFrom.append(newPayment)
                    receivers[n].hasToReceive -= paymentValue
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
        calculate();
        myCarousel.dataSource = self;
        loadiCarousel();
    }
}

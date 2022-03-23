//
//  Payer.swift
//  Dividio
//
//  Created by Caio Teodoro on 15/03/22.
//  Copyright © 2022 Caio Teodoro. All rights reserved.
//

import UIKit

class Payer: Person {
    var hasToPay: Double;
    var paysTo: [Payment];
    init(person: Person, hasToPay: Double) {
        self.hasToPay = hasToPay;
        self.paysTo = [];
        super.init(name: person.name)
        self.name = person.name;
        self.payments = person.payments;
        self.consumedItemsList = person.consumedItemsList;
        self.consumedItemsPrice = person.consumedItemsPrice;
    }
}

//
//  Receiver.swift
//  Dividio
//
//  Created by Caio Teodoro on 15/03/22.
//  Copyright © 2022 Caio Teodoro. All rights reserved.
//

import UIKit

class Receiver: Person {
    var hasToReceive: Double;
    var receivesFrom: [Payment];
    init(person: Person, hasToReceive: Double) {
        self.hasToReceive = hasToReceive;
        self.receivesFrom = [];
        super.init(name: person.name)
        self.name = person.name;
        self.payments = person.payments;
        self.consumedItemsList = person.consumedItemsList;
        self.consumedItemsPrice = person.consumedItemsPrice;
    }
}

//
//  Payment.swift
//  Dividio
//
//  Created by Caio Teodoro on 11/03/22.
//  Copyright © 2022 Caio Teodoro. All rights reserved.
//

import Foundation

class Payment {
    var payer: Person
    var value: Double
    var receiver: Person
    
    init (payer: Person, value: Double, receiver: Person) {
        self.payer = payer;
        self.value = value;
        self.receiver = receiver;
    }
}

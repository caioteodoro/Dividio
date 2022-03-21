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
    init(name: String, hasToPay: Double, paysTo: [Payment]) {
        self.hasToPay = hasToPay;
        self.paysTo = paysTo;
        super.init(name: name)
    }
}

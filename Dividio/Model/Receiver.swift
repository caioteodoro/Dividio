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
    init(name: String, hasToReceive: Double, receivesFrom: [Payment]) {
        self.hasToReceive = hasToReceive;
        self.receivesFrom = receivesFrom;
        super.init(name: name)
    }
}

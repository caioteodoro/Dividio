//
//  Result.swift
//  Dividio
//
//  Created by Caio Teodoro on 11/03/22.
//  Copyright © 2022 Caio Teodoro. All rights reserved.
//

import Foundation

class Result {
    var payer: String
    var value: Double
    var receiver: String
    
    init(payer: String, value: Double, receiver: String) {
        self.payer = payer;
        self.value = value;
        self.receiver = receiver;
    }
}

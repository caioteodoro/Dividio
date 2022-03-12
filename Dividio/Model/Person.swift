import Foundation

class Person {
    var name: String;
    var payments: [Double];
    var hasToPay: Double;
    var consumedItems: [Bool]
    var paysTo: [Payment]
    var receivesFrom: [Payment]
    init(name: String) {
        self.name = name;
        self.payments = [];
        self.consumedItems = [];
        self.hasToPay = 0;
        self.paysTo = [];
        self.receivesFrom = [];
    }
}

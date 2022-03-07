import Foundation

class Person {
    var name: String;
    var payments: [Double];
    var hasToPay: Double;
    var consumedItems: [Bool]
    init(name: String) {
        self.name = name;
        self.payments = [];
        self.consumedItems = [];
        self.hasToPay = 0;
    }
}

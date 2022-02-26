import Foundation

class Person {
    var name: String;
    var payments: [Double];
    var consumedItems: [Bool]
    init(name: String, payments: [Double], consumedItems: [Bool]) {
        self.name = name;
        self.payments = payments;
        self.consumedItems = consumedItems;
    }
}

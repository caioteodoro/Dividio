import Foundation

class Person {
    var name: String;
    var payment: Double;
    var consumedItems: [Bool]
    init(name: String, payment: Double, consumedItems: [Bool]) {
        self.name = name;
        self.payment = payment;
        self.consumedItems = consumedItems;
    }
}

class Item {
    var name: String;
    var price: Double;
    init(name: String, price: Double) {
        self.name = name;
        self.price = price;
    }
}

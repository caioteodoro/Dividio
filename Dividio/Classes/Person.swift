import Foundation

class Person {
    var name: String;
    var payment: Double;
    init(name: String, payment: Double) {
        self.name = name;
        self.payment = payment;
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

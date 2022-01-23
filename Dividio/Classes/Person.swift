import Foundation

class Person {
    var name: String;
    init(name: String) {
        self.name = name;
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

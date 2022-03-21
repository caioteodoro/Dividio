import Foundation

class Person {
    var name: String;
    var payments: [Double];
    var consumedItemsList: [Bool];
    var consumedItemsPrice: Double;
    init(name: String) {
        self.name = name;
        self.payments = [];
        self.consumedItemsList = [];
        self.consumedItemsPrice = 0;
    }
}

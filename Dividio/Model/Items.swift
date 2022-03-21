import Foundation

class Item {
    var name: String;
    var totalPrice: Double;
    var pricePerPerson: Double;
    
    init(name: String, totalPrice: Double) {
        self.name = name;
        self.totalPrice = totalPrice;
        self.pricePerPerson = 0;
    }
}

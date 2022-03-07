import Foundation

class Item {
    var name: String;
    var totalPrice: Double;
    var dividedPrice: Double;
    
    init(name: String, totalPrice: Double) {
        self.name = name;
        self.totalPrice = totalPrice;
        self.dividedPrice = 0;
    }
}

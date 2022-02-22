//
//  CurrencyTextField.swift
//  Dividio
//
//  Created by Caio Teodoro on 20/01/22.
//  Copyright © 2022 Caio Teodoro. All rights reserved.
//

import UIKit

class CurrencyTextField: UITextField {

        func setup() {
        self.layer.borderColor = #colorLiteral(red: 0.2705882353, green: 0.2705882353, blue: 0.2705882353, alpha: 1);
        self.layer.borderWidth = 3.0;
        self.layer.shadowColor = #colorLiteral(red: 0.4705882353, green: 0.3529411765, blue: 0.8078431373, alpha: 1)
        self.layer.shadowOffset = CGSize(width: -4, height: 4);
        self.layer.shadowRadius = 0;
        self.layer.shadowOpacity = 1;
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setTextIconAndPlaceholder(icon: UILabel, placeholder: String) {
        let imageView = UILabel()
        imageView.text = "R$"
        imageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        let view = UIView()
        view.frame = CGRect(x: 0, y: 2, width: 25, height: 25)
        view.backgroundColor = #colorLiteral(red: 0.4922404289, green: 0.7722371817, blue: 0.4631441236, alpha: 1)
        view.addSubview(imageView)
        self.leftView = view
        self.leftViewMode = UITextField.ViewMode.always
        self.placeholder = placeholder
    }
}

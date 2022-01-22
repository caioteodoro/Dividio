//
//  WhiteTextField.swift
//  Dividio
//
//  Created by Caio Teodoro on 19/01/22.
//  Copyright © 2022 Caio Teodoro. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable open class WhiteTextField: UITextField {

        func setup() {
        self.layer.borderColor = #colorLiteral(red: 0.2705882353, green: 0.2705882353, blue: 0.2705882353, alpha: 1);
        self.layer.borderWidth = 3.0;
        self.layer.shadowColor = #colorLiteral(red: 0.4705882353, green: 0.3529411765, blue: 0.8078431373, alpha: 1)
        self.layer.shadowOffset = CGSize(width: -4, height: 4);
        self.layer.shadowRadius = 0;
        self.layer.shadowOpacity = 1;
    }
    

    //Edit Clear
    override open func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        let originalRect = super.clearButtonRect(forBounds: bounds)
        return originalRect.offsetBy(dx: -8, dy: 0)
    }
    
    
    //Edit UITextField Padding
    let padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 34)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}

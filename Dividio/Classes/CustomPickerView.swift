//
//  CustomPickerView.swift
//  Dividio
//
//  Created by Caio Teodoro on 23/01/22.
//  Copyright © 2022 Caio Teodoro. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable open class CustomPickerView: UIPickerView {
    
    let rotationAngle: CGFloat! = -90  * (.pi/180)
    
    
    func setup() {
        self.layer.borderColor = #colorLiteral(red: 0.2705882353, green: 0.2705882353, blue: 0.2705882353, alpha: 1);
        self.layer.borderWidth = 3.0;
        self.layer.shadowColor = #colorLiteral(red: 0.4705882353, green: 0.3529411765, blue: 0.8078431373, alpha: 1)
        self.layer.shadowOffset = CGSize(width: -4, height: 4);
    }
         
        
    override init(frame: CGRect) {
        super.init(frame: frame);
        setup();
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        setup();
    }
}

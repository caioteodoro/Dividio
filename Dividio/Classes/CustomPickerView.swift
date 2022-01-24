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

    func setup() {
        self.layer.borderColor = #colorLiteral(red: 0.2705882353, green: 0.2705882353, blue: 0.2705882353, alpha: 1);
        self.layer.borderWidth = 3.0;
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

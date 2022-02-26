//
//  WhiteButton.swift
//  Dividio
//
//  Created by Caio Teodoro on 26/02/22.
//  Copyright © 2022 Caio Teodoro. All rights reserved.
//

import UIKit

@IBDesignable open class WhiteButton: UIButton {
    
    func setup() {
        self.layer.shadowColor = #colorLiteral(red: 0.2509489954, green: 0.2509984672, blue: 0.2509458363, alpha: 1)
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
}

//
//  PurpleButton.swift
//  Dividio
//
//  Created by Caio Teodoro on 22/01/22.
//  Copyright © 2022 Caio Teodoro. All rights reserved.
//

import UIKit

class PurpleButton: UIButton {

    override public var isEnabled: Bool {
        didSet {
            if self.isEnabled {
                UIView.animate(withDuration: 0.1){
                    self.alpha = 1.0;
                    self.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1);
                }
            } else {
                UIView.animate(withDuration: 0.1){
                    self.alpha = 0.5;
                    self.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1);
                }
            }
        }
    }
}

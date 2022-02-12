//
//  dismissKeyboard.swift
//  Dividio
//
//  Created by Caio Teodoro on 11/02/22.
//  Copyright © 2022 Caio Teodoro. All rights reserved.
//

import Foundation

class UIViewController {
    func dismissKeyboard () {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap);
    }
}


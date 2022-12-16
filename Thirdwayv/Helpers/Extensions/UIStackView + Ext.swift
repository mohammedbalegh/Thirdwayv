//
//  UIStackView + Ext.swift
//  Thirdwayv
//
//  Created by mohammed balegh on 15/12/2022.
//

import UIKit

extension UIStackView {
    func removeAllArrangedSubviews() {
        arrangedSubviews.forEach { subview in
            self.removeArrangedSubview(subview)
            NSLayoutConstraint.deactivate(subview.constraints)
            subview.removeFromSuperview()
        }
    }
}

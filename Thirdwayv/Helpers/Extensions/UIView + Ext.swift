//
//  UIView + Ext.swift
//  Thirdwayv
//
//  Created by mohammed balegh on 15/12/2022.
//

import UIKit

extension UIView {

    func throwNoSuperviewError() {
        fatalError("Attempting to set constraints to a \(type(of: self)) before adding it to a superView")
    }

    func scale(to scale: CGFloat) {
        self.transform = CGAffineTransform(scaleX: scale, y: scale)
    }

    private func disableAutoresizingMaskTranslationIfEnabled() {
        if translatesAutoresizingMaskIntoConstraints {
            translatesAutoresizingMaskIntoConstraints = false
        }
    }

    func constrainEdgesToCorrespondingEdges(of view: UIView, top: CGFloat?=nil, leading: CGFloat?=nil, bottom: CGFloat?=nil, trailing: CGFloat?=nil) {
        disableAutoresizingMaskTranslationIfEnabled()

        if let top = top {
            topAnchor.constraint(equalTo: view.topAnchor, constant: top).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading).isActive = true

        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom).isActive = true

        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailing).isActive = true
        }

    }

    /// make `self` fill the specified `view` with specified margins.
    func fill(_ view: UIView, top: CGFloat=0, leading: CGFloat=0, bottom: CGFloat=0, trailing: CGFloat=0) {
        disableAutoresizingMaskTranslationIfEnabled()
        
        constrainEdgesToCorrespondingEdges(of: view, top: top, leading: leading, bottom: bottom, trailing: trailing)
    }

    func fillSuperView() {
        guard let superview = superview else {
            throwNoSuperviewError()
            return
        }
        disableAutoresizingMaskTranslationIfEnabled()
        fill(superview)
    }

    func fillScreen() {
        guard let superview = superview else {
            throwNoSuperviewError()
            return
        }
        disableAutoresizingMaskTranslationIfEnabled()

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: LayoutConstants.screenHeight),
            widthAnchor.constraint(equalToConstant: LayoutConstants.screenWidth),
            centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            centerYAnchor.constraint(equalTo: superview.centerYAnchor),
        ])
    }

    func applyLightShadow() {
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 5
        layer.masksToBounds = false
    }
}

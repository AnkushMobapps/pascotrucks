//
//  Designable.swift
//  WhoShoot
//
//  Created by Mac on 12/5/22.
//

import Foundation
import UIKit

@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableImageView: UIImageView {
}

@IBDesignable
class DesignableLabel: UILabel {
}
extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    func fadeIn() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: nil)
        
    }
    
    func fadeOut() {
        UIView.animate(withDuration: 8.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.alpha = 0.0
        }, completion: nil)
    }
    
    /// get nib from bundle
    static var nib: UINib {
        let nibName = nibFileExists(identifier) ? identifier : ""
        return UINib(nibName: nibName, bundle: Bundle(for: self))
    }

    private static func nibFileExists(_ nibName: String) -> Bool {
        Bundle(for: self).path(forResource: nibName, ofType: "nib") != nil
    }
    
    @discardableResult
    func fromNib<T: UIView>(named name: String? = nil) -> T? {
        let bundle = Bundle(for: type(of: self))
        let unwrappedName = name ?? String(describing: type(of: self))
        if Self.nibFileExists(unwrappedName),
           let content = bundle.loadNibNamed(unwrappedName, owner: self, options: nil)?.first as? T {
            return addView(content)
        }
        return nil
    }
    
    func addView<T: UIView>(_ contentView: T) -> T {
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.layoutAttach(to: self)
        return contentView
    }
    
    func layoutAttach(to parentView: UIView, xPos: CGFloat, width: CGFloat) {
        // self.translatesAutoresizingMaskIntoConstraints = false
        parentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        parentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -xPos).isActive = true
        parentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        parentView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
    }

    func layoutAttach(to parentView: UIView, height: CGFloat? = nil, inset: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        parentView.topAnchor.constraint(equalTo: self.topAnchor, constant: inset).isActive = true
        parentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset).isActive = true
        parentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -inset).isActive = true
        parentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset).isActive = true

        guard let height = height else { return }
        let heightConstraint = heightAnchor.constraint(greaterThanOrEqualToConstant: height)
        heightConstraint.priority = UILayoutPriority(rawValue: 900)
        heightConstraint.isActive = true
    }

    func layoutAttach(to parentView: UIView, inset: UIEdgeInsets) {
        self.translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: parentView.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: inset.left).isActive = true
        heightAnchor.constraint(equalTo: parentView.heightAnchor, multiplier: 1.0).isActive = true
        widthAnchor.constraint(equalTo: parentView.widthAnchor, multiplier: 1.0).isActive = true
    }
}

extension UIView {
    func GradientColor(colorOne: UIColor, colorTwo: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.cornerRadius = layer.cornerRadius
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
}



public protocol Identifiable {
    static var identifier: String { get }
}

extension UIResponder: Identifiable {

    public static var identifier: String { String(describing: self) }
}

// email validation
extension String {
    
        func isValidEmail() -> Bool {
            let REGEX_USER_EMAIL = "[A-Z0-9a-z._%+-]{2,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$"
            let regex = try! NSRegularExpression(pattern: REGEX_USER_EMAIL,options: .caseInsensitive)
            return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
        }
    
}



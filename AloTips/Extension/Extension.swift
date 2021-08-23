//
//  Extension.swift
//  AloTips
//
//  Created by Admin on 8/12/21.
//

import Foundation
import UIKit

extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension CGRect {
    init(sx: CGFloat, sy: CGFloat, swidth: CGFloat, sheight: CGFloat) {
        self.init(origin: CGPoint(sx: sx, sy: sy), size: CGSize(swidth: swidth, sheight: sheight))
    }
}

extension CGPoint {
    init(sx: CGFloat, sy: CGFloat) {
        self.init(x: sx.xForIdiom(), y: sy.yForIdiom())
    }

    func pointForIdiom() -> CGPoint {
        return CGPoint(sx: self.x, sy: y)
    }
}

extension CGSize {
    init(swidth: CGFloat, sheight: CGFloat) {
        self.init(width: swidth.widthForIdiom(), height: sheight.heightForIdiom())
    }

    func sizeForIdiom() -> CGSize {
        return CGSize(swidth: self.width, sheight: self.height)
    }

    // http://stackoverflow.com/questions/6278876/how-to-know-the-image-size-after-applying-aspect-fit-for-the-image-in-an-uiimage
    static func aspectFit(aspectRatio: CGSize, boundingSize: inout CGSize) -> CGSize {
        let mW = boundingSize.width / aspectRatio.width;
        let mH = boundingSize.height / aspectRatio.height;

        if( mH < mW ) {
            boundingSize.width = boundingSize.height / aspectRatio.height * aspectRatio.width;
        }
        else if( mW < mH ) {
            boundingSize.height = boundingSize.width / aspectRatio.width * aspectRatio.height;
        }
        
        return boundingSize;
    }
    
    static func aspectFill(aspectRatio: CGSize, minimumSize: inout CGSize) -> CGSize {
        let mW = minimumSize.width / aspectRatio.width;
        let mH = minimumSize.height / aspectRatio.height;

        if( mH > mW ) {
            minimumSize.width = minimumSize.height / aspectRatio.height * aspectRatio.width;
        }
        else if( mW > mH ) {
            minimumSize.height = minimumSize.width / aspectRatio.width * aspectRatio.height;
        }
        
        return minimumSize;
    }
}


extension CGFloat {
    private static let WidthRatio: CGFloat = 1024 / 568
    private static let HeightRatio: CGFloat = 768 / 320
    private static let PadIdiomXOffset: CGFloat = ((568 * HeightRatio) - 1024) / 2
    static let iPadAspectRatio = HeightRatio

    func widthForIdiom() -> CGFloat {
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            return self * CGFloat.HeightRatio
            
        default:
            return self
        }
    }
    
    func heightForIdiom() -> CGFloat {
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            return self * CGFloat.HeightRatio
            
        default:
            return self
        }
    }

    func xForIdiom() -> CGFloat {
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            return (self * CGFloat.HeightRatio) - CGFloat.PadIdiomXOffset
        default:
            return self
        }
    }

    func yForIdiom() -> CGFloat {
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            return self * CGFloat.HeightRatio
            
        default:
            return self
        }
    }
    
    func pixelsToPoints() -> CGFloat {
            return self / UIScreen.main.scale
        }
}

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    /// Eventhough we already set the file owner in the xib file, where we are setting the file owner again because sending nil will set existing file owner to nil.
    @discardableResult
    func fromNib<T : UIView>() -> T? {
        guard let contentView = Bundle(for: type(of: self))
            .loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {
                return nil
        }
        return contentView
    }
    
    /// Attaches all sides of the receiver to its parent view
    func layoutAttachAll(margin : CGFloat = 0.0) {
        let view = superview
        layoutAttachTop(to: view, margin: margin)
        layoutAttachBottom(to: view, margin: margin)
        layoutAttachLeading(to: view, margin: margin)
        layoutAttachTrailing(to: view, margin: margin)
    }
    
    /// Attaches the top of the current view to the given view's top if it's a superview of the current view, or to it's bottom if it's not (assuming this is then a sibling view).
    /// if view is not provided, the current view's super view is used
    @discardableResult
    func layoutAttachTop(to: UIView? = nil, margin : CGFloat = 0.0) -> NSLayoutConstraint {
        
        let view: UIView? = to ?? superview
        let isSuperview = view == superview
        let constraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: view, attribute: isSuperview ? .top : .bottom, multiplier: 1.0, constant: margin)
        superview?.addConstraint(constraint)
        
        return constraint
    }
    
    /// Attaches the bottom of the current view to the given view
    @discardableResult
    func layoutAttachBottom(to: UIView? = nil, margin : CGFloat = 0.0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        
        let view: UIView? = to ?? superview
        let isSuperview = (view == superview) || false
        let constraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: isSuperview ? .bottom : .top, multiplier: 1.0, constant: -margin)
        if let priority = priority {
            constraint.priority = priority
        }
        superview?.addConstraint(constraint)
        
        return constraint
    }
    
    /// Attaches the leading edge of the current view to the given view
    @discardableResult
    func layoutAttachLeading(to: UIView? = nil, margin : CGFloat = 0.0) -> NSLayoutConstraint {
        
        let view: UIView? = to ?? superview
        let isSuperview = (view == superview) || false
        let constraint = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: view, attribute: isSuperview ? .leading : .trailing, multiplier: 1.0, constant: margin)
        superview?.addConstraint(constraint)
        
        return constraint
    }
    
    /// Attaches the trailing edge of the current view to the given view
    @discardableResult
    func layoutAttachTrailing(to: UIView? = nil, margin : CGFloat = 0.0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        
        let view: UIView? = to ?? superview
        let isSuperview = (view == superview) || false
        let constraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: isSuperview ? .trailing : .leading, multiplier: 1.0, constant: -margin)
        if let priority = priority {
            constraint.priority = priority
        }
        superview?.addConstraint(constraint)
        
        return constraint
    }
}

@IBDesignable
extension UIView {
     // Shadow
    @IBInspectable
        var shadowColor : UIColor{
            get{
                return UIColor.init(cgColor: layer.shadowColor!)
            }
            set {
                layer.shadowColor = newValue.cgColor
            }
        }
    
        @IBInspectable
        var shadowOpacity : Float {
            get {
                return layer.shadowOpacity
            }
            set {

                layer.shadowOpacity = newValue

            }
        }


     // Corner radius
     @IBInspectable var circle: Bool {
          get {
               return layer.cornerRadius == self.bounds.width*0.5
          }
          set {
               if newValue == true {
                    self.cornerRadius = self.bounds.width*0.5
               }
          }
     }

     @IBInspectable var cornerRadius: CGFloat {
          get {
               return self.layer.cornerRadius
          }

          set {
               self.layer.cornerRadius = newValue
          }
     }


     // Borders
     // Border width
     @IBInspectable
     public var borderWidth: CGFloat {
          set {
               layer.borderWidth = newValue
          }

          get {
               return layer.borderWidth
          }
     }

     // Border color
     @IBInspectable
     public var borderColor: UIColor? {
          set {
               layer.borderColor = newValue?.cgColor
          }

          get {
               if let borderColor = layer.borderColor {
                    return UIColor(cgColor: borderColor)
               }
               return nil
          }
     }
}

@IBDesignable
extension UILabel {
     @IBInspectable
     var scaleSize: CGFloat {
        set {
            let calculatedFontSize = Device.ratio * newValue
            self.font = UIFont.systemFont(ofSize: calculatedFontSize)
        }
        get {
            return self.scaleSize
        }
    }
}

@IBDesignable
extension UIButton {
     @IBInspectable
     var scaleSize: CGFloat {
        set {
            let calculatedFontSize = Device.ratio * newValue
            self.titleLabel?.font = UIFont.systemFont(ofSize: calculatedFontSize)
        }
        get {
            return self.scaleSize
        }
    }
}


class Device {
    // Base width in point, use iPhone 6
    static let base: CGFloat = 375
    static var ratio: CGFloat {
        return UIScreen.main.bounds.width / base
    }
}



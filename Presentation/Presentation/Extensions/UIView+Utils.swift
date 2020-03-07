////From - https://gist.github.com/GLeHir/ef4a2b5ade86025cb31d7d8f2494c319
//import UIKit
//
//@IBDesignable extension UIView {
//
//    /* BORDER */
//    @IBInspectable var borderColor:UIColor? {
//        set {
//            layer.borderColor = newValue!.cgColor
//        }
//        get {
//            if let color = layer.borderColor {
//                return UIColor(cgColor: color)
//            }
//            else {
//                return nil
//            }
//        }
//    }
//    @IBInspectable var borderWidth:CGFloat {
//        set {
//            layer.borderWidth = newValue
//        }
//        get {
//            return layer.borderWidth
//        }
//    }
//
//    /* BORDER RADIUS */
//    @IBInspectable var cornerRadius:CGFloat {
//        set {
//            layer.cornerRadius = newValue
//            clipsToBounds = newValue > 0
//        }
//        get {
//            return layer.cornerRadius
//        }
//    }
//
//
//    /* SHADOW */
//    @IBInspectable var shadowColor:UIColor? {
//        set {
//            layer.shadowColor = newValue!.cgColor
//        }
//        get {
//            if let color = layer.shadowColor {
//                return UIColor(cgColor: color)
//            }
//            else {
//                return nil
//            }
//        }
//    }
//    @IBInspectable var shadowOpacity:Float {
//        set {
//            layer.shadowOpacity = newValue
//        }
//        get {
//            return layer.shadowOpacity
//        }
//    }
//    @IBInspectable var shadowOffset:CGSize {
//        set {
//            layer.shadowOffset = newValue
//        }
//        get {
//            return layer.shadowOffset
//        }
//    }
//    @IBInspectable var shadowRadius:CGFloat {
//        set {
//            layer.shadowRadius = newValue
//        }
//        get {
//            return layer.shadowRadius
//        }
//    }
//}

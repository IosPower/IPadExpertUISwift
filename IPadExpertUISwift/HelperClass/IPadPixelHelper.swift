//
//  IPadPixelHelper.swift
//  IPadExpertUISwift
//
//  Created by piyush sinroja on 25/04/18.
//  Copyright © 2018 piyush. All rights reserved.
//

import UIKit

public enum IPad: CGFloat {
    case IPadPro9Inch = 1024
    case IPadPro10Inch = 1112
    case IPadPro12Inch = 1366
}
public enum DefaultIPadHeightPixels: CGFloat {
    case IPadPro9Inch = 2018
    case IPadPro10Inch = 2224
    case IPadPro12Inch = 2732
}
public enum DefaultIPadWidthPixels: CGFloat {
    case IPadPro9Inch = 1536
    case IPadPro10Inch = 1668
    case IPadPro12Inch = 2048
}
public class IPadPixelHelper: NSObject {
    public static let objIPadPixelHelper = IPadPixelHelper()
    public static var defaultIPadScreenWidth: CGFloat = DefaultIPadWidthPixels.IPadPro9Inch.rawValue   // In pixel
    public static var defaultIPadScreenHeight: CGFloat = DefaultIPadHeightPixels.IPadPro9Inch.rawValue  // In pixel
    
    public var pixelMulti: CGFloat = 2

    /// setXPositionAutomatic
    ///
    /// - Parameter value: Constraint Constant Value
    /// - Returns: Constraint Constant Value Accroding To Device
    static func setXPositionAutomaticForIPad(value: CGFloat) -> CGFloat {
        var xposition: CGFloat = value * objIPadPixelHelper.pixelMulti             // in pixels
        return xposition.setXPositionAutomatic(constrInPixel: xposition)
    }
    
    static func setYPositionAutomaticForIPad(value: CGFloat) -> CGFloat {
        var yposition: CGFloat = value * objIPadPixelHelper.pixelMulti             // in pixels
        return yposition.setYPositionAutomaticForIPad(constrInPixel: yposition)
    }
    
    // MARK: - Class Function For Set ConstraintAutomatic From MainView
    /// setConstraintForIPadFromMainView
    ///
    /// - Parameters:
    ///   - viewMain: view main
    ///   - isSetFont: if you want to set font so true
    ///   - isSetFontWithPixel: if isSetFont true so set isSetFontWithPixel true or false
    public class func setConstraintForIPadFromMainView(viewMain: UIView, isSetFont: Bool = false, isSetFontWithPixel: Bool = true) {
        var arrViews: [UIView] = []
        //subviews From
        func subviewsFrom(view: UIView) {
            arrViews.append(view)
            for view in view.subviews {
                subviewsFrom(view: view)
            }
        }
        subviewsFrom(view: viewMain)
        for viewCheckinh in arrViews {
            // This Public Method is Used For Automatic set Constraints According To Device screen Size
            IPadPixelHelper.setConstraintAutomaticForIPad(constr: viewCheckinh.constraints)
        }
        
        let arrFilter = arrViews.filter({$0 is UILabel || $0 is UITextView || $0 is UITextField || $0 is UIButton})
        switch (isSetFont, isSetFontWithPixel) {
        case (true, true):
            // This Public Method is Used For Automatic set Font Size According To Device screen Size
            IPadPixelHelper.setFontForIPadFrom(obj: arrFilter)
        case (true, false):
            IPadPixelHelper.setFontForIPadFrom(obj: arrFilter, isSetStaticSize: true)
        default:
            print("")
        }
    }
    
    // MARK: - Class Function For Set ConstraintAutomatic
    /// setConstraintAutomaticForIPad
    ///
    /// - Parameter constr: Array Of NSLayoutConstraint
    public class func setConstraintAutomaticForIPad(constr: [NSLayoutConstraint]) {
        for constraint in constr where constraint.constant != 0 {
            switch constraint.firstAttribute {
            case .top, .bottom, .centerY, .centerYWithinMargins, .height, .topMargin, .bottomMargin, .lastBaseline, .firstBaseline:
                
                print("Y")
                constraint.constant = self.setYPositionAutomaticForIPad(value: constraint.constant)
            case .centerX, .centerXWithinMargins, .width, .left, .leading, .leftMargin, .leadingMargin, .right, .rightMargin, .trailing, .trailingMargin:
                
                print("X")
                constraint.constant = self.setXPositionAutomaticForIPad(value: constraint.constant)
            default :
                print("notAnAttribute")
            }
        }
    }
    
    // MARK: - Class Function For Set FontForDevice
    /// setFontForIPad
    ///
    /// - Parameter constr: Array Of Class (Label, Button, TextView, TextField)
    public class func setFontForIPadFrom(obj: [AnyObject], isSetStaticSize: Bool = false) {
        for objClass in obj {
            switch objClass {
            case is UILabel:
                if isSetStaticSize {
                    (objClass as? UILabel)?.setFontForIPad(fontName: nil, isSetStaticSize: isSetStaticSize)
                } else {
                    (objClass as? UILabel)?.setFontForIPad(fontName: nil, sizeofFont: nil)
                }
            case is UIButton:
                if isSetStaticSize {
                    (objClass as? UIButton)?.setFontForIPad(fontName: nil, isSetStaticSize: isSetStaticSize)
                } else {
                    (objClass as? UIButton)?.setFontForIPad(fontName: nil, sizeofFont: nil)
                }
            case is UITextField:
                if isSetStaticSize {
                    (objClass as? UITextField)?.setFontForIPad(fontName: nil, isSetStaticSize: isSetStaticSize)
                } else {
                    (objClass as? UITextField)?.setFontForIPad(fontName: nil, sizeofFont: nil)
                }
            case is UITextView:
                if isSetStaticSize {
                    (objClass as? UITextView)?.setFontForIPad(fontName: nil, isSetStaticSize: isSetStaticSize)
                } else {
                    (objClass as? UITextView)?.setFontForIPad(fontName: nil, sizeofFont: nil)
                }
            default :
                break
            }
        }
    }
}

// MARK: - Constaraint Constant Change According To Device Pixels
extension CGFloat {
    fileprivate mutating func setXPositionAutomatic(constrInPixel: CGFloat) -> CGFloat {
        let screenheight = UIScreen.main.bounds.size.height
        switch screenheight {
        //IPadPro9Inch
        case IPad.IPadPro9Inch.rawValue:
            self = (constrInPixel * DefaultIPadWidthPixels.IPadPro9Inch.rawValue)/IPadPixelHelper.defaultIPadScreenWidth
            self /= 2
        //IPadPro10Inch
        case IPad.IPadPro10Inch.rawValue:
            self = (constrInPixel * DefaultIPadWidthPixels.IPadPro10Inch.rawValue)/IPadPixelHelper.defaultIPadScreenWidth
            self /= 2
        //IPadPro12Inch
        case IPad.IPadPro12Inch.rawValue:
            self = (constrInPixel * DefaultIPadWidthPixels.IPadPro12Inch.rawValue)/IPadPixelHelper.defaultIPadScreenWidth
            self /= 2
        default:
            self = constrInPixel
        }
        print(self)
        return self
    }

    fileprivate mutating func setYPositionAutomaticForIPad(constrInPixel: CGFloat) -> CGFloat {
        let screenheight = UIScreen.main.bounds.size.height
        switch screenheight {
        //IPadPro9Inch
        case IPad.IPadPro9Inch.rawValue:
            self = (constrInPixel * DefaultIPadHeightPixels.IPadPro9Inch.rawValue)/IPadPixelHelper.defaultIPadScreenHeight
            self /= 2
        //IPadPro10Inch
        case IPad.IPadPro10Inch.rawValue:
            self = (constrInPixel * DefaultIPadHeightPixels.IPadPro10Inch.rawValue)/IPadPixelHelper.defaultIPadScreenHeight
            self /= 2
        //IPadPro12Inch
        case IPad.IPadPro12Inch.rawValue:
            self = (constrInPixel * DefaultIPadHeightPixels.IPadPro12Inch.rawValue)/IPadPixelHelper.defaultIPadScreenHeight
            self /= 2
        default:
            self = constrInPixel
        }
        print(self)
        return self
    }
    
    fileprivate mutating func newSizeFont() -> CGFloat {
        let screenheight = UIScreen.main.bounds.size.height
        var changeValue = self
        
        switch (IPadPixelHelper.defaultIPadScreenHeight, screenheight) {
        //IPadPro9Inch, IPadPro10Inch
        case (DefaultIPadHeightPixels.IPadPro9Inch.rawValue, IPad.IPadPro10Inch.rawValue):
           changeValue += 3
        //IPadPro9Inch, IPadPro12Inch
        case (DefaultIPadHeightPixels.IPadPro9Inch.rawValue, IPad.IPadPro12Inch.rawValue):
            changeValue += 7
        
        // IPadPro10Inch, IPadPro9Inch
        case (DefaultIPadHeightPixels.IPadPro10Inch.rawValue, IPad.IPadPro9Inch.rawValue):
            changeValue -= 3
        //IPadPro10Inch, IPadPro12Inch
        case (DefaultIPadHeightPixels.IPadPro10Inch.rawValue, IPad.IPadPro12Inch.rawValue):
            changeValue += 4
       
        //IPadPro12Inch, IPadPro9Inch
        case (DefaultIPadHeightPixels.IPadPro12Inch.rawValue, IPad.IPadPro9Inch.rawValue):
            changeValue -= 7
        //IPadPro12Inch, IPadPro10Inch
        case (DefaultIPadHeightPixels.IPadPro12Inch.rawValue, IPad.IPadPro10Inch.rawValue):
            changeValue -= 4
        default:
            print("")
        }
        
        return changeValue
    }
}
// MARK: - UILabel Extension
public extension UILabel {
    public func setFontForIPad(fontName: String?, sizeofFont: CGFloat?) {
        var nameOfFont = self.font?.fontName
        var fontSize: CGFloat = self.font!.pointSize
        
        if fontName != nil {
            nameOfFont = fontName!
        }
        if sizeofFont != nil {
            fontSize = sizeofFont!
        }
        var newSize = fontSize * IPadPixelHelper.objIPadPixelHelper.pixelMulti
        newSize = newSize.setYPositionAutomaticForIPad(constrInPixel: newSize)
        self.font = UIFont(name: nameOfFont!, size: newSize)!
    }
    
    public func setFontForIPad(fontName: String?, isSetStaticSize: Bool = false) {
        var nameOfFont = self.font?.fontName
        var fontSize: CGFloat = self.font!.pointSize
        
        if fontName != nil {
            nameOfFont = fontName!
        }
        if isSetStaticSize {
            fontSize = fontSize.newSizeFont()
        }
        self.font = UIFont(name: nameOfFont!, size: fontSize)!
    }
}
// MARK: - UIButton Extension
public extension UIButton {
    public func setFontForIPad(fontName: String?, sizeofFont: CGFloat?) {
        var nameOfFont = self.titleLabel?.font.fontName
        var fontSize: CGFloat = (self.titleLabel?.font.pointSize)!
        
        if fontName != nil {
            nameOfFont = fontName!
        }
        if sizeofFont != nil {
            fontSize = sizeofFont!
        }
        var newSize = fontSize * IPadPixelHelper.objIPadPixelHelper.pixelMulti
        newSize = newSize.setYPositionAutomaticForIPad(constrInPixel: newSize)
        self.titleLabel?.font = UIFont(name: nameOfFont!, size: newSize)!
    }
    
    public func setFontForIPad(fontName: String?, isSetStaticSize: Bool = false) {
        var nameOfFont = self.titleLabel?.font.fontName
        var fontSize: CGFloat = (self.titleLabel?.font.pointSize)!
        
        if fontName != nil {
            nameOfFont = fontName!
        }
        if isSetStaticSize {
            fontSize = fontSize.newSizeFont()
        }
        self.titleLabel?.font = UIFont(name: nameOfFont!, size: fontSize)!
    }
}
// MARK: - UITextField Extension
public extension UITextField {
    public func setFontForIPad(fontName: String?, sizeofFont: CGFloat?) {
        var nameOfFont = self.font?.fontName
        var fontSize: CGFloat = self.font!.pointSize
        
        if fontName != nil {
            nameOfFont = fontName!
        }
        if sizeofFont != nil {
            fontSize = sizeofFont!
        }
        var newSize = fontSize * IPadPixelHelper.objIPadPixelHelper.pixelMulti
        newSize = newSize.setYPositionAutomaticForIPad(constrInPixel: newSize)
        self.font = UIFont(name: nameOfFont!, size: newSize)!
    }
    
    public func setFontForIPad(fontName: String?, isSetStaticSize: Bool = false) {
        var nameOfFont = self.font?.fontName
        var fontSize: CGFloat = self.font!.pointSize
        
        if fontName != nil {
            nameOfFont = fontName!
        }
        if isSetStaticSize {
            fontSize = fontSize.newSizeFont()
        }
        self.font = UIFont(name: nameOfFont!, size: fontSize)!
    }
}

// MARK: - UITextView Extension
public extension UITextView {
    public func setFontForIPad(fontName: String?, sizeofFont: CGFloat?) {
        var nameOfFont = self.font?.fontName
        var fontSize: CGFloat = self.font!.pointSize
        
        if fontName != nil {
            nameOfFont = fontName!
        }
        if sizeofFont != nil {
            fontSize = sizeofFont!
        }
        var newSize = fontSize * IPadPixelHelper.objIPadPixelHelper.pixelMulti
        newSize = newSize.setYPositionAutomaticForIPad(constrInPixel: newSize)
        self.font = UIFont(name: nameOfFont!, size: newSize)!
    }
    
    public func setFontForIPad(fontName: String?, isSetStaticSize: Bool = false) {
        var nameOfFont = self.font?.fontName
        var fontSize: CGFloat = self.font!.pointSize
        
        if fontName != nil {
            nameOfFont = fontName!
        }
        if isSetStaticSize {
            fontSize = fontSize.newSizeFont()
        }
        self.font = UIFont(name: nameOfFont!, size: fontSize)!
    }
}

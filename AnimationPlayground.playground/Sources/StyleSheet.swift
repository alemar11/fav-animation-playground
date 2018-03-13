//  Copyright © 2016 Redbubble. All rights reserved.

import UIKit

/// Font Styles
public enum FontWeight {
    case ultraLight
    case thin
    case light
    case regular
    case medium
    case semibold
    case bold
    case heavy
    case black

    func asFloat() -> CGFloat {
        switch self {
        case .ultraLight: return UIFont.Weight.ultraLight.rawValue
        case .thin: return UIFont.Weight.thin.rawValue
        case .light: return UIFont.Weight.light.rawValue
        case .regular: return UIFont.Weight.regular.rawValue
        case .medium: return UIFont.Weight.medium.rawValue
        case .semibold: return UIFont.Weight.semibold.rawValue
        case .bold: return UIFont.Weight.bold.rawValue
        case .heavy: return UIFont.Weight.heavy.rawValue
        case .black: return UIFont.Weight.black.rawValue
        }
    }

}

extension UIFont {

    private class func dynamicFont(_ bodyStyle: String, weight: FontWeight? = nil) -> UIFont {
        let font = UIFont.preferredFont(forTextStyle: UIFontTextStyle(rawValue: bodyStyle))
        if let weight = weight {
            return UIFont.systemFont(ofSize: font.pointSize, weight: UIFont.Weight(rawValue: weight.asFloat()))
        }
        return font
    }

    class func body(_ weight: FontWeight? = nil) -> UIFont {
        return UIFont.dynamicFont(UIFontTextStyle.body.rawValue, weight: weight)
    }

    class func callout(_ weight: FontWeight? = nil) -> UIFont {
        return UIFont.dynamicFont(UIFontTextStyle.callout.rawValue, weight: weight)
    }

    class func caption1(_ weight: FontWeight? = nil) -> UIFont {
        return UIFont.dynamicFont(UIFontTextStyle.caption1.rawValue, weight: weight)
    }

    class func caption2(_ weight: FontWeight? = nil) -> UIFont {
        return UIFont.dynamicFont(UIFontTextStyle.caption2.rawValue, weight: weight)
    }

    class func footnote(_ weight: FontWeight? = nil) -> UIFont {
        return UIFont.dynamicFont(UIFontTextStyle.footnote.rawValue, weight: weight)
    }

    class func headline(_ weight: FontWeight? = nil) -> UIFont {
        return UIFont.dynamicFont(UIFontTextStyle.headline.rawValue, weight: weight)
    }

    class func subhead(_ weight: FontWeight? = nil) -> UIFont {
        return UIFont.dynamicFont(UIFontTextStyle.subheadline.rawValue, weight: weight)
    }

    class func title1(_ weight: FontWeight? = nil) -> UIFont {
        return UIFont.dynamicFont(UIFontTextStyle.title1.rawValue, weight: weight)
    }

    class func title2(_ weight: FontWeight? = nil) -> UIFont {
        return UIFont.dynamicFont(UIFontTextStyle.title2.rawValue, weight: weight)
    }

    class func title3(_ weight: FontWeight? = nil) -> UIFont {
        return UIFont.dynamicFont(UIFontTextStyle.title3.rawValue, weight: weight)
    }

}

public extension UIColor {

    class func color(_ red: Int, _ green: Int, _ blue: Int) -> UIColor {
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1)
    }

    static var rbWhite: UIColor {
        return UIColor.white
    }

    static var rbArcticWhite: UIColor {
        return UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 246.0/255.0, alpha: 1)
    }

    static var rbLightGrey: UIColor {
        return UIColor(red: 214.0/255.0, green: 218.0/255.0, blue: 223.0/255.0, alpha: 1)
    }

    static var rbSlate: UIColor {
        return UIColor(red: 140.0/255.0, green: 149.0/255.0, blue: 165.0/255.0, alpha: 1)
    }

    static var rbBlue: UIColor {
        return UIColor(red: 74.0/255.0, green: 144.0/255.0, blue: 226.0/255.0, alpha: 1)
    }

    static var rbRed: UIColor {
        return UIColor(red: 1.00, green: 0.37, blue: 0.46, alpha: 1.0)
    }

    static var rbYellow: UIColor {
        return UIColor(red: 255.0/255.0, green: 188.0/255.0, blue: 89.0/255.0, alpha: 1)
    }

    static var rbGreen: UIColor {
        return UIColor(red: 6.0/255.0, green: 214.0/255.0, blue: 160.0/255.0, alpha: 1)
    }

    static var rbBackgroundLightGrey: UIColor {
        return UIColor(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: 1)
    }

    static var rbBodyGrey: UIColor {
        return UIColor(red: 75.0/255.0, green: 79.0/255.0, blue: 89.0/255.0, alpha: 1)
    }

    static var rbCharcoalGrey: UIColor {
        return UIColor(red: 55.0/255.0, green: 55.0/255.0, blue: 58.0/255.0, alpha: 1)
    }

    static var seafoamBlue: UIColor {
        return UIColor(red: 71.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1)
    }

    static var rbWarmPink: UIColor {
        return UIColor(red: 242.0 / 255.0, green: 70.0 / 255.0, blue: 113.0 / 255.0, alpha: 1.0)
    }

    static var rbApricot: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 178.0 / 255.0, blue: 102.0 / 255.0, alpha: 1.0)
    }

    static var rbLightIndigo: UIColor {
        return UIColor(red: 101.0 / 255.0, green: 81.0 / 255.0, blue: 204.0 / 255.0, alpha: 1.0)
    }

    static var rbPrimary: UIColor {
        return UIColor(red: 1.00, green: 0.35, blue: 0.44, alpha: 1.0)
    }

    static var rbNeutral500: UIColor {
        return UIColor(red: 0.55, green: 0.58, blue: 0.65, alpha: 1.0)
    }

    static var rbNeutral50: UIColor {
        return UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0)
    }

    static var rbNeutral100: UIColor {
        return UIColor(red: 0.95, green: 0.95, blue: 0.96, alpha: 1.0)
    }

    static var rbNavigationBarTintGray: UIColor {
        return UIColor(red: 0.23, green: 0.24, blue: 0.28, alpha: 1.0)
    }
}

extension UIImage {
    static var placeholderImage: UIImage {
        return UIImage(named: "image-placeholder")!
    }
}

//
//  UIFont+Ext.swift
//  Shoplon
//
//  Created by Telman Yusifov on 22.05.25.
//

import UIKit

enum FontWeight {
    case regular, extraLight, light, medium, semibold, bold, black
}

extension UIFont {
    static func customFont(weight: FontWeight, size: CGFloat) -> UIFont? {
        switch weight {
        case .regular:
            return UIFont(name: Fonts.plusJakartaSansRegular.rawValue, size: size)
        case .extraLight:
            return UIFont(name: Fonts.plusJakartaSansExtraLight.rawValue, size: size)
        case .light:
            return UIFont(name: Fonts.plusJakartaSansLight.rawValue, size: size)
        case .medium:
            return UIFont(name: Fonts.plusJakartaSansMedium.rawValue, size: size)
        case .semibold:
            return UIFont(name: Fonts.plusJakartaSansSemiBold.rawValue, size: size)
        case .bold:
            return UIFont(name: Fonts.plusJakartaSansBold.rawValue, size: size)
        case .black:
            return UIFont(name: Fonts.plusJakartaSansBlack.rawValue, size: size)
        }
    }
    
    static func grandisFont(weight: FontWeight, size: CGFloat) -> UIFont? {
        switch weight {
        case .regular:
            return UIFont(name: Fonts.grandisExtendedRegular.rawValue, size: size)
        case .extraLight:
            return UIFont(name: Fonts.grandisExtendedThin.rawValue, size: size)
        case .light:
            return UIFont(name: Fonts.grandisExtendedLight.rawValue, size: size)
        case .medium:
            return UIFont(name: Fonts.grandisExtendedMedium.rawValue, size: size)
        case .semibold:
            return UIFont(name: Fonts.grandisExtendedBold.rawValue, size: size)
        case .bold:
            return UIFont(name: Fonts.grandisExtendedBold.rawValue, size: size)
        case .black:
            return UIFont(name: Fonts.grandisExtendedBlack.rawValue, size: size)
        }
    }
    
    static func grandisItalicFont(weight: FontWeight, size: CGFloat) -> UIFont? {
        switch weight {
        case .regular:
            return UIFont(name: Fonts.grandisExtendedRegularItalic.rawValue, size: size)
        case .extraLight:
            return UIFont(name: Fonts.grandisExtendedThinItalic.rawValue, size: size)
        case .light:
            return UIFont(name: Fonts.grandisExtendedLightItalic.rawValue, size: size)
        case .medium:
            return UIFont(name: Fonts.grandisExtendedMediumItalic.rawValue, size: size)
        case .semibold:
            return UIFont(name: Fonts.grandisExtendedBoldItalic.rawValue, size: size)
        case .bold:
            return UIFont(name: Fonts.grandisExtendedBoldItalic.rawValue, size: size)
        case .black:
            return UIFont(name: Fonts.grandisExtendedBlackItalic.rawValue, size: size)
        }
    }
}


//
//  UIExtension.swift
//  OnlineGrocery
//
//  Created by enesozmus on 16.08.2025.
//

import SwiftUI

enum Gilroy: String {
    case airbnbMedium = "Airbnb-Cereald-Medium"
    
    case gilroyRegular = "Gilroy-Regular"
    case gilroyMedium = "Gilroy-Medium"
    case gilroySemibold = "Gilroy-SemiBold"
    case gilroyBold = "Gilroy-Bold"
    
    case hkGroteskBold = "HKGrotesk-Bold"
    case hkGroteskRegular = "HKGrotesk-Regular"
    
    case sveningsson = "Sveningsson"
}

extension Font {
    static func customFont(_ font: Gilroy, fontSize: CGFloat) -> Font {
        custom(font.rawValue, size: fontSize)
    }
}


extension CGFloat {
    static var screenWidth: Double {
        return UIScreen.main.bounds.size.width
    }
    
    static var screenHeight: Double {
        return UIScreen.main.bounds.size.height
    }
    
    static func widthPer(per: Double) -> Double {
        return screenWidth * per
    }
    
    static func heightPer(per: Double) -> Double {
        return screenHeight * per
    }
    
    static var topInsets: Double {
        // if let keyWindow = UIApplication.shared.keyWindow {
        if let keyWindow = UIApplication.shared.connectedScenes.compactMap({ ($0 as? UIWindowScene)?.keyWindow }).last {
            return keyWindow.safeAreaInsets.top
        }
        return 0.0
    }
    
    static var bottomInsets: Double {
        // if let keyWindow = UIApplication.shared.keyWindow {
        if let keyWindow = UIApplication.shared.connectedScenes.compactMap({ ($0 as? UIWindowScene)?.keyWindow }).last {
            return keyWindow.safeAreaInsets.bottom
        }
        return 0.0
    }
    
    static var verticalInsets: Double {
        // if let keyWindow = UIApplication.shared.keyWindow {
        if let keyWindow = UIApplication.shared.connectedScenes.compactMap({ ($0 as? UIWindowScene)?.keyWindow }).last {
            return keyWindow.safeAreaInsets.top + keyWindow.safeAreaInsets.bottom
        }
        return 0.0
    }
    
    static var horizontalInsets: Double {
        // if let keyWindow = UIApplication.shared.keyWindow {
        if let keyWindow = UIApplication.shared.connectedScenes.compactMap({ ($0 as? UIWindowScene)?.keyWindow }).last {
            return keyWindow.safeAreaInsets.left + keyWindow.safeAreaInsets.right
        }
        return 0.0
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corner:  UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corers: corner))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corers: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corers,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        
        return Path(path.cgPath)
    }
}

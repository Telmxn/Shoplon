//
//  UIImage+Ext.swift
//  Shoplon
//
//  Created by Telman Yusifov on 22.06.25.
//

import UIKit

extension UIImage {
    func fixedOrientation() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(in: CGRect(origin: .zero, size: size))
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return normalizedImage ?? self
    }

    func resizedToJPEGCompatible() -> UIImage {
        let maxSize: CGFloat = 1024
        let aspectRatio = size.width / size.height
        let newSize = aspectRatio > 1
            ? CGSize(width: maxSize, height: maxSize / aspectRatio)
            : CGSize(width: maxSize * aspectRatio, height: maxSize)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.8)
        self.draw(in: CGRect(origin: .zero, size: newSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage ?? self
    }
    
    func asJPEGCompatible() -> UIImage {
            UIGraphicsBeginImageContextWithOptions(size, false, scale)
            draw(in: CGRect(origin: .zero, size: size))
            let compatible = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return compatible ?? self
        }
}

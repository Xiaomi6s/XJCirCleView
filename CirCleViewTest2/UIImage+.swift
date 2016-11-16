//
//  UIImage+.swift
//  CirCleViewTest2
//
//  Created by rxj on 2016/9/23.
//  Copyright © 2016年 renxiaojian. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    class func imageForSize(_ size: CGSize, drawingBlock: (CGContext, CGRect) -> Void) ->UIImage? {
        guard size.equalTo(CGSize.zero) == false else {
            return nil
        }
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        context?.clear(rect)
        drawingBlock(context!, rect)
        let theImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return theImage
    }
    class func imageForColor(_ color: UIColor, size: CGSize) ->UIImage? {
        guard size.equalTo(CGSize.zero) == false else {
            return nil
        }
        let taget = UIImage.imageForSize(size) { (context, rect) in
            context.setFillColor(color.cgColor)
            context.fill(rect)
        }
        return taget
    }
     func circleImage() -> UIImage {
        UIGraphicsBeginImageContext(self.size)
        let context = UIGraphicsGetCurrentContext()
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context?.setLineWidth(0)
        context?.setStrokeColor(UIColor.clear.cgColor)
        context?.addEllipse(in: rect)
        context?.clip()
        self.draw(in: rect)
        context?.addEllipse(in: rect)
        context?.strokePath()
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
        
    }
    func clipImageByRect(_ rect: CGRect) -> UIImage {
        let subImageRef = self.cgImage?.cropping(to: rect)
        guard subImageRef != nil else {
            return self
        }
        let smallImage = UIImage(cgImage: subImageRef!)
        return smallImage
        
    }
    func clipImageByEdge(_ edge: Int) -> UIImage {
        let height = (self.cgImage?.height)! - 2 * edge
        let width = (self.cgImage?.width)! - 2 * edge
        let rect = CGRect(x: edge, y: edge, width: width, height: height)
        let image = self.clipImageByRect(rect)
        return image
    }
}

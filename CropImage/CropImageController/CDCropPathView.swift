//
//  CDCropPathView.swift
//  CropImage
//
//  Created by Trinity on 2017/1/12.
//  Copyright © 2017年 Trinity. All rights reserved.
//

import UIKit

internal class CDCropPathView: UIView {
    var path: UIBezierPath? { didSet { setNeedsDisplay() } }
    var foregroundColor: UIColor? { didSet { setNeedsDisplay() } }
    var borderColor: UIColor? { didSet { setNeedsDisplay() } }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        foregroundColor?.setFill()
        (borderColor ?? UIColor.blue).setStroke()
        
        let boundsPath = UIBezierPath(rect: bounds)
        boundsPath.fill()
        
        path?.lineWidth = 8
        path?.stroke()
        path?.fill(with: .clear, alpha: 1)
    }
}

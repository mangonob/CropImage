//
//  CDCropPathView.swift
//  CropImage
//
//  Created by Trinity on 2017/1/12.
//  Copyright © 2017年 Trinity. All rights reserved.
//

import UIKit

@objc protocol CDCropPathViewDelegate {
    @objc optional func cd_cropPathViewDidLayoutSubviews(_ cropPathView: CDCropPathView)
}

internal class CDCropPathView: UIView {
    weak var delegate: CDCropPathViewDelegate?
    
    var path: UIBezierPath? { didSet { setNeedsDisplay() } }
    var foregroundColor: UIColor? { didSet { setNeedsDisplay() } }
    var borderColor: UIColor? { didSet { setNeedsDisplay() } }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        delegate?.cd_cropPathViewDidLayoutSubviews?(self)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        foregroundColor?.setFill()
        (borderColor ?? UIColor.lightGray).setStroke()
        
        let boundsPath = UIBezierPath(rect: bounds)
        boundsPath.fill()
        
        guard let path = path else { return }
        
        let centerOfPath = CGPoint(x: path.bounds.origin.x + path.bounds.width / 2, y: path.bounds.origin.y + path.bounds.height / 2)
        let centerOfSelf = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let delta = CGPoint(x: centerOfSelf.x - centerOfPath.x, y: centerOfSelf.y - centerOfPath.y)
        
        path.apply(CGAffineTransform.identity.translatedBy(x: delta.x, y: delta.y))
        
        path.lineWidth = 2
        path.stroke()
        
        path.fill(with: .clear, alpha: 1)
    }
}

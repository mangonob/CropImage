//
//  CDCropView.swift
//  CropImage
//
//  Created by Trinity on 2017/1/12.
//  Copyright © 2017年 Trinity. All rights reserved.
//

import UIKit

class CDCropView: UIView {
    @IBOutlet weak var centerX: NSLayoutConstraint!
    @IBOutlet weak var centerY: NSLayoutConstraint!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pathView: CDCropPathView!
    
    var centerOffset: CGPoint = CGPoint.zero {
        didSet {
            centerX.constant = centerOffset.x
            centerY.constant = centerOffset.y
            setNeedsUpdateConstraints()
        }
    }
    
    var image: UIImage? {
        didSet {
            if imageView != nil {
                imageView.image = image
                if let size = image?.size {
                    imageView.frame = CGRect(origin: CGPoint.zero, size: size)
                }
            }
        }
    }
}

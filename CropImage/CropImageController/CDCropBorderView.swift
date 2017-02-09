//
//  CDCropBorderView.swift
//  CropImage
//
//  Created by Trinity on 2017/1/13.
//  Copyright © 2017年 Trinity. All rights reserved.
//

import UIKit

@objc protocol CDCropBorderViewDelegate {
    @objc optional func cd_cropBorderViewDidLayoutSubviews(_ cropPathView: CDCropBorderView)
}

class CDCropBorderView: UIView {
    weak var delegate: CDCropBorderViewDelegate?
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        delegate?.cd_cropBorderViewDidLayoutSubviews?(self)
    }
}

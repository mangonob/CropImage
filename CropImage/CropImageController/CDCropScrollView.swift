//
//  CDCropScrollView.swift
//  CropImage
//
//  Created by 高炼 on 17/1/13.
//  Copyright © 2017年 Trinity. All rights reserved.
//

import UIKit

internal class CDCropScrollView: UIScrollView {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return true
    }
}

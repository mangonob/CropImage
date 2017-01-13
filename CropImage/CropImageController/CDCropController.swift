//
//  CDCropController.swift
//  CropImage
//
//  Created by 高炼 on 17/1/13.
//  Copyright © 2017年 Trinity. All rights reserved.
//

import UIKit

class CDCropController: UIViewController {
    private var _cropView: CDCropView!
    var cropView: CDCropView {
        if _cropView == nil {
            _cropView = CDCropView.instance()
        }
        return _cropView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        
        _cropView.translatesAutoresizingMaskIntoConstraints = true
        _cropView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        _cropView.frame = view.bounds
        view.addSubview(_cropView)
        
        view.backgroundColor = UIColor.white
        
        cropView.path = UIBezierPath(ovalIn: CGRect(x: 100, y: 100, width: 200, height: 200))
    }
}

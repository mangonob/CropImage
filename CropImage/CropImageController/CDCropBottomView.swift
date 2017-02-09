//
//  CDCropButtomView.swift
//  CropImage
//
//  Created by 高炼 on 17/2/9.
//  Copyright © 2017年 Trinity. All rights reserved.
//

import UIKit

class CDCropBottomView: UIView {
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    //MARK: - Initialize
    static func instance() -> CDCropBottomView {
        return Bundle(for: CDCropBottomView.self).loadNibNamed(String(describing: CDCropBottomView.self), owner: nil, options: nil)?.first as! CDCropBottomView
    }
    
    init() {
        fatalError("\(CDCropView.classForCoder()) - \(#function): You can only use CDCropView.instance()")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

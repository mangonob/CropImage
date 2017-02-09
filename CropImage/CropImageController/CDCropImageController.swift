//
//  CDCropImageController.swift
//  CropImage
//
//  Created by Trinity on 2017/1/12.
//  Copyright © 2017年 Trinity. All rights reserved.
//

import UIKit

@objc protocol CDCropImageControllerDelegate {
    @objc optional func cd_cropImageControllerCancel(_ cropImageController: CDCropImageController);
    @objc optional func cd_cropImageControllerDone(_ cropImageController: CDCropImageController);
}

class CDCropImageController: UIViewController {
    weak var delegate: CDCropImageControllerDelegate?
    
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
        
        edgesForExtendedLayout = []
        
        _cropView.translatesAutoresizingMaskIntoConstraints = true
        _cropView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        _cropView.frame = view.bounds
        view.addSubview(_cropView)
        
        let bottom = CDCropBottomView.instance()
        bottom.translatesAutoresizingMaskIntoConstraints = false
        _cropView.addSubview(bottom)
        
        bottom.leftButton.addTarget(self, action: #selector(self.cancelAction(sender:)), for: .touchUpInside)
        bottom.rightButton.addTarget(self, action: #selector(self.doneAction(sender:)), for: .touchUpInside)
        
        let views = ["bottom": bottom]
        _cropView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-0-[bottom]-0-|", options: [], metrics: nil, views: views))
        _cropView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[bottom(==72.5)]-0-|", options: [], metrics: nil, views: views))
        
        view.backgroundColor = UIColor.white
        
        cropView.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 300, height: 300))
    }
    
    //MARK: - Action
    func cancelAction(sender: Any?) {
        dismissIfNeed()
        delegate?.cd_cropImageControllerCancel?(self)
    }
    
    func doneAction(sender: Any?) {
        dismissIfNeed()
        delegate?.cd_cropImageControllerDone?(self)
    }
    
    func dismissIfNeed() {
        if presentingViewController != nil {
            dismiss(animated: true, completion: nil)
        }
    }
}


//MARK: - Packaged Properties Of cropController.cropView
extension CDCropImageController {
    var image: UIImage? {
        get {
            return cropView.image
        }
        set {
            cropView.image = newValue
        }
    }
    
    var cropPath: UIBezierPath? {
        get {
            return cropView.path
        }
        set {
            cropView.path = newValue
        }
    }
    
    var cropBackground: UIColor? {
        get {
            return cropView.backgroundColor
        }
        set {
            cropView.backgroundColor = newValue
        }
    }
    
    var cropForeground: UIColor? {
        get {
            return cropView.foregroundColor
        }
        set {
            cropView.foregroundColor = newValue
        }
    }
    
    var resultImage: UIImage? {
        return cropView.resultImage
    }
    
    var borderColor: UIColor? {
        get {
            return cropView.borderColor
        }
        set {
            cropView.borderColor = newValue
        }
    }
    
}

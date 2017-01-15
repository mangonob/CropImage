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
    var autoDismiss = true
    
    //MARK: - Content ViewControllers
    private var _cropController: CDCropController!
    var cropController: CDCropController {
        if _cropController == nil {
            _cropController = CDCropController()
            _cropController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancelAction(sender:)))
            _cropController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneAction(sender:)))
        }
        return _cropController
    }
    
    private var _innerNavigationController: UINavigationController!
    var innerNavigationController: UINavigationController {
        if _innerNavigationController == nil {
            _innerNavigationController = UINavigationController(rootViewController: cropController)
            _innerNavigationController.setNavigationBarHidden(true, animated: false)
        }
        return _innerNavigationController
    }
    
    //MARK: - UIViewDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildViewController(innerNavigationController)
        innerNavigationController.view.translatesAutoresizingMaskIntoConstraints = true
        innerNavigationController.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        innerNavigationController.view.frame = view.bounds
        view.addSubview(innerNavigationController.view)
        
        view.backgroundColor = UIColor.clear
    }
    
    //MARK: - Action
    func doneAction(sender: Any) {
        if (autoDismiss) { dismiss(animated: true, completion: nil) }
        delegate?.cd_cropImageControllerDone?(self)
    }
    
    func cancelAction(sender: Any) {
        if (autoDismiss) { dismiss(animated: true, completion: nil) }
        delegate?.cd_cropImageControllerCancel?(self)
    }
}


//MARK: - Packaged Properties Of cropController.cropView
extension CDCropImageController {
    var image: UIImage? {
        get {
            return cropController.cropView.image
        }
        set {
            cropController.cropView.image = newValue
        }
    }
    
    var cropPath: UIBezierPath? {
        get {
            return cropController.cropView.path
        }
        set {
            cropController.cropView.path = newValue
        }
    }
    
    var cropBackground: UIColor? {
        get {
            return cropController.cropView.backgroundColor
        }
        set {
            cropController.cropView.backgroundColor = newValue
        }
    }
    
    var cropForeground: UIColor? {
        get {
            return cropController.cropView.foregroundColor
        }
        set {
            cropController.cropView.foregroundColor = newValue
        }
    }
    
    var currentCroppedImage: UIImage? {
        return cropController.cropView.currentCroppedImage
    }
    
    var borderColor: UIColor? {
        get {
            return cropController.cropView.borderColor
        }
        set {
            cropController.cropView.borderColor = newValue
        }
    }
    
}

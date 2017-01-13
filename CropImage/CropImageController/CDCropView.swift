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
    
    @IBOutlet var borderViews: [UIView]!
    
    //MARK: - Initialize
    static func instance() -> CDCropView {
        let crop = Bundle(for: CDCropView.self).loadNibNamed(String(describing: CDCropView.self), owner: nil, options: nil)?.first as! CDCropView
        crop.configure()
        return crop
    }
    
    init() {
        fatalError("\(CDCropView.classForCoder()) - \(#function): You can only use CDCropView.instance()")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Properties
    var centerOffset: CGPoint = CGPoint.zero {
        didSet {
            centerX.constant = centerOffset.x
            centerY.constant = centerOffset.y
            setNeedsUpdateConstraints()
        }
    }
    
    var image: UIImage? {
        didSet {
            imageView.image = image
            if let size = image?.size {
                imageView.frame = CGRect(origin: CGPoint.zero, size: size)
            }
            updateScrollView()
        }
    }
    
    var currentCroppedImage: UIImage? {
        return nil
    }
    
    //MARK: - Configure
    private func configure() {
        super.backgroundColor = UIColor.clear
        scrollView.minimumZoomScale = 0.5
        scrollView.maximumZoomScale = 2
        scrollView.delegate = self
        updateScrollView()
        
        foregroundColor = UIColor.black.withAlphaComponent(0.5)
        pathView.backgroundColor = UIColor.clear
    }
    
    override var frame: CGRect {
        didSet {
            updateScrollView()
        }
    }

    //MARK: - Update
    internal func updateScrollView() {
        if scrollView == nil { return }
        
        if let path = path, pathView != nil {
            scrollView?.frame = convert(path.bounds, from: pathView)
        }
        
        if let image = image {
            scrollView?.contentSize = image.size
        }
        
        if let path = path, let image = image {
        }
    }
    
    //MARK: - UIView
    override func layoutSubviews() {
        super.layoutSubviews()
        if path == nil {
            scrollView.frame = bounds
        }
        
        updateScrollView()
    }
}


extension CDCropView: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
}


//MARK: - Packaged Properties Of PathView
extension CDCropView {
    var path: UIBezierPath? {
        get {
            return pathView.path
        }
        set {
            pathView.path = newValue
            updateScrollView()
        }
    }
    
    var borderColor :UIColor? {
        get {
            return pathView.borderColor
        }
        set {
            pathView.borderColor = newValue
        }
    }
    
    var foregroundColor: UIColor? {
        get {
            return pathView.foregroundColor
        }
        set {
            pathView.foregroundColor = newValue
            borderViews.forEach { (v) in
                v.backgroundColor = pathView.foregroundColor
            }
        }
    }
}




































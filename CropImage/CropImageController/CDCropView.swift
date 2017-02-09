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
    @IBOutlet weak var scrollView: CDCropScrollView!
    @IBOutlet weak var pathView: CDCropPathView!
    
    @IBOutlet var borderViews: [CDCropBorderView]!
    
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
    
    var resultImage: UIImage? {
        guard !scrollView.isTracking else { return nil }
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
        
        pathView.delegate = self
        borderViews.forEach { (view) in
            view.delegate = self
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name.UIDeviceOrientationDidChange, object: nil, queue: nil) { (notification)  in
            print(self.pathView.frame)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    //MARK: - Update
    internal func updateScrollView() {
        if scrollView == nil { return }
        
        if let path = path, pathView != nil {
            let s1 = path.bounds.size
            let s2 = pathView.bounds.size
            let origin = CGPoint(x: (s2.width - s1.width) / 2, y: (s2.height - s1.height) / 2)
            let b = CGRect(origin: origin, size: s1)
            
            scrollView?.frame = convert(b , from: pathView)
        }
        
        if let image = image {
            let w = image.size.width
            let h = image.size.height
            let s = scrollView.zoomScale
            scrollView?.contentSize = CGSize(width: w * s, height: h * s)
        }
        
        scrollView.setZoomScale(suggestZoomScale, animated: false)
        scrollView.setContentOffset(suggestContentOffset, animated: false)
    }
    
    //MARK: - UIView
    override func layoutSubviews() {
        super.layoutSubviews()
        if path == nil {
            scrollView.frame = bounds
        }
        
        updateScrollView()
    }
    
    private var suggestZoomScale: CGFloat {
        guard let ms = image?.size, let path = path else { return 1 }
        let bs = bounds.size
        let ps = path.bounds.size
        
        let min1 = min(bs.width / ms.width, bs.height / ms.height) + 0.0005
        let min2 = max(ps.width / ms.width, ps.height / ms.height) + 0.0005
        
        scrollView.minimumZoomScale = min2
        
        scrollView.maximumZoomScale = max(1, 2 * max(min1, min2))
        
        return max(min1, min2)
    }
    
    private var suggestContentOffset: CGPoint {
        var b = CGRect(origin: CGPoint.zero, size: CGSize.zero)
        b.size = scrollView.bounds.size
        let midPointOfScroll = CGPoint(x: b.midX, y: b.midY)
        
        b.size = imageView.frame.size
        let midPointImage = CGPoint(x: b.midX, y: b.midY)
        
        var offset = CGPoint(x: midPointImage.x - midPointOfScroll.x, y: midPointImage.y - midPointOfScroll.y)
        offset.x += centerOffset.x
        offset.y += centerOffset.y
        
        return offset
    }
    
    // MARK: - Action
    @IBAction func doubleTapAction(_ sender: Any) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            for _ in 1...2 {
                guard let scale = self?.suggestZoomScale, let offset = self?.suggestContentOffset else { return }
                self?.scrollView.contentOffset = offset
                self?.scrollView.zoomScale = scale
            }
        }
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

extension CDCropView: CDCropPathViewDelegate {
    func cd_cropPathViewDidLayoutSubviews(_ cropPathView: CDCropPathView) {
        updateScrollView()
    }
}

extension CDCropView: CDCropBorderViewDelegate {
    func cd_cropBorderViewDidLayoutSubviews(_ cropPathView: CDCropBorderView) {
        updateScrollView()
    }
}



































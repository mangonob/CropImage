//
//  ViewController.swift
//  CropImage
//
//  Created by Trinity on 2017/1/12.
//  Copyright © 2017年 Trinity. All rights reserved.
//

import UIKit
import QBImagePickerController

class ViewController: UIViewController {
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage? {
        didSet {
            button.isHidden = image != nil
            imageView.image = image
        }
    }
    
    @IBAction func tap(_ sender: Any) {
        let ipc = QBImagePickerController()
        ipc.mediaType = .image
        ipc.delegate = self
        present(ipc, animated: true, completion: nil)
    }
}

extension ViewController: QBImagePickerControllerDelegate {
    func qb_imagePickerControllerDidCancel(_ imagePickerController: QBImagePickerController!) {
        imagePickerController.dismiss(animated: true, completion: nil)
    }
    
    func qb_imagePickerController(_ imagePickerController: QBImagePickerController!, didFinishPickingAssets assets: [Any]!) {
        imagePickerController.dismiss(animated: true) {
            guard let asset = assets.first as? PHAsset else { return }
            
            let options = PHImageRequestOptions()
            options.isSynchronous = true
            
            PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight), contentMode: .default, options: options, resultHandler: { [weak self] (image, _) in
                guard let image = image else { return }
                let vc = CDCropImageController()
                vc.image = image
                self?.present(vc, animated: true, completion: nil)
            })
        }
    }
}



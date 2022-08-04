//
//  ImageCVC.swift
//  WOOWProjectVIPER
//
//  Created by Andrei Mosneag on 02.08.2022.
//

import UIKit

class ImageCVC: UICollectionViewCell, UIScrollViewDelegate {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var scrolView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setZoom()
    }
    func setup(model: String) {
    image.setImage(with: model )
        
    }
    
    private func setZoom() {
        image.isUserInteractionEnabled = true
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(self.pinchGesture))
        image.addGestureRecognizer(pinchGesture)
    }
    
    
    @objc func pinchGesture(sender:UIPinchGestureRecognizer) {
        sender.view?.transform = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale))!
        sender.scale = 1
    }
   
    

}

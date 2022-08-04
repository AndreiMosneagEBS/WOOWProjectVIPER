//
//  ImageProductCVC.swift
//  WOOWProjectVIPER
//
//  Created by Andrei Mosneag on 29.07.2022.
//

import UIKit

class ImageProductCVC: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var imageProduct: UIImageView!
    
    func setup(model: ProductDetails, page: Int){
        imageProduct.setImage(with: model.mainImage ?? "")
    }
    
}

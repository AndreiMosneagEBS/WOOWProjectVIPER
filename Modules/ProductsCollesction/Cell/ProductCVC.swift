//
//  ProductCVC.swift
//  WOOWProjectVIPER
//
//  Created by Andrei Mosneag on 08.08.2022.
//

import UIKit

class ProductCVC: UICollectionViewCell {

    
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var nameProduct: UILabel!
    @IBOutlet weak var aboutProduct: UILabel!
    @IBOutlet weak var priceProduct: UILabel!
    @IBOutlet weak var saleProduct: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var saleButton: UIButton!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(model: About) {
        nameProduct.text = model.name
        aboutProduct.text = model.size
        if let model = model.price {
            priceProduct.text = "\(model)"
            saleProduct.text = "\(model)"
        }
        imageProduct.setImage(with: model.mainImage ?? "")
 
    }
    

}

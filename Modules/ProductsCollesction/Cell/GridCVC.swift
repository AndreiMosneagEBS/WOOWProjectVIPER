//
//  GridCVC.swift
//  WOOWProjectVIPER
//
//  Created by Andrei Mosneag on 09.08.2022.
//

import UIKit

class GridCVC: UICollectionViewCell {

    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var nameProduct: UILabel!
    @IBOutlet weak var sizeProduct: UILabel!
    @IBOutlet weak var priceProduct: UILabel!
    @IBOutlet weak var saleProduct: UILabel!
    
    
    
    func setup(model: About) {
        nameProduct.text = model.name
        sizeProduct.text = model.size
        if let model = model.price {
            priceProduct.text = "\(model)"
            saleProduct.text = "\(model)"
        }
        imageProduct.setImage(with: model.mainImage ?? "")
 
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

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
    @IBOutlet weak var stakView: UIStackView!
    @IBOutlet weak var constraintWidth: NSLayoutConstraint!
    @IBOutlet weak var constraintHeight: NSLayoutConstraint!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setup(model: About, stack: Bool) {
        nameProduct.text = model.name
        aboutProduct.text = model.size
        if let model = model.price {
            priceProduct.text = "\(model)"
            saleProduct.text = "\(model)"
        }
        imageProduct.setImage(with: model.mainImage ?? "")
        
        if stack {
            stakView.axis = .horizontal
            constraintWidth.priority = .required
            constraintHeight.priority = .defaultLow
            
        } else {
            stakView.axis = .vertical
            constraintWidth.priority = .defaultLow
            constraintHeight.priority = .required
            
        }
        self.layoutIfNeeded()
    }
    
    

}

//
//  ProductCVC.swift
//  WOOWProjectVIPER
//
//  Created by Andrei Mosneag on 08.08.2022.
//

import UIKit

class ProductCVC: UICollectionViewCell {
    
    var didTapFavorite: (() -> Void)?
    
    override open var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? UIColor(r: 0.03, g:  0.1, b: 0.36) : UIColor.white
            self.tintColor = isSelected ? UIColor.white : UIColor(r: 0.03, g:  0.1, b: 0.36)
        }
    }

    
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
        favoriteButton.backgroundColor = UIColor(named: "gri")
        favoriteButton.cornerRadius = favoriteButton.frame.width / 2
        favoriteButton.setImage(UIImage(named: "heartFull"), for: .selected)
        favoriteButton.setImage(UIImage(named: "heartEmpty-1"), for: .normal)
        
        saleButton.cornerRadius = saleButton.frame.width / 2
        saleButton.setBackgroundColor(UIColor(red: 0.03, green: 0.1, blue: 0.36, alpha: 1.0), for: .selected)
        saleButton.setTitleColor(.white, for: .selected)
        saleButton.setBackgroundColor(.white, for: .normal)
        saleButton.setTitleColor(UIColor(red: 0.03, green: 0.1, blue: 0.36, alpha: 1.0), for: .normal)
    }
    
    
    struct Params {
        var id: Int
        var name: String
        var size: String
        var pice: Int
        var priceSale: Int
        var image: String
    }
    
    func setup(model: Params, stack: Bool) {
        nameProduct.text = model.name
        aboutProduct.text = model.size
        let isFavorite = FavoriteManager.shared.checkFavorite(id: model.id)
        favoriteButton.isSelected = isFavorite
        priceProduct.text = "\(model.pice)"
        saleProduct.text = "\(model.pice)"
        imageProduct.setImage(with: model.image )
        
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
    
    @IBAction func favoriteButtonAction(_ sender: Any) {
        didTapFavorite?()
    }
    
   
    
    

}

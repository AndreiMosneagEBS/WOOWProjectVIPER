//
//  BayCVC.swift
//  WOOWProjectVIPER
//
//  Created by Andrei Mosneag on 11.08.2022.
//

import UIKit

class BayCVC: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var priceSale: UILabel!
    @IBOutlet weak var viewPlusButton: UIView!
    @IBOutlet weak var buttonPlus: UIButton!
    @IBOutlet weak var labelCoutProduct: UILabel!
    @IBOutlet weak var viewButtonMinus: UIView!
    @IBOutlet weak var buttonMinus: UIButton!
    @IBOutlet weak var viewUrna: UIView!
    @IBOutlet weak var buttonUrna: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func setupView() {
        viewUrna.cornerRadius = viewUrna.frame.width/2
        viewPlusButton.cornerRadius = viewUrna.frame.width/2
        viewButtonMinus.cornerRadius = viewUrna.frame.width/2
        
    }
    
    struct Params {
        var id: Int
        var name: String
        var size: String
        var price: Int
        var priceSale: Int
        var image: String
        
    }
    
    
    func setup(model: Params) {
        name.text = model.name
        size.text = model.size
        price.text = String(model.price)
        priceSale.text = String(model.priceSale)
        image.setImage(with: model.image)
        
        
        
        
    }
    
    
    
    func setup () {
        
    }
    
    
    
}

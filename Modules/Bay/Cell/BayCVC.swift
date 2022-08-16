//
//  BayCVC.swift
//  WOOWProjectVIPER
//
//  Created by Andrei Mosneag on 11.08.2022.
//

import UIKit

class BayCVC: UICollectionViewCell {
    
    var didTapDelete: (() -> Void)?
    var didTapPlus: (() -> Void)?
    var didTapMinus: (() -> Void)?
    var labelPriceTotal: ((Int) -> Void)?
    
    
    var priceProduct: Int = 0
    var countProduct = 0
    var total: Int = 0
    
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
        var count: Int
        
    }
    
    func setup(params: Params, count: Int) {
        name.text = params.name
        size.text = params.size
        price.text = String(params.price)
        priceSale.text = String(params.priceSale)
        image.setImage(with: params.image)
        labelCoutProduct.text = String(params.count)
        priceProduct = params.price
        countProduct = count
        total = priceProduct * countProduct
    }
    
    
    
    @IBAction func deleteProductCartAction(_ sender: Any) {
        didTapDelete?()
    }
    
    
    
    @IBAction func plusProduct(_ sender: Any) {
        didTapPlus?()
        labelPriceTotal!(total)
    }
    
    @IBAction func minusProduct(_ sender: Any) {
        didTapMinus?()
        labelPriceTotal!(total)
    }
    
}

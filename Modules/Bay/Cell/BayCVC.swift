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
    var labelPrice: ((Int) -> Void)?
    
    
    var priceProdcut: Int = 2
    
    var countlabel = 2
    
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
    
    func setup(params: Params) {
        name.text = params.name
        size.text = params.size
        price.text = String(params.price)
        priceSale.text = String(params.priceSale)
        image.setImage(with: params.image)
        labelCoutProduct.text = String(params.count)
        priceProdcut = params.price
    }
    
    @IBAction func deleteProductCartAction(_ sender: Any) {
        didTapDelete?()
    }
    
    
    
    @IBAction func plusProduct(_ sender: Any) {
//        labelPrice!(countlabel * priceProdcut)
        didTapPlus?()
//        if countlabel >= 999 {
//            labelCoutProduct.text = "999"
//        } else {
//            countlabel += 1
//
//        }
    }
    
    @IBAction func minusProduct(_ sender: Any) {
//        labelPrice!(countlabel * priceProdcut)
        didTapMinus?()
//        if countlabel <= 1 {
//            
//            labelCoutProduct.text = "1"
//        } else {
//            countlabel -= 1
//        }
        
    }
    
}

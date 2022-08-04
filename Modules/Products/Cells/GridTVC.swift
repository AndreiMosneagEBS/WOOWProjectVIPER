//
//  GridTVC.swift
//  WOOWProjectVIPER
//
//  Created by Andrei Mosneag on 02.08.2022.
//

import UIKit

class GridTVC: UITableViewCell {
    
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var nameProduct: UILabel!
    @IBOutlet weak var sizeProduct: UILabel!
    @IBOutlet weak var priceProduct: UILabel!
    @IBOutlet weak var saleProduct: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(model: About) {
        nameProduct.text = model.name
        sizeProduct.text = model.size
        if let model = model.price {
            priceProduct.text = "\(model)"
            saleProduct.text = "\(model)"
        }
        imageProduct.setImage(with: model.mainImage ?? "")
 
    }
    
    
    
    
}

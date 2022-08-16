//
//  ButtonCart.swift
//  WOOWProjectVIPER
//
//  Created by Andrei Mosneag on 15.08.2022.
//

import Foundation
import UIKit

class ButtonCart: UIButton {
    
    
    override open var isSelected: Bool {
        didSet {
            changeStateOfButton()

        }
    }
    
    override func awakeFromNib()
        {
            tintColor = UIColor.green
            changeStateOfButton()
            self.cornerRadius = self.frame.width / 2
        }

        func changeStateOfButton() {
           if self.isSelected {
               self.tintColor = UIColor.white
               self.backgroundColor = UIColor(red: 0.03, green: 0.1, blue: 0.36, alpha: 1.0)
           }
           else {
               self.tintColor = UIColor(red: 0.03, green: 0.1, blue: 0.36, alpha: 1.0)
               self.backgroundColor = UIColor.white

      }
}
}

//
//  AttributedString+.swift
//  Babaliste
//
//  Created by Constantin Breahna on 5/29/18.
//  Copyright © 2018 EBS-Integrator. All rights reserved.
//

import UIKit
import AVFoundation

public extension NSMutableAttributedString {
    
    static func attributedStringFrom(_ image: UIImage, withSize size: CGSize? = nil) -> NSMutableAttributedString {
        let imageSize = size ?? image.size
        
        let checkAttachment = NSTextAttachment()
        checkAttachment.image = image
        checkAttachment.bounds = CGRect(origin: CGPoint(x: 0, y: 0), size: image.size.scaleAndFit(in: imageSize))
        
        let attributed = NSAttributedString(attachment: checkAttachment)
        return NSMutableAttributedString(attributedString: attributed)
    }
    
    static func attributedString(_ text: String, withFont font: UIFont = UIFont.systemFont(ofSize: 17), color: UIColor = .black, lineSpacing: CGFloat = 5.0) -> NSMutableAttributedString {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: color,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]
        return NSMutableAttributedString(string: text, attributes: attributes)
    }
    
    func addKernEffect() -> NSMutableAttributedString? {
        self.addAttribute(.kern, value: -0.2, range: NSRange(location: 0, length: self.length))
        return self
    }
    
}

extension NSAttributedString {
    public static func localizeAttributedString(text: String, font: UIFont, color: UIColor, arguments: NSAttributedString...) -> NSAttributedString {
        let attributedText = NSMutableAttributedString.attributedString(text, withFont: font, color: color)
                        
        for argument in arguments {
            let variableRange = NSString(string: attributedText.string).range(of: "%@")
            attributedText.replaceCharacters(in: variableRange, with: argument)
        }
        
        return attributedText
    }
}

public extension CGSize {
    
    func scaleAndFit(in inputSize: CGSize) -> CGSize {
        let scaledSize: CGSize = {
            let ratio = (self.height > inputSize.width) ?
                min(self.height / inputSize.height, 1.0):
                min(self.width / inputSize.width, 1.0)
            return CGSize(width: inputSize.width * ratio, height: inputSize.height * ratio)
        }()
        
        let scaledAspectFitRect = AVMakeRect(aspectRatio: self, insideRect: CGRect(origin: .zero, size: scaledSize))
        return scaledAspectFitRect.size
    }
}

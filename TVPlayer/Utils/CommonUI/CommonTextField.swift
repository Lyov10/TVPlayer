//
//  CommonTextField.swift
//  TVPlayer
//
//  Created by 4steps on 19.05.23.
//

import Foundation
import UIKit

class CommonTextField: UITextField {
    
    @IBInspectable var leftModeImage: UIImage? = nil {
        didSet {
            setLeftImageMode(image: leftModeImage)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
        
    
    func setLeftImageMode(image: UIImage?) {
        let leftImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        leftImageView.image = image
        leftImageView.contentMode = .center
        leftView = leftImageView
        leftViewMode = .always
    }
}

//
//  GradientProgressBar.swift
//  TVPlayer
//
//  Created by 4steps on 19.05.23.
//

import UIKit

public enum GradientOrientation {
    case vertical
    case horizontal
}

class GradientProgressView: UIProgressView {
    
    @IBInspectable var firstColor: UIColor = UIColor.white {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var secondColor: UIColor = UIColor.black {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
                
        if let gradientImage = UIImage(bounds: self.bounds, colors: [firstColor, secondColor]) {
            self.progressImage = gradientImage
        }
    }
}

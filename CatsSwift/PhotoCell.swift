//
//  PhotoCell.swift
//  CatsSwift
//
//  Created by Jaewon Kim on 2017-11-10.
//  Copyright © 2017 Jaewon Kim. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func vibration() {
        let vibrateCell = CABasicAnimation.init(keyPath: "position")
        vibrateCell.duration = 0.05
        vibrateCell.repeatCount = 5
        vibrateCell.autoreverses = true
        vibrateCell.fromValue = NSValue.init(cgPoint: CGPoint.init(x: self.center.x - 4 , y: self.center.y - 4))
        vibrateCell.toValue = NSValue.init(cgPoint: CGPoint.init(x: self.center.x + 4, y: self.center.y + 4))
        
        self.layer.add(vibrateCell, forKey: "position")
    }
    
}

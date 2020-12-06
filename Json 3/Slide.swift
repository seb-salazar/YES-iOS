//
//  Slide.swift
//  animatedScrollView
//
//  Created by Sebastian Salazar Reyes on 2/6/19.
//  Copyright © 2019 Sebastian Salazar. All rights reserved.
//

import UIKit

class Slide: UIView {

    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var labelTitle: UILabel!
    
    
    @IBOutlet var questionLabel: UILabel!
    
   
    
    

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
//        self.backgroundColor = UIColor.black
//        self.backgroundColor?.setFill()
//        UIGraphicsGetCurrentContext()!.fill(rect);
    }
    
    override func awakeFromNib() {
        backgroundColor = UIColor.black
    }
    
    
    
    

}

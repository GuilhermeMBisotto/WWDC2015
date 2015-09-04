//
//  LabelGlow.swift
//  GuilhermeBisotto
//
//  Created by Guilherme Moresco Bisotto on 4/23/15.
//  Copyright (c) 2015 GuilhermeBisotto. All rights reserved.
//

import Foundation
import UIKit

class LabelGlow: UILabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        var color: UIColor = UIColor.whiteColor()
        
        layer.shadowColor = color.CGColor
        layer.shadowRadius = 6.0
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSizeZero
        layer.masksToBounds = false;
    }
}

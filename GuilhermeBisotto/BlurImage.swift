//
//  BlurImage.swift
//  GuilhermeBisotto
//
//  Created by Guilherme Moresco Bisotto on 4/15/15.
//  Copyright (c) 2015 GuilhermeBisotto. All rights reserved.
//

import Foundation
import UIKit

class blurImage: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        var blur:UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        var effectView:UIVisualEffectView = UIVisualEffectView (effect: blur)
        effectView.frame = frame
        addSubview(effectView)
    }
    
}
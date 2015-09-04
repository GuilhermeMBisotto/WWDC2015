//
//  ShowImage.swift
//  GuilhermeBisotto
//
//  Created by Guilherme Moresco Bisotto on 4/22/15.
//  Copyright (c) 2015 GuilhermeBisotto. All rights reserved.
//

import Foundation
import UIKit

class ShowImage: UIViewController {
    
    @IBOutlet weak var img: UIImageView!
    
    //MARK: - Variables
    var image: UIImageView!
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addEffectOfTransparency()
        img.alpha = 0.0
        self.img.image = self.image.image
        
        UIView.animateWithDuration(1.0, animations: {
            self.img.alpha = 1.0
        }, completion: nil )
    }

    //MARK: - Layout Adjustments
    func addEffectOfTransparency() {
        view.backgroundColor = UIColor(red:0.0, green:0.0,blue:0.0,alpha:0.0)
    }
    
    //MARK: - Actions
    @IBAction func closeModal(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

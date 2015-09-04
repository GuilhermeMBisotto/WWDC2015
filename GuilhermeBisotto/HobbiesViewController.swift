//
//  HobbiesViewController.swift
//  GuilhermeBisotto
//
//  Created by Guilherme Moresco Bisotto on 4/17/15.
//  Copyright (c) 2015 GuilhermeBisotto. All rights reserved.
//

import Foundation
import UIKit

class HobbiesViewController: UIViewController {
    
    @IBOutlet weak var sports: UIImageView!
    @IBOutlet weak var videogame: UIImageView!
    @IBOutlet weak var movie: UIImageView!
    @IBOutlet weak var food: UIImageView!
    @IBOutlet weak var sleep: UIImageView!
    @IBOutlet weak var shower: UIImageView!
    @IBOutlet weak var imgViewBackground: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var pageTitle: LabelGlow!
    
    //MARK - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addEffectOfTransparency()
        
        // setup 2D transitions for animations
        let offstageLeft = CGAffineTransformMakeTranslation(-150, 0)
        let offstageRight = CGAffineTransformMakeTranslation(150, 0)
        
        sports.alpha = 0.0
        videogame.alpha = 0.0
        movie.alpha = 0.0
        food.alpha = 0.0
        sleep.alpha = 0.0
        shower.alpha = 0.0
        pageTitle.alpha = 0.0
        closeButton.alpha = 0.0
        
        // prepare menu items to slide in
        sports.transform = offstageLeft
        videogame.transform = offstageLeft
        movie.transform = offstageLeft
        food.transform = offstageRight
        sleep.transform = offstageRight
        shower.transform = offstageRight
    }

    
    override func viewDidAppear(animated: Bool) {
        var blur:UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        var effectView:UIVisualEffectView = UIVisualEffectView (effect: blur)
        effectView.frame = self.imgViewBackground.frame
        
        
        UIView.animateWithDuration(0.0, delay: 0.0, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
            self.imgViewBackground.addSubview(effectView)
            }, completion: { finish in
                UIView.animateWithDuration(0.3, delay: 0.3, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
                        UIView.animateWithDuration(0.5, animations: { () -> Void in
                        
                            self.sports.alpha = 1.0
                            self.videogame.alpha = 1.0
                            self.movie.alpha = 1.0
                            self.food.alpha = 1.0
                            self.sleep.alpha = 1.0
                            self.shower.alpha = 1.0
                            self.pageTitle.alpha = 1.0
                            self.closeButton.alpha = 1.0
                            
                            self.sports.transform = CGAffineTransformIdentity
                            self.videogame.transform = CGAffineTransformIdentity
                            self.movie.transform = CGAffineTransformIdentity
                            self.food.transform = CGAffineTransformIdentity
                            self.sleep.transform = CGAffineTransformIdentity
                            self.shower.transform = CGAffineTransformIdentity
                        
                            self.addGlow(self.sports)
                            self.addGlow(self.videogame)
                            self.addGlow(self.movie)
                            self.addGlow(self.food)
                            self.addGlow(self.sleep)
                            self.addGlow(self.shower)
                        
                        })
                    }, completion: nil)
        })
    }
    
    //MARK: - Layout Adjustments
    func addGlow(img: UIImageView) {
        var color: UIColor = UIColor.whiteColor()
        
        img.layer.shadowColor = color.CGColor
        img.layer.shadowRadius = 2.0
        img.layer.shadowOpacity = 0.8
        img.layer.shadowOffset = CGSizeZero
        img.layer.masksToBounds = false;
    }
    
    func addEffectOfTransparency() {
        view.backgroundColor = UIColor(red:0.0, green:0.0,blue:0.0,alpha:0.0)
    }
    
    //MARK: - Actions
    @IBAction func closeModal(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
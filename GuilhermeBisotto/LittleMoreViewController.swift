//
//  LittleMoreViewController.swift
//  GuilhermeBisotto
//
//  Created by Guilherme Moresco Bisotto on 4/23/15.
//  Copyright (c) 2015 GuilhermeBisotto. All rights reserved.
//

import Foundation
import UIKit

class LittleMoreViewController: UIViewController {
    
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var pageTitle: LabelGlow!
    @IBOutlet weak var closeButton: UIButton!
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addEffectOfTransparency()
        addGlow()
        
        textView.alpha = 0.0
        facebookButton.alpha = 0.0
        pageTitle.alpha = 0.0
        closeButton.alpha = 0.0
    }
    
    //MARK: - Layout Adjustments
    func addGlow() {
        
        facebookButton.layer.shadowColor = UIColor(red: 0.0, green: 123.0, blue: 182.0, alpha: 1.0).CGColor
        facebookButton.layer.shadowRadius = 4.0
        facebookButton.layer.shadowOpacity = 1.0
        facebookButton.layer.shadowOffset = CGSizeZero
        facebookButton.layer.masksToBounds = false;
    }
    
    override func viewDidAppear(animated: Bool) {
        var blur:UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        var effectView:UIVisualEffectView = UIVisualEffectView (effect: blur)
        effectView.frame = self.imgBackground.frame
        
        
        UIView.animateWithDuration(0.0, delay: 0.0, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
            self.imgBackground.addSubview(effectView)
            
            }, completion: { finish in
                UIView.animateWithDuration(0.3, delay: 0.3, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
                        self.textView.alpha = 1.0
                        self.facebookButton.alpha = 1.0
                        self.pageTitle.alpha = 1.0
                        self.closeButton.alpha = 1.0
                    }, completion: nil)
        })
    }
    
    //MARK: - Layout Adjustments
    func addEffectOfTransparency() {
        view.backgroundColor = UIColor(red:0.0, green:0.0,blue:0.0,alpha:0.0)
    }
    
    //MARK: - Actions
    @IBAction func closeModal(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func openFacebook(sender: AnyObject) {
        var url: NSURL = NSURL(string: "https://www.facebook.com/guilherme.bisotto")!
        UIApplication.sharedApplication().openURL(url)
    }
}

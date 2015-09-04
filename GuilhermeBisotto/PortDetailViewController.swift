//
//  PortDetailViewController.swift
//  GuilhermeBisotto
//
//  Created by Guilherme Moresco Bisotto on 4/18/15.
//  Copyright (c) 2015 GuilhermeBisotto. All rights reserved.
//

import Foundation
import UIKit

class PortDetailViewController: UIViewController {
    
    @IBOutlet weak var imgViewBackground: UIImageView!
    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var appIcon: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var playDemo: UIButton!
    @IBOutlet weak var function: UILabel!
    
    //MARK: - Variables
    var app: App!
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        addEffectOfTransparency()
        appTitle.text = app.name
        appIcon.image = UIImage(named: app.appIcon)
        textView.text = ""
        textView.text = app.desc
        function.text = app.function
        
        playDemo.layer.borderColor = UIColor.whiteColor().CGColor
        playDemo.layer.borderWidth = 2
        playDemo.layer.cornerRadius = 15
        playDemo.layer.masksToBounds = true;
        
        appIcon.layer.cornerRadius = appIcon.bounds.width/4
        appIcon.layer.masksToBounds = true
        
        textView.contentOffset = CGPointMake(0, -220)
        
        addGlow()
        
        appTitle.alpha = 0.0
        appIcon.alpha = 0.0
        textView.alpha = 0.0
        playDemo.alpha = 0.0
        function.alpha = 0.0
    }
    
    //MARK: - Layout Adjustments
    func addGlow() {
        var color: UIColor = UIColor.whiteColor()
        
        playDemo.layer.shadowColor = color.CGColor
        playDemo.layer.shadowRadius = 4.0
        playDemo.layer.shadowOpacity = 1.0
        playDemo.layer.shadowOffset = CGSizeZero
        playDemo.layer.masksToBounds = false;
    }
    
    override func viewDidAppear(animated: Bool) {
        var blur:UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        var effectView:UIVisualEffectView = UIVisualEffectView (effect: blur)
        effectView.frame = self.imgViewBackground.frame
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.imgViewBackground.addSubview(effectView)
            self.showComponents()
        })
        
    }
    
    func showComponents() {
        appTitle.alpha = 1.0
        appIcon.alpha = 1.0
        textView.alpha = 1.0
        playDemo.alpha = 1.0
        function.alpha = 1.0
    }
    
    func addEffectOfTransparency() {
        view.backgroundColor = UIColor(red:0.0, green:0.0,blue:0.0,alpha:0.0)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "gotoVideo") {
            let destinationVC = segue.destinationViewController as! VideoViewController
            destinationVC.videoName = app.name
            destinationVC.videoType = app.videoType
        }
    }
    
    //MARK: - Actions
    @IBAction func closeView(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
//
//  AboutViewController.swift
//  GuilhermeBisotto
//
//  Created by Guilherme Moresco Bisotto on 4/17/15.
//  Copyright (c) 2015 GuilhermeBisotto. All rights reserved.
//

import Foundation
import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var titlePage: UILabel!
    @IBOutlet weak var githubButton: UIButton!
    @IBOutlet weak var linkedinButton: UIButton!
    @IBOutlet weak var leftSpace: NSLayoutConstraint!
    @IBOutlet weak var rightSpace: NSLayoutConstraint!
    @IBOutlet weak var CenterInView: NSLayoutConstraint!
    @IBOutlet weak var profileImgOne: UIImageView!
    @IBOutlet weak var profileImgTwo: UIImageView!
    @IBOutlet weak var profileImgThree: UIImageView!
    @IBOutlet weak var imgViewBackground: UIImageView!
    @IBOutlet weak var swipeContainerRecognizer: UIView!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var littleMoreButton: UIButton!
    @IBOutlet weak var myName: LabelGlow!
    @IBOutlet weak var myBirthday: LabelGlow!
    @IBOutlet weak var myLocation: LabelGlow!
    @IBOutlet weak var myWork: LabelGlow!
    @IBOutlet weak var divView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    
    //MARK: - Variables
    var profileImgs = []
    var leftSwipe: UISwipeGestureRecognizer!
    var rightSwipe: UISwipeGestureRecognizer!
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set layout adjustments
        addEffectOfTransparency()
        addGlow()
        parallax()
        configureImgs(profileImgOne)
        configureImgs(profileImgTwo)
        configureImgs(profileImgThree)
        
        emailButton.layer.cornerRadius = 10
        emailButton.layer.borderColor = UIColor.whiteColor().CGColor
        emailButton.layer.borderWidth = 2
        
        profileImgOne.layer.zPosition = 100
        profileImgTwo.layer.zPosition = 10
        profileImgThree.layer.zPosition = 5
        
        //Gestures configuration
        leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector("showImage:"))
        
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        
        swipeContainerRecognizer.addGestureRecognizer(leftSwipe)
        swipeContainerRecognizer.addGestureRecognizer(rightSwipe)
        swipeContainerRecognizer.addGestureRecognizer(tapGesture)
        
        githubButton.alpha = 0.0
        linkedinButton.alpha = 0.0
        profileImgOne.alpha = 0.0
        profileImgTwo.alpha = 0.0
        profileImgThree.alpha = 0.0
        emailButton.alpha = 0.0
        littleMoreButton.alpha = 0.0
        myName.alpha = 0.0
        myBirthday.alpha = 0.0
        myLocation.alpha = 0.0
        myWork.alpha = 0.0
        divView.alpha = 0.0
        titlePage.alpha = 0.0
        closeButton.alpha = 0.0
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        profileImgs = [profileImgOne,profileImgTwo, profileImgThree]
    }
    
    override func viewDidAppear(animated: Bool) {
        var blur:UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        var effectView:UIVisualEffectView = UIVisualEffectView (effect: blur)
         effectView.frame = self.imgViewBackground.frame
        
        
        UIView.animateWithDuration(0.0, delay: 0.0, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
           self.imgViewBackground.addSubview(effectView)
            
            }, completion: { finish in
                UIView.animateWithDuration(0.3, delay: 0.3, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
                        self.githubButton.alpha = 1.0
                        self.linkedinButton.alpha = 1.0
                        self.profileImgOne.alpha = 1.0
                        self.profileImgTwo.alpha = 1.0
                        self.profileImgThree.alpha = 1.0
                        self.emailButton.alpha = 1.0
                        self.littleMoreButton.alpha = 1.0
                        self.myName.alpha = 1.0
                        self.myBirthday.alpha = 1.0
                        self.myLocation.alpha = 1.0
                        self.myWork.alpha = 1.0
                        self.divView.alpha = 1.0
                        self.titlePage.alpha = 1.0
                        self.closeButton.alpha = 1.0
                    }, completion: { finish in
                        self.sortImages(true)
                })
        })
    }
    
    //MARK: - Layout Adjustments
    func addGlow() {
        
        linkedinButton.layer.shadowColor = UIColor(red: 0.0, green: 123.0, blue: 182.0, alpha: 1.0).CGColor
        linkedinButton.layer.shadowRadius = 4.0
        linkedinButton.layer.shadowOpacity = 1.0
        linkedinButton.layer.shadowOffset = CGSizeZero
        linkedinButton.layer.masksToBounds = false;
        
        githubButton.layer.shadowColor = UIColor(red: 98.0, green: 227.0, blue: 255.0, alpha: 1.0).CGColor
        githubButton.layer.shadowRadius = 4.0
        githubButton.layer.shadowOpacity = 1.0
        githubButton.layer.shadowOffset = CGSizeZero
        githubButton.layer.masksToBounds = false;
        
        emailButton.layer.shadowColor = UIColor.whiteColor().CGColor
        emailButton.layer.shadowRadius = 4.0
        emailButton.layer.shadowOpacity = 1.0
        emailButton.layer.shadowOffset = CGSizeZero
        emailButton.layer.masksToBounds = false;
        
        littleMoreButton.layer.shadowColor = UIColor.whiteColor().CGColor
        littleMoreButton.layer.shadowRadius = 4.0
        littleMoreButton.layer.shadowOpacity = 1.0
        littleMoreButton.layer.shadowOffset = CGSizeZero
        littleMoreButton.layer.masksToBounds = false;
    }
    
    func configureImgs(img: UIImageView) {
        img.layer.borderColor = UIColor.whiteColor().CGColor
        img.layer.borderWidth = 2
        img.layer.cornerRadius = img.bounds.size.width/2
        img.layer.masksToBounds = true;
    }
    
    //PARALLAX
    func parallax() {
        
        // Set vertical effect
        let verticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y",
            type: .TiltAlongVerticalAxis)
        verticalMotionEffect.minimumRelativeValue = -20
        verticalMotionEffect.maximumRelativeValue = 20
        
        // Set horizontal effect
        let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x",
            type: .TiltAlongHorizontalAxis)
        horizontalMotionEffect.minimumRelativeValue = -20
        horizontalMotionEffect.maximumRelativeValue = 20
        
        // Create parallaxGroup to combine both
        let parallaxGroup = UIMotionEffectGroup()
        parallaxGroup.motionEffects = [horizontalMotionEffect, verticalMotionEffect]
        
        // Add both effects to your view
        profileImgOne.addMotionEffect(parallaxGroup)
        profileImgTwo.addMotionEffect(parallaxGroup)
        profileImgThree.addMotionEffect(parallaxGroup)
    }
    
    func addEffectOfTransparency() {
        view.backgroundColor = UIColor(red:0.0, green:0.0,blue:0.0,alpha:0.0)
    }
    
    //MARK: - Gestures
    func handleSwipes(sender:UISwipeGestureRecognizer) {
        
        leftSwipe.enabled = false
        rightSwipe.enabled = false
        
        if (sender.direction == .Left) { sortImages(true) }
        
        if (sender.direction == .Right) { sortImages(false) }
    }
    
    //MARK: sort images
    func sortImages(direction: Bool) {
        
        var principalImg: UIImageView = self.profileImgs[0] as! UIImageView
        var secondImg: UIImageView = self.profileImgs[1] as! UIImageView
        var lastImg: UIImageView = self.profileImgs[2] as! UIImageView
        
        var positionOne = principalImg.frame.origin
        var positionTwo = secondImg.frame.origin
        var positionThree = lastImg.frame.origin
        
        var duration: NSTimeInterval = 0.5
        
        UIView.animateWithDuration(duration, animations: { () -> Void in
            
            if direction {
            
                secondImg.frame.origin = positionOne
                secondImg.layer.zPosition = 100
            
                principalImg.frame.origin = positionThree
                principalImg.layer.zPosition = 10
            
                lastImg.frame.origin = positionTwo
                lastImg.layer.zPosition = 5
                
            } else {
               
                secondImg.frame.origin = positionThree
                secondImg.layer.zPosition = 5
                
                principalImg.frame.origin = positionTwo
                principalImg.layer.zPosition = 10
                
                lastImg.frame.origin = positionOne
                lastImg.layer.zPosition = 100
                
            }
            
            }, completion:{ finish in
                
                if direction {
                   
                    lastImg.layer.zPosition = 10
                    principalImg.layer.zPosition = 5

                    self.profileImgs = [secondImg, lastImg, principalImg]
                    self.leftSwipe.enabled = true
                    self.rightSwipe.enabled = true
                    
                } else {
                    
                    self.profileImgs = [lastImg, principalImg, secondImg]
                    self.leftSwipe.enabled = true
                    self.rightSwipe.enabled = true
                    
                }
            })
    }
    
    //MARK: - Actions
    func showImage(sender: UITapGestureRecognizer) {
        
        let modalView = storyboard?.instantiateViewControllerWithIdentifier("photoDetail") as! ShowImage
        modalView.modalPresentationCapturesStatusBarAppearance = true
        modalView.modalInPopover = true
        modalView.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
        modalView.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        modalView.image = profileImgs[0] as! UIImageView
        presentViewController(modalView, animated: true, completion: nil)
    }
    
    @IBAction func closeModal(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func openLinkedin(sender: AnyObject) {
        var url: NSURL = NSURL(string: "http://br.linkedin.com/in/guilhermebisotto")!
        UIApplication.sharedApplication().openURL(url)
    }
    
    @IBAction func openGithub(sender: AnyObject) {
        var url: NSURL = NSURL(string: "https://github.com/GuilhermeMBisotto")!
        UIApplication.sharedApplication().openURL(url)
    }
    
    @IBAction func launchEmail(sender: AnyObject) {
        let email = "guibisotto@gmail.com"
        let url = NSURL(string: "mailto:\(email)")
        UIApplication.sharedApplication().openURL(url!)
    }
    
    @IBAction func showALittleMore(sender: AnyObject) {
        let modalView = storyboard?.instantiateViewControllerWithIdentifier("LittleMore") as! LittleMoreViewController
        modalView.modalPresentationCapturesStatusBarAppearance = true
        modalView.modalInPopover = true
        modalView.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
        modalView.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        presentViewController(modalView, animated: true, completion: nil)
    }
    
}

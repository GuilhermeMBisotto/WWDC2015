//
//  TechSkillsViewController.swift
//  GuilhermeBisotto
//
//  Created by Guilherme Moresco Bisotto on 4/17/15.
//  Copyright (c) 2015 GuilhermeBisotto. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class TechSkillsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imgViewBackground: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var pageTitle: LabelGlow!

    //MARK: - Variables
    var skills = [NSManagedObject]()
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addEffectOfTransparency()
        collectionView.layer.borderColor = UIColor.whiteColor().CGColor
        collectionView.layer.cornerRadius = 20
        collectionView.layer.borderWidth = 2
        collectionView.layer.masksToBounds = true;
        collectionView.alpha = 0.0
        pageTitle.alpha = 0.0
        closeButton.alpha = 0.0
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let fetchRequest = NSFetchRequest(entityName:"Skill")
        
        var error: NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as! [Skill]?
        
        if let results = fetchedResults {
            skills = results
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        var blur:UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        var effectView:UIVisualEffectView = UIVisualEffectView (effect: blur)
        effectView.frame = self.imgViewBackground.frame
        
        
        UIView.animateWithDuration(0.0, delay: 0.0, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
            self.imgViewBackground.addSubview(effectView)
            }, completion: { finish in
                UIView.animateWithDuration(0.3, delay: 0.3, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
                        self.collectionView.alpha = 1.0
                        self.pageTitle.alpha = 1.0
                        self.closeButton.alpha = 1.0
                    }, completion: nil)
        })
    }
    
    //MARK: - Layout Adjustments
    func addEffectOfTransparency() {
        view.backgroundColor = UIColor(red:0.0, green:0.0,blue:0.0,alpha:0.0)
    }
    
    //MARK: UICollectionDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return skills.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("TechSkillsItem", forIndexPath: indexPath) as! UICollectionViewCell
        let skill = skills[indexPath.row] as! Skill
        
        var title : UILabel? = cell.viewWithTag(100) as? UILabel
        
        title?.text = skill.skillName

        cell.layer.shadowColor = UIColor.whiteColor().CGColor
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.shadowOffset = CGSizeZero
        cell.layer.masksToBounds = false;
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!,
        sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize
    {
        let skill = skills[indexPath.row] as! Skill
        let element = skill.skillName
        let stringSize = element.sizeWithAttributes([NSFontAttributeName: UIFont.systemFontOfSize(20.0)])
        return CGSize(width: stringSize.width, height: stringSize.height + stringSize.height/2)
    }
    
    //MARK: - Actions
    @IBAction func closeModal(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}

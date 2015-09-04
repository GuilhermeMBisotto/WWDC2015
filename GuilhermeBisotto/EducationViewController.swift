//
//  EducationViewController.swift
//  GuilhermeBisotto
//
//  Created by Guilherme Moresco Bisotto on 4/16/15.
//  Copyright (c) 2015 GuilhermeBisotto. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class EducationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var imgViewBackground: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var pageTitle: LabelGlow!
    
    //MARK: - Variables
    var institutions = [NSManagedObject]()

    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addEffectOfTransparency()
        tableView.alpha = 0.0
        closeButton.alpha = 0.0
        pageTitle.alpha = 0.0
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let fetchRequest = NSFetchRequest(entityName:"Institution")
        
        var error: NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as! [App]?
        
        if let results = fetchedResults {
            institutions = results
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        var blur:UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        var effectView:UIVisualEffectView = UIVisualEffectView (effect: blur)
        
        
        UIView.animateWithDuration(0.0, delay: 0.0, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
            effectView.frame = self.imgViewBackground.frame

            }, completion: { finish in
                UIView.animateWithDuration(0.3, delay: 0.3, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
                    self.imgViewBackground.addSubview(effectView)

                        self.tableView.alpha = 1.0
                        self.closeButton.alpha = 1.0
                        self.pageTitle.alpha = 1.0
                    }, completion: nil)
        })
    }
    
    //MARK: - Layout Adjustments
    func addEffectOfTransparency() {
        view.backgroundColor = UIColor(red:0.0, green:0.0,blue:0.0,alpha:0.0)
    }
    
    //MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return institutions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("InstitutionCell", forIndexPath: indexPath) as! EduCustomTableViewCell
        let inst = institutions[indexPath.row] as! Institution
        
        cell.instName.text = inst.instName
        cell.info.text = inst.info
        cell.period.text = inst.period
                
        return cell
    }
    
    //MARK: - Actions
    @IBAction func closeModal(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}

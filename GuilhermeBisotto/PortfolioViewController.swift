//
//  PortfolioViewController.swift
//  GuilhermeBisotto
//
//  Created by Guilherme Moresco Bisotto on 4/17/15.
//  Copyright (c) 2015 GuilhermeBisotto. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class PortfolioViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imgViewBackground: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var pageTitle: LabelGlow!
    
    //MARK: - Variables
    var apps = [NSManagedObject]()
    
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
        let fetchRequest = NSFetchRequest(entityName:"App")
        
        var error: NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as! [App]?
        
        if let results = fetchedResults {
            apps = results
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
                        self.tableView.alpha = 1.0
                        self.pageTitle.alpha = 1.0
                        self.closeButton.alpha = 1.0
                    }, completion: nil)
        })
    }
    
    //MARK: - Layout Adjustments
    func addEffectOfTransparency() {
        view.backgroundColor = UIColor(red:0.0, green:0.0,blue:0.0,alpha:0.0)
    }
    
    //MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apps.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("PortCell", forIndexPath: indexPath) as! PortCustomTableViewCell
        let app = apps[indexPath.row] as! App
        
        var imgName = app.appIcon
        
        cell.imagePort.image = UIImage(named: imgName)
        cell.imagePort.layer.cornerRadius = cell.imagePort.bounds.width/4
        cell.imagePort.layer.masksToBounds = true

        cell.namePort.text = app.name
                
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("PortDetail", sender: indexPath)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "PortDetail") {
            let row = sender.row
            let destinationVC = segue.destinationViewController as! PortDetailViewController
            destinationVC.app = apps[row] as! App
        }
    }
    
    //MARK: - Actions
    @IBAction func closeModal(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
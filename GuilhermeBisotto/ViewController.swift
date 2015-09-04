//
//  ViewController.swift
//  GuilhermeBisotto
//
//  Created by Guilherme Moresco Bisotto on 4/14/15.
//  Copyright (c) 2015 GuilhermeBisotto. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UIPageViewControllerDataSource {

    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var containerPageController: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    //MARK: - Variables
    private var pageViewController: UIPageViewController?
    
    private let contentImages = ["Portfolio.png",
        "Education.png",
        "Professional experiences.png",
        "Tech skills.png",
        "Hobbies",
        "About me.png"]
    
    private let animationSquareImages = ["retangle-pink",
        "retangle-orange",
        "retangle-aqua",
        "retangle-purple",
        "retangle-light-purple",
        "retangle-light-orange",
        "retangle-red",
        "retangle-blue"]
    
    private let animationCircleImages = ["circle-blue",
        "circle-pink",
        "circle-orange",
        "circle-aqua",
        "circle-purple",
        "circle-light-purple",
        "circle-light-orange",
        "circle-red"]
    
    private var apps = []
    private var companies = []
    private var skills = []
    private var institutions = []
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apps = loadJson("apps")
        companies = loadJson("companies")
        skills = loadJson("skills")
        institutions = loadJson("institutions")
        
        
        //If first launch, setting NSUserDefault and CoreData.
        let firstLaunch = NSUserDefaults.standardUserDefaults().boolForKey("FirstLaunch")
        if !firstLaunch  {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "FirstLaunch")
            saveApps()
            saveCompanies()
            saveSkills()
            saveInstitutions()
            
            nameLabel.layer.zPosition = 100
            profileImage.layer.zPosition = 110
        }

        // Setting layout and PageController
        layoutAdjusts()
        createPageViewController()
        setupPageControl()
        parallax()

        //Timers for animations
        var timerSquareAnimation = NSTimer.scheduledTimerWithTimeInterval(0.8, target: self, selector: Selector("createSquare"), userInfo: nil, repeats: true)
        var timerCircleAnimation = NSTimer.scheduledTimerWithTimeInterval(1.2, target: self, selector: Selector("createCircle"), userInfo: nil, repeats: true)
        
        //Prevent timer does not stop when scrolling PageControl
        NSRunLoop.currentRunLoop().addTimer(timerSquareAnimation, forMode: NSRunLoopCommonModes)
        NSRunLoop.currentRunLoop().addTimer(timerCircleAnimation, forMode: NSRunLoopCommonModes)
    }
    
    //MARK: - Layout Adjustments
    func layoutAdjusts() {
        profileImage.layer.borderColor = UIColor.whiteColor().CGColor
        profileImage.layer.borderWidth = 2
        profileImage.layer.cornerRadius = profileImage.bounds.size.width/2
        profileImage.layer.masksToBounds = true;
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
        profileImage.addMotionEffect(parallaxGroup)
        containerPageController.addMotionEffect(parallaxGroup)
        nameLabel.addMotionEffect(parallaxGroup)
        
    }
    
    //MARK: - Animations
    func createSquare() {

        var coloredSquare = UIView()
        let duration = 5.0
        let delay = 0.0
        let damping = 1.0
        let options = UIViewAnimationOptions.CurveLinear
        let velocity = 1.0
        let size : CGFloat = CGFloat( arc4random_uniform(40))+20
        let yPosition : CGFloat = CGFloat( arc4random_uniform((UInt32(view.bounds.size.height/15))))+20
        let sortColor : CGFloat = CGFloat( arc4random()%8 )
        
        coloredSquare.frame = CGRect(x: 0, y: yPosition, width: size, height: size)
        coloredSquare.layer.zPosition = 1.0
        
        let img = UIImageView()
        img.image = UIImage(named: animationSquareImages[Int(sortColor)])
        img.frame = CGRectMake(0-size, yPosition, size, size)
        coloredSquare.addSubview(img)
        
        background.addSubview(coloredSquare)
        UIView.animateWithDuration(duration, delay: delay, options: options, animations: {
            coloredSquare.frame = CGRect(x: (self.view.frame.width + (self.view.frame.width/5)), y: yPosition, width: size, height: size)
        }, completion: { animationFinished in
            coloredSquare.removeFromSuperview()
        })
    }
    
    func createCircle() {
        
        var coloredCircle = UIView()
        let duration = 3.0
        let delay = 0.0
        let damping = 1.0
        let options = UIViewAnimationOptions.CurveLinear
        let velocity = 1.0
        let size : CGFloat = CGFloat( arc4random_uniform(40))+20
        let yPosition : CGFloat = CGFloat( arc4random_uniform((UInt32(view.bounds.size.height/14))))+20
        let sortColor : CGFloat = CGFloat( arc4random()%8 )
        
        coloredCircle.frame = CGRect(x: 0, y: yPosition, width: size, height: size)

        let img = UIImageView()
        img.image = UIImage(named: animationCircleImages[Int(sortColor)])
        img.frame = CGRectMake(0-size, yPosition, size, size)
        coloredCircle.addSubview(img)
        coloredCircle.layer.zPosition = 1
        
        background.addSubview(coloredCircle)
        UIView.animateWithDuration(duration, delay: delay, options: options, animations: {
            coloredCircle.frame = CGRect(x: (self.view.frame.width + (self.view.frame.width/5)), y: yPosition, width: size, height: size)
            }, completion: { animationFinished in
                coloredCircle.removeFromSuperview()
        })
    }
    
    //MARK: - PageController
    private func createPageViewController() {
        
        let pageController = self.storyboard!.instantiateViewControllerWithIdentifier("PageController") as! UIPageViewController
        pageController.dataSource = self
        
        if contentImages.count > 0 {
            let firstController = getItemController(0)!
            let startingViewControllers: NSArray = [firstController]
            pageController.setViewControllers(startingViewControllers as [AnyObject], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        }
        
        pageViewController = pageController
        addChildViewController(pageViewController!)
        containerPageController.addSubview(pageViewController!.view)
        pageViewController?.view.frame = containerPageController.bounds
        pageViewController!.didMoveToParentViewController(self)
    }
    
    private func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.lightGrayColor()
        appearance.currentPageIndicatorTintColor = UIColor.whiteColor()
        appearance.backgroundColor = UIColor.clearColor()
    }
    
    //MARK: - UIPageViewControllerDataSource
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! PageItemController
        var index = itemController.indexItem
        
        if index == 0 || index == NSNotFound {
            index = contentImages.count
        }
        
        index--
        
        return getItemController(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! PageItemController
        var index = itemController.indexItem
        
        if index == NSNotFound {
            return nil;
        }
        
        index++
        
        if index == contentImages.count {
            index = 0
        }
        
        return getItemController(index)
    }
    
    private func getItemController(indexItem: Int) -> PageItemController? {
        
        if indexItem < contentImages.count {
            let pageItemController = self.storyboard!.instantiateViewControllerWithIdentifier("ItemController") as! PageItemController
            pageItemController.indexItem = indexItem
            pageItemController.imageName = contentImages[indexItem]
            return pageItemController
        }
        
        return nil
    }
    
    //MARK: - Page Indicator
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return contentImages.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    //MARK: - Core Data
    //Save apps objects in CoreData to use in app
    func saveApps() {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        var error: NSError?

        for app in apps {
            var appItem : App = NSEntityDescription.insertNewObjectForEntityForName("App", inManagedObjectContext: managedContext) as! App
            appItem.name = app.valueForKey("appName") as! String!
            appItem.appIcon = app.valueForKey("appIcon") as! String!
            appItem.videoType = app.valueForKey("videoType") as! String!
            appItem.appID = app.valueForKey("appID") as! NSNumber!
            appItem.desc = app.valueForKey("appDesc") as! String!
            appItem.function = app.valueForKey("function") as! String!
            
            if !managedContext.save(&error) {
                println("Could not save \(error), \(error?.userInfo)")
            }
        }
    }
    
    //Save companies objects in CoreData to use in app
    func saveCompanies() {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        var error: NSError?
        
        for company in companies {
            var companyItem : Company = NSEntityDescription.insertNewObjectForEntityForName("Company", inManagedObjectContext: managedContext) as! Company
            companyItem.companyName = company.valueForKey("companyName") as! String!
            companyItem.companyID = company.valueForKey("companyID") as! NSNumber!
            companyItem.timeInCompany = company.valueForKey("timeInCompany") as! String!
            companyItem.function = company.valueForKey("function") as! String!
            companyItem.desc = company.valueForKey("desc") as! String!
            
            if !managedContext.save(&error) {
                println("Could not save \(error), \(error?.userInfo)")
            }
        }
    }
    
    //Save companies objects in CoreData to use in app
    func saveSkills() {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        var error: NSError?
        
        for skill in skills {
            var skillItem : Skill = NSEntityDescription.insertNewObjectForEntityForName("Skill", inManagedObjectContext: managedContext) as! Skill
            skillItem.skillName = skill.valueForKey("skillName") as! String!
            
            if !managedContext.save(&error) {
                println("Could not save \(error), \(error?.userInfo)")
            }
        }
    }
    
    //Save institutions objects in CoreData to use in app
    func saveInstitutions() {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        var error: NSError?
        
        for inst in institutions {
            var instItem : Institution = NSEntityDescription.insertNewObjectForEntityForName("Institution", inManagedObjectContext: managedContext) as! Institution
            instItem.instName = inst.valueForKey("InstName") as! String!
            instItem.info = inst.valueForKey("Info") as! String!
            instItem.period = inst.valueForKey("Period") as! String!
            
            if !managedContext.save(&error) {
                println("Could not save \(error), \(error?.userInfo)")
            }
        }
    }
    
    //MARK: - JSON
    func loadJson(jsonFileName: String) -> NSArray {
        
        if let path = NSBundle.mainBundle().pathForResource(jsonFileName, ofType: "json") {
            var url :NSURL = NSURL.fileURLWithPath(path)!
            if let data = NSData(contentsOfURL: url) {
                return NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as! NSArray
            }
        }
        return []
    }

}


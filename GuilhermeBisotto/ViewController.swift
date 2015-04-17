//
//  ViewController.swift
//  GuilhermeBisotto
//
//  Created by Guilherme Moresco Bisotto on 4/14/15.
//  Copyright (c) 2015 GuilhermeBisotto. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var photoBackgroud: UIImageView!
    @IBOutlet weak var containerPageController: UIView!
    
    // MARK: - Variables
    private var pageViewController: UIPageViewController?
    
    // Initialize it right away here
    private let contentImages = ["Portfolio.png",
        "Education.png",
        "Professional experiences.png",
        "Tech skills.png",
        "Hobbies",
        "About me.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.layer.borderColor = UIColor.whiteColor().CGColor
        profileImage.layer.borderWidth = 2
        profileImage.layer.cornerRadius = profileImage.bounds.size.width/2
        profileImage.layer.masksToBounds = true;
        
        createPageViewController()
        setupPageControl()
        
        var blur:UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        var effectView:UIVisualEffectView = UIVisualEffectView (effect: blur)
        effectView.frame = photoBackgroud.frame
        photoBackgroud.addSubview(effectView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
        appearance.pageIndicatorTintColor = UIColor.grayColor()
        appearance.currentPageIndicatorTintColor = UIColor.whiteColor()
        appearance.backgroundColor = UIColor.clearColor()
    }
    
    // MARK: - UIPageViewControllerDataSource
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! PageItemController
        var index = itemController.indexItem
        
        if index == 0 || index == NSNotFound {
            index = contentImages.count
        }
        
        index--;
        
        return getItemController(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! PageItemController
        var index = itemController.indexItem
        
        if index == NSNotFound {
            return nil;
        }
        
        index++;
        
        if index == contentImages.count {
            index = 0;
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
    
    // MARK: - Page Indicator
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return contentImages.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}


//
//  PageItemController.swift
//  GuilhermeBisotto
//
//  Created by Guilherme Moresco Bisotto on 4/16/15.
//  Copyright (c) 2015 GuilhermeBisotto. All rights reserved.
//

import Foundation
import UIKit

class PageItemController: UIViewController {
    @IBOutlet weak var itemTitle: UILabel!
    
    @IBOutlet var contentImageView: UIImageView?
    @IBOutlet weak var buttonId: UIButton!
    
    // MARK: - Variables
    
    var indexItem : Int = 0;
    var nameImage: String = ""
    
    var imageName: String = "" {
        
        didSet {
            
            if let imageView = contentImageView {
                imageView.image = UIImage(named: imageName)                
            }
            
        }
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentImageView!.image = UIImage(named: imageName)
        let aString: String = imageName
        let newString = aString.stringByReplacingOccurrencesOfString(".png", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        itemTitle.text = newString
        
        addGlowInLabel(itemTitle)
    }
    
    func addGlowInLabel(label: UILabel) {
        var color: UIColor = label.textColor
        
        label.layer.shadowColor = color.CGColor
        label.layer.shadowRadius = 4.0
        label.layer.shadowOpacity = 1.0
        label.layer.shadowOffset = CGSizeZero
        label.layer.masksToBounds = false;
    }
    
    @IBAction func tapRecognizer(sender: AnyObject) {
        
        var modalView: UIViewController?
        
        switch indexItem {
        case 0:
            modalView = storyboard?.instantiateViewControllerWithIdentifier("PortfolioViewController") as! PortfolioViewController
            break
        case 1:
            modalView = storyboard?.instantiateViewControllerWithIdentifier("EducationViewController") as! EducationViewController
            break
        case 2:
            modalView = storyboard?.instantiateViewControllerWithIdentifier("ProfExpViewController") as! ProfExpViewController
            break
        case 3:
            modalView = storyboard?.instantiateViewControllerWithIdentifier("TechSkillsViewController") as! TechSkillsViewController
            break
        case 4:
            modalView = storyboard?.instantiateViewControllerWithIdentifier("HobbiesViewController") as! HobbiesViewController
            break
        case 5:
            modalView = storyboard?.instantiateViewControllerWithIdentifier("AboutViewController") as! AboutViewController
            break
        default:
            break
        }
        
        modalView!.modalPresentationCapturesStatusBarAppearance = true
        modalView!.modalInPopover = true
        modalView!.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
        modalView!.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        presentViewController(modalView!, animated: true, completion: nil)
    }
}
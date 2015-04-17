//
//  PortfolioViewController.swift
//  GuilhermeBisotto
//
//  Created by Guilherme Moresco Bisotto on 4/17/15.
//  Copyright (c) 2015 GuilhermeBisotto. All rights reserved.
//

import Foundation
import UIKit

class PortfolioViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imgViewBackground: UIImageView!
    
    @IBAction func closeModal(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    private let contentImages = ["Aproximar.png",
        "Boom Balloon.png",
        "Ball Legacy.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addEffectOfTransparency()
    }
    
    func addEffectOfTransparency() {
        view.backgroundColor = UIColor(red:0.0, green:0.0,blue:0.0,alpha:0.0)
        var blur:UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        var effectView:UIVisualEffectView = UIVisualEffectView (effect: blur)
        effectView.frame = imgViewBackground.frame
        imgViewBackground.addSubview(effectView)
    }
    
    func addGlowInLabel(label: UILabel) {
        var color: UIColor = label.textColor
        
        label.layer.shadowColor = color.CGColor
        label.layer.shadowRadius = 4.0
        label.layer.shadowOpacity = 1.0
        label.layer.shadowOffset = CGSizeZero
        label.layer.masksToBounds = false;
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentImages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("PortCell", forIndexPath: indexPath) as! PortCustomTableViewCell
        
        var imgName = contentImages[indexPath.row] as String
        
        cell.imagePort.image = UIImage(named: imgName)
        cell.imagePort.layer.cornerRadius = cell.imagePort.bounds.width/4
        cell.imagePort.layer.masksToBounds = true
        
        let newString = imgName.stringByReplacingOccurrencesOfString(".png", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
        cell.namePort.text = newString
        addGlowInLabel(cell.namePort)
                
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

}
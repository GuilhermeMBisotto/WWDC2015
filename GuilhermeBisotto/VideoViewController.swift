//
//  VideoViewController.swift
//  GuilhermeBisotto
//
//  Created by Guilherme Moresco Bisotto on 4/18/15.
//  Copyright (c) 2015 GuilhermeBisotto. All rights reserved.
//

import Foundation
import MediaPlayer

class VideoViewController: UIViewController {
   
    //MARK: - Variables
    var moviePlayer : MPMoviePlayerController?
    var videoName: String?
    var videoType: String?
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addEffectOfTransparency()
        
        let path = NSBundle.mainBundle().pathForResource(videoName, ofType: videoType)
        let url = NSURL.fileURLWithPath(path!)
        moviePlayer = MPMoviePlayerController(contentURL: url)
        moviePlayer!.view.frame = view.bounds
        moviePlayer!.fullscreen = true
        moviePlayer!.controlStyle = MPMovieControlStyle.Fullscreen
        self.view.addSubview(moviePlayer!.view)
        moviePlayer!.prepareToPlay()
        moviePlayer!.play()
    }
    
    override func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("playerDidFinish"), name: MPMoviePlayerDidExitFullscreenNotification, object: moviePlayer)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("playerDidFinish"), name: MPMoviePlayerPlaybackDidFinishNotification, object: moviePlayer)
    }
    
    //MARK: - Actions
    func playerDidFinish() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addEffectOfTransparency() {
        view.backgroundColor = UIColor(red:0.0, green:0.0,blue:0.0,alpha:0.0)
    }
}
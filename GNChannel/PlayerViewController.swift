//
//  PlayerViewController.swift
//  LiveStreamingSample
//
//  Created by kohey on 2015/07/18.
//  Copyright (c) 2015年 kohey. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class PlayerViewController: AVPlayerViewController {
    
    var _liveURL:NSString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLive(_liveURL)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setLive(liveUrl: NSString) {
        let url = NSURL(string: liveUrl as String)
        let playerItem = AVPlayerItem(URL: url!)
        let player = AVPlayer(playerItem: playerItem)
        self.player = player
        self.player!.play()
    }
}

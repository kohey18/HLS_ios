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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //let url = NSURL(scheme: "http", host: "52.69.172.207:3000", path: "/videos/stream/stream.m3u8")
        let url = NSURL(string: "https://d29xsu8h6iusrj.cloudfront.net/livestreamingsample/wkpap0vs3j6x/5917fb99-ccec-4b74-9d57-46250b481634/index.m3u8")
        let playerItem = AVPlayerItem(URL: url)
        let player = AVPlayer(playerItem: playerItem)
        self.player = player
        self.player.play()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
}

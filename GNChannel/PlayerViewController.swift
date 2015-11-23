//
//  PlayerViewController.swift
//  GNChannel
//
//  Created by kohey on 2015/07/18.
//  Copyright (c) 2015年 kohey. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class PlayerViewController: UIViewController {
    
    var liveURL:NSString = ""
    @IBOutlet weak var programName: UILabel!
    @IBOutlet weak var programDesc: UILabel!
    @IBOutlet weak var programPlayerView: AVPlayerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        programDesc.sizeToFit()
        print(liveURL)
        setLive(liveURL)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setLayer() {
    }
    
    func setLive(liveUrl: NSString) {
        let url = NSURL(string: liveUrl as String)
        // player作成
        let playerItem = AVPlayerItem(URL: url!)
        var player = AVPlayer(playerItem: playerItem)
        player = AVPlayer(URL: url!)        
        //view作成
        let layer = programPlayerView!.layer as! AVPlayerLayer
        layer.videoGravity = AVLayerVideoGravityResizeAspect
        layer.player = player
        layer.player?.play()
    }
}

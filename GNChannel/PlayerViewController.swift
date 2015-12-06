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
    
    var userId:NSString = ""
    var desc:NSString = ""
    var userName:NSString = ""
    var channel:NSString = ""
    
    @IBOutlet weak var programName: UILabel!
    @IBOutlet weak var programDesc: UILabel!
    @IBOutlet weak var programPlayerView: AVPlayerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.programName.text = channel as String
        self.programDesc.text = desc as String
        self.setUpdateBtn()
        programDesc.sizeToFit()
        getLive()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpdateBtn() {
        let updateBtn = UIBarButtonItem(title: "更新", style: .Plain, target: self, action: "getLive")
         self.navigationItem.rightBarButtonItem = updateBtn
    }
    
    func setLayer() {
    }
    
    func getLive() {
        let userId = self.userId
        ApiFetcher().getLive(userId, onCompletion: { (responseObject: NSDictionary?, error:NSError?) -> Void in
            let results = responseObject!["result"] as! NSArray
            if (results.count != 0) {
                if let liveUrl = results[0]["file"] as? NSString {
                    self.setLive(liveUrl)
                } else {
                    SVProgressHUD.showErrorWithStatus("現在、放映中ではございません。")
                }
            } else {
                SVProgressHUD.showErrorWithStatus("現在、放映中ではございません。")
            }
        })

    }
    
    
    func setLive(liveUrl: NSString) {
        let url = NSURL(string: liveUrl as String)
        // player作成
        let playerItem = AVPlayerItem(URL: url!)
        var player = AVPlayer(playerItem: playerItem)
        player = AVPlayer(URL: url!)        
        //view作成
        let layer = programPlayerView!.layer as! AVPlayerLayer
        layer.frame = self.programPlayerView.bounds
        layer.videoGravity = AVLayerVideoGravityResizeAspect
        layer.player = player
        layer.player?.play()
    }
}

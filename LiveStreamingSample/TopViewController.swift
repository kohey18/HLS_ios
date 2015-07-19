//
//  TopViewController.swift
//  LiveStreamingSample
//
//  Created by kohey on 2015/07/18.
//  Copyright (c) 2015年 kohey. All rights reserved.
//

import UIKit

class TopViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var thumbPosition:CGFloat = 100
    var livesArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getThumbnails()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        performSegueWithIdentifier("playerView", sender: nil)
    }
    
    @IBAction func startLive() {
        Kickflip.presentBroadcasterFromViewController(self, ready: { stream in
            let mStream:KFStream = stream
            
            if mStream.streamURL != nil {
                println("Stream is ready at URL: %@", mStream.streamURL.absoluteString);
                let dic: NSDictionary =
                [
                    "file": mStream.streamURL,
                    "thumbnail": mStream.thumbnailURL,
                ]
                ApiFetcher().postLive(dic)
            } else {
                println("error")
            }
            }, completion: { success, error in
                if error != nil {
                   println("Error setup stream")
                } else {
                    println("DONE boardcasting")
                }
            })
    }
    
    // ココはクロージャーで書ける
    private func getThumbnails() {
        ApiFetcher().getLives { (responseObject: NSDictionary?, error:NSError?) -> Void in
            // View作成
            self.livesArray = responseObject!["result"] as! NSArray
            for (index,dic) in enumerate(self.livesArray) {
                let thumbURL = dic["thumbnail"] as! NSString
                let url = NSURL(string: thumbURL as String)
                var err: NSError?
                var imageData = NSData(contentsOfURL: url!,options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &err)!
                
                if err == nil {
                    let img = UIImage(data:imageData)
                    self.initThumbnail(img!, tag: index)
                } else {
                    println(err)
                }
            }
        }
    }
    
    private func initThumbnail(img: UIImage, tag: NSInteger) {
        let thumbImageView = UIImageView(frame: CGRectMake(0,0,380,200))
        thumbImageView.image = img
        thumbImageView.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.thumbPosition)
        
        self.thumbPosition = self.thumbPosition + 250.0
        self.scrollView.contentSize = CGSizeMake(240, self.scrollView.contentSize.height + 250)
        
        thumbImageView.userInteractionEnabled = true
        thumbImageView.tag = tag
        var myTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tapGesture:")
        thumbImageView.addGestureRecognizer(myTap)
        self.scrollView.addSubview(thumbImageView)
    }
    
    func tapGesture(sender:UITapGestureRecognizer) {
        performSegueWithIdentifier("playerSegue", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "playerSegue") {
            let img = sender.view as! UIImageView
            let url = self.livesArray[img.tag]["file"] as! NSString
            let secondView: PlayerViewController = segue.destinationViewController as! PlayerViewController
            secondView._liveURL = url
        }
    }

}

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
        //self.thumbnail.backgroundColor = UIColor.redColor()
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
            for dic in self.livesArray {
                let thumbURL = dic["thumbnail"] as! NSString
                let url = NSURL(string: thumbURL as String)
                var err: NSError?
                var imageData = NSData(contentsOfURL: url!,options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &err)!
                //println(thumbURL)
                if err == nil {
                    let img = UIImage(data:imageData)
                    self.initThumbnail(img!)
                } else {
                    println(err)
                }
            }
        }
    }
    
    private func initThumbnail(img: UIImage) {
        let thumbImageView = UIImageView(frame: CGRectMake(0,0,380,200))
        thumbImageView.image = img
        thumbImageView.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.thumbPosition)
        
        self.thumbPosition = self.thumbPosition + 250.0
        self.scrollView.contentSize = CGSizeMake(240, self.scrollView.contentSize.height + 250)
        
        thumbImageView.userInteractionEnabled = true
        var myTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tapGesture:")
        thumbImageView.addGestureRecognizer(myTap)
        self.scrollView.addSubview(thumbImageView)

    }
    
    
    func tapGesture(sender:UITapGestureRecognizer){
        //let liveViewCtrl: UIViewController = PlayerViewController()
        //let liveViewCtrl: UIViewController = LiveViewController()
        //liveViewCtrl.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        // Viewの移動する.
        //self.presentViewController(liveViewCtrl, animated: true, completion: nil)
        //self.navigationController?.pushViewController(liveViewCtrl, animated: true)
        //self.delegate.setLive("https://d29xsu8h6iusrj.cloudfront.net/livestreamingsample/wkpap0vs3j6x/5917fb99-ccec-4b74-9d57-46250b481634/index.m3u8")
        performSegueWithIdentifier("playerSegue", sender: self)
        
        
    }
    
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "playerSegue") {
            // SecondViewControllerクラスをインスタンス化してsegue（画面遷移）で値を渡せるようにバンドルする
            var secondView : PlayerViewController = segue.destinationViewController as! PlayerViewController
            //secondView._second = _param
        }
    }*/

    // 回転禁止
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

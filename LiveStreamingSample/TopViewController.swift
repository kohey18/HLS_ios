//
//  TopViewController.swift
//  LiveStreamingSample
//
//  Created by kohey on 2015/07/18.
//  Copyright (c) 2015年 kohey. All rights reserved.
//

import UIKit

class TopViewController: UIViewController {


    @IBOutlet weak var thumbnail: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    private func getThumbnails() -> Void {
        ApiFetcher().getLives { (responseObject:NSDictionary?, error:NSError?) -> Void in            
            // View作成
            /*
            let results = responseObject as! NSMutableDictionary
            println(results["results"][0]["thumnail"])
            let url = NSURL(string: results[0]["thumbnail"]);
            var err: NSError?
            var imageData = NSData(contentsOfURL: url!,options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &err)!
            
            if err == nil {
                self.thumbnail.image = UIImage(data:imageData)
            } else {
                println(err)
            }
        }*/
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  HomeViewController.swift
//  GNChannel
//
//  Created by kohey on 2015/07/18.
//  Copyright (c) 2015年 kohey. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var broadcastBtn: UIButton!
    @IBOutlet weak var watchBtn: UIButton!
    var thumbPosition:CGFloat = 100
    var livesArray = []
    
    /*
    override func loadView() {
        //self.view = NSBundle.mainBundle().loadNibNamed("HomeView", owner: nil, options: nil).first as? UIView
    }*/
    
    override func viewDidLoad() {
        self.navigationController?.navigationBarHidden = true
        self.view.backgroundColor = UIColor.gn_blackColor()
        self.broadcastBtn.backgroundColor = UIColor.yellowColor()
        self.watchBtn.backgroundColor = UIColor.yellowColor()
        
        self.broadcastBtn.layer.cornerRadius = 10.0
        self.watchBtn.layer.cornerRadius = 10.0
        self.broadcastBtn.clipsToBounds = true
        self.watchBtn.clipsToBounds = true


        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
    
    /*
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        performSegueWithIdentifier("playerView", sender: nil)
    }*/
    
    @IBAction func startLive() {
        /*
        let storyboard = UIStoryboard(name: "BroadCastView", bundle: nil)
        let broadCastViewController = storyboard.instantiateViewControllerWithIdentifier("BroadCastView")
        self.navigationController?.pushViewController(broadCastViewController, animated: true)
        */
        /*
        [Kickflip presentBroadcasterFromViewController:self ready:^(KFStream *stream) {
        if (stream.streamURL) {
        NSLog(@"Stream is ready at URL: %@", stream.streamURL);
        }
        } completion:^(BOOL success, NSError* error){
        if (!success) {
        NSLog(@"Error setting up stream: %@", error);
        } else {
        NSLog(@"Done broadcasting");
        }
        }];
        */
        Kickflip.presentBroadcasterFromViewController(self, ready: { stream in
            let mStream = stream
            if mStream.streamURL != nil {
                print("Stream is ready at URL: %@", mStream.streamURL.absoluteString);
                let dic: NSDictionary =
                [
                    "file": mStream.streamURL,
                    "thumbnail": mStream.thumbnailURL,
                ]
                ApiFetcher().postLive(dic)
            } else {
                print("error")
            }
            }, completion: { success, error in
                if error != nil {
                    print("Error setup stream")
                } else {
                    print("DONE boardcasting")
                }
        })
    }
    
    @IBAction func pushWathBtn() {
        let storyboard = UIStoryboard(name: "WeekView", bundle: nil)
        let weekViewController = storyboard.instantiateViewControllerWithIdentifier("WeekView")
        self.navigationController?.pushViewController(weekViewController, animated: true)
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
    
}

//
//  WeekProgram.swift
//  GNChannel
//
//  Created by kohey on 2015/11/20.
//  Copyright © 2015年 kohey. All rights reserved.
//

class WeekProgram: UIViewController {
    
    let labelWidth: Int = 30
    let labelHeight: Int = 30
    
    @IBOutlet weak var userThumnailImg: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    
    var livesArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = false
                self.navigationController?.navigationBar.barTintColor = UIColor.gn_blackColor()
        self.navigationController?.navigationBar.tintColor = UIColor.gn_yellowColor()
        self.view.backgroundColor = UIColor.gn_blackColor()
        //self.dayLabel.backgroundColor = UIColor.yellowColor()
        //self.dayLabel.layer.cornerRadius = self.dayLabel.frame.size.width / 2
        self.dayLabel.font = UIFont.systemFontOfSize(25)
        arrangeDays(self.dayLabel)
        getThumbnails()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func modalClose(sender:AnyObject) {
        //parentViewController?.dismissViewControllerAnimated(true, completion: nil)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func arrangeDays(dayLabel: UILabel) {
        let days: [String] = ["火", "水", "木", "金", "土", "日"]
        
        for (index, day) in days.enumerate() {
            let nextDay = UILabel(frame: CGRect(x: 0, y: 0, width: self.labelWidth, height: self.labelHeight))
            
            let hoge = self.dayLabel.center.x + CGFloat(30 * index + 1)
            print(hoge)
            
            nextDay.font = UIFont.systemFontOfSize(25)
            nextDay.center = CGPoint(x: (self.dayLabel.center.x + CGFloat(50 * (index + 1))), y: self.dayLabel.center.y)
            nextDay.textColor = UIColor.yellowColor()
            nextDay.text = day
            self.view.addSubview(nextDay)
        }

    }
    
    private func getThumbnails() {
        ApiFetcher().getLives { (responseObject: NSDictionary?, error:NSError?) -> Void in
            // View作成
            self.livesArray = responseObject!["result"] as! NSArray

            //for (index,dic) in enumerate(self.livesArray) {
            //for (_,dic) in livesArray.enumerate() {
            
            let thumbURL = self.livesArray[0]["thumbnail"] as! NSString
            let url = NSURL(string: thumbURL as String)
            
            self.userThumnailImg.userInteractionEnabled = true
            let myTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tapGesture:")
            self.userThumnailImg.addGestureRecognizer(myTap)

            let imgData: NSData
            do {
                imgData = try NSData(contentsOfURL:url!,options: NSDataReadingOptions.DataReadingMappedIfSafe)
                self.userThumnailImg.image = UIImage(data:imgData);
            } catch {
                print("Error: can't create image.")
            }
            
        }
    }
    
    func tapGesture(sender:UITapGestureRecognizer) {
        performSegueWithIdentifier("playerSegue", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "playerSegue") {
            let img = sender.view as! UIImageView
            let url = self.livesArray[0]["file"] as! NSString
            print(url)
            let secondView: PlayerViewController = segue.destinationViewController as! PlayerViewController
            secondView._liveURL = url
        }
    }

}




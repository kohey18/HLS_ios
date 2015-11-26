//
//  WeekProgram.swift
//  GNChannel
//
//  Created by kohey on 2015/11/20.
//  Copyright © 2015年 kohey. All rights reserved.
//

import UIKit

class WeekProgram: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let labelWidth: Int = 30
    let labelHeight: Int = 30
    var programs = []
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        arrangeDays(self.dayLabel)
        getPrograms()
        
        self.navigationController?.navigationBarHidden = false
                self.navigationController?.navigationBar.barTintColor = UIColor.gn_blackColor()
        self.navigationController?.navigationBar.tintColor = UIColor.gn_yellowColor()
        self.view.backgroundColor = UIColor.gn_blackColor()
        //self.dayLabel.backgroundColor = UIColor.yellowColor()
        self.dayLabel.layer.cornerRadius = self.dayLabel.frame.size.width / 2
        self.dayLabel.font = UIFont.systemFontOfSize(25)

        // tableView設定
        tableView.delegate = self
        tableView.dataSource = self
        //カスタムセルを指定
        let nib  = UINib(nibName: "ProgramTableViewCell", bundle:nil)
        tableView.registerNib(nib, forCellReuseIdentifier:"Cell")
        
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
    
    // complitationで書き直す
    private func getPrograms() {
        ApiFetcher().getLives { (responseObject: NSDictionary?, error:NSError?) -> Void in
            self.programs = responseObject!["result"] as! NSArray
            self.tableView.reloadData()
        }
    }
    
    func setCell(index: Int, cell: ProgramTableViewCell) -> ProgramTableViewCell {
            let thumbURL = self.programs[index]["thumbnail"] as! NSString
            let url = NSURL(string: thumbURL as String)
            let imgData: NSData
            do {
                imgData = try NSData(contentsOfURL:url!,options: NSDataReadingOptions.DataReadingMappedIfSafe)
                cell.userImageView.image = UIImage(data: imgData);
            } catch {
                print("Error: can't create image.")
            }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
        print(self.programs.count)
        return self.programs.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! ProgramTableViewCell
        // TODO: cellの再描画しないようにする
        //let newCell = setCell(indexPath.row, cell: cell)
        //newCell.backgroundColor = UIColor.clearColor()
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
    

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        let storyboard = UIStoryboard(name: "PlayerView", bundle: nil)
        if let playerView = storyboard.instantiateViewControllerWithIdentifier("PlayerView") as? PlayerViewController{
            playerView.liveURL = self.programs[indexPath.row]["file"] as! NSString
            self.navigationController?.pushViewController(playerView, animated: true)
        } else {
            print("error")
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }

}




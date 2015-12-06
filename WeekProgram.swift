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
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getUsers()
        
        self.navigationController?.navigationBarHidden = false
                self.navigationController?.navigationBar.barTintColor = UIColor.gn_blackColor()
        self.navigationController?.navigationBar.tintColor = UIColor.gn_yellowColor()
        self.view.backgroundColor = UIColor.gn_blackColor()
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
    
    // complitationで書き直す
    private func getUsers() {
        ApiFetcher().getUsers { (responseObject: NSDictionary?, error:NSError?) -> Void in
            self.programs = responseObject!["result"] as! NSArray
            self.tableView.reloadData()
        }
    }
    
    func setCell(index: Int, cell: ProgramTableViewCell) -> ProgramTableViewCell {
        let thumbURL = self.programs[index]["thumb"] as! NSString
        let desc = self.programs[index]["desc"]
        let name = self.programs[index]["name"]
        let channel = self.programs[index]["channel"]

        cell.programDesc.text = desc as! String
        cell.programName.text = channel as! String
        cell.programUserName.text = name as! String
        
        
        let url = NSURL(string: thumbURL as String)
        let imgData: NSData
        do {
            imgData = try NSData(contentsOfURL:url!,options:
                NSDataReadingOptions.DataReadingMappedIfSafe)
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
        let newCell = setCell(indexPath.row, cell: cell)
        //newCell.backgroundColor = UIColor.clearColor()
        newCell.backgroundColor = UIColor.clearColor()
        return newCell
    }
    

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        let storyboard = UIStoryboard(name: "PlayerView", bundle: nil)
        if let playerView = storyboard.instantiateViewControllerWithIdentifier("PlayerView") as? PlayerViewController{
            
            playerView.userId = self.programs[indexPath.row]["id"] as! NSString
            playerView.channel = self.programs[indexPath.row]["channel"] as! NSString
            playerView.desc = self.programs[indexPath.row]["desc"] as! NSString
            playerView.userName = self.programs[indexPath.row]["name"] as! NSString
            
            self.navigationController?.pushViewController(playerView, animated: true)
        } else {
            print("error")
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
    }

}




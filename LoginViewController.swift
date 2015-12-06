//
//  LoginViewController.swift
//  GNChannel
//
//  Created by kohey on 2015/12/07.
//  Copyright © 2015年 kohey. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var idField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = UIColor.gn_blackColor()
        self.navigationController?.navigationBar.tintColor = UIColor.gn_yellowColor()
        self.view.backgroundColor = UIColor.gn_blackColor()
        self.loginBtn.backgroundColor = UIColor.yellowColor()
        self.loginBtn.layer.cornerRadius = 10.0
        self.loginBtn.clipsToBounds = true
        
        self.passField.secureTextEntry = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login() {
        
        let dic: NSDictionary = ["id": self.idField.text!, "pass": self.passField.text!]
        
        ApiFetcher().login(dic, onCompletion: { (responseObject: NSDictionary?, error:NSError?) -> Void in
            if error != nil {
                print(error)
                SVProgressHUD.showErrorWithStatus("Login Error")
            } else {

                if let status = responseObject!["status"] as? Int {
                    if status != 200 {
                        SVProgressHUD.showErrorWithStatus("Login Error")
                    } else {
                        self.startLive()
                    }
                }
            }
        })
    }
    
    func startLive() {
        
        let broadCastView = BroadcastViewController()
        self.navigationController?.presentViewController(broadCastView, animated: true, completion: nil)
        
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

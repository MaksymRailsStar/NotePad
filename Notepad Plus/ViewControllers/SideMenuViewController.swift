//
//  SideMenuViewController.swift
//  GoGoDriver
//
//  Created by Vipul Pipaliya on January/22/2018.
//  Copyright © 2018 Vipul Pipaliya. All rights reserved.
//

import UIKit


class SideMenuViewController: MenuViewController, SideMenuItemContent{

    
    @IBOutlet var btn_Theme : UIButton!
    @IBOutlet var btn_ShareApp : UIButton!
    @IBOutlet var btn_RateUs : UIButton!
    @IBOutlet var btn_PasswordChange : UIButton!
    
    let AppLink = "https://itunes.apple.com/us/app/hotsapp-lyrical-video/id1380731910?mt=8"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func onClickMenuButtons(_ sender: UIButton) {
        let tag = sender.tag as Int
        switch tag {
        case 101:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NotiCallTheme"), object: nil)
            break
        case 102:
            //Share
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NotiSharePopup"), object: nil)
            break
        case 103:
            //Rate Us
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NotiCloseSideMenu"), object: nil)
            UIApplication.shared.openURL(NSURL(string: AppLink)! as URL)
            break
        case 104:
            //Change Password
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NotiChangePassword"), object: nil)
            break
        default:
            break
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

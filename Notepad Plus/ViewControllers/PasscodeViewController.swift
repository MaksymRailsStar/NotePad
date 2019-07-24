//
//  PasscodeViewController.swift
//  Notepad Plus
//
//  Created by Vipul Pipaliya on April/19/2019.
//  Copyright © 2019 Vipul Pipaliya. All rights reserved.
//

import UIKit
import CoreData

class PasscodeViewController: UIViewController {

    var blurEffectView : UIVisualEffectView!
    var tapCounter: Int = 0
    var strPassword: String = ""
    var isPasswordCreated : Bool = false
    var passwordTag : Int = 0 // 0 = first password // 1 = re-enter password
    var firstPassword: String = ""
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var lbl_EnterPassword: UILabel!
    @IBOutlet weak var btn_Reset: UIButton!
    @IBOutlet weak var btn_Delete: UIButton!
    
    @IBOutlet weak var vw_PassIndicate: UIView!
    @IBOutlet weak var lbl_PassIndicate1: UILabel!
    @IBOutlet weak var lbl_PassIndicate2: UILabel!
    @IBOutlet weak var lbl_PassIndicate3: UILabel!
    @IBOutlet weak var lbl_PassIndicate4: UILabel!
    @IBOutlet weak var lbl_PassIndicate5: UILabel!
    @IBOutlet weak var lbl_PassIndicate6: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bgImageView.alpha = 1.0
        blurEffectView = Helper.addBlurView((bgImageView)!)
        self.bgImageView.addSubview(blurEffectView)
        
        self.setupUIs()
        // Do any additional setup after loading the view.
    }

    func setupUIs() {
        self.lbl_PassIndicate1.setCustomBorder()
        self.lbl_PassIndicate2.setCustomBorder()
        self.lbl_PassIndicate3.setCustomBorder()
        self.lbl_PassIndicate4.setCustomBorder()
        self.lbl_PassIndicate5.setCustomBorder()
        self.lbl_PassIndicate6.setCustomBorder()
        
        self.getUserPassword()
    }
    func getUserPassword() {
        if UserDefaults.standard.string(forKey: "userPassword") != nil {
            print("Enter Password")
            self.isPasswordCreated = true
            self.lbl_EnterPassword.text = "Enter Password"
        } else {
            print("Create Password")
            self.isPasswordCreated = false
//            self.createNewPassword()
            self.lbl_EnterPassword.text = "Create New Password"
            
//            UserDefaults.standard.set("454620", forKey: "userPassword")
        }
    }
    func createNewPassword() {
        
    }
    @IBAction func onTapReset(_ sender: UIButton) {
        tapCounter = 0
        self.strPassword = ""
        self.lbl_PassIndicate1.backgroundColor = .clear
        self.lbl_PassIndicate2.backgroundColor = .clear
        self.lbl_PassIndicate3.backgroundColor = .clear
        self.lbl_PassIndicate4.backgroundColor = .clear
        self.lbl_PassIndicate5.backgroundColor = .clear
        self.lbl_PassIndicate6.backgroundColor = .clear
    }
    @IBAction func onTapDelete(_ sender: UIButton) {
        switch tapCounter {
        case 1:
            DispatchQueue.main.async {
                self.lbl_PassIndicate1.backgroundColor = .clear
            }
            break
        case 2:
            DispatchQueue.main.async {
                self.lbl_PassIndicate2.backgroundColor = .clear
            }
            break
        case 3:
            DispatchQueue.main.async {
                self.lbl_PassIndicate3.backgroundColor = .clear
            }
            break
        case 4:
            DispatchQueue.main.async {
                self.lbl_PassIndicate4.backgroundColor = .clear
            }
            break
        case 5:
            DispatchQueue.main.async {
                self.lbl_PassIndicate5.backgroundColor = .clear
            }
            break
        case 6:
            DispatchQueue.main.async {
                self.lbl_PassIndicate6.backgroundColor = .clear
            }
            break
        default:
            break
        }
        if tapCounter > 0 {
        tapCounter = tapCounter - 1
        let str = self.strPassword.dropLast()
        self.strPassword = String(str)
        }
        print("tapCounter :: ", tapCounter)
    }
    @IBAction func onTapNumberPad(_ sender: UIButton) {
        let tag = sender.tag
        self.tapCounter = tapCounter + 1
        
        switch tapCounter {
        case 1:
            DispatchQueue.main.async {
                self.lbl_PassIndicate1.backgroundColor = .white
            }
            break
        case 2:
            DispatchQueue.main.async {
                self.lbl_PassIndicate2.backgroundColor = .white
            }
            break
        case 3:
            DispatchQueue.main.async {
                self.lbl_PassIndicate3.backgroundColor = .white
            }
            break
        case 4:
            DispatchQueue.main.async {
                self.lbl_PassIndicate4.backgroundColor = .white
            }
            break
        case 5:
            DispatchQueue.main.async {
                self.lbl_PassIndicate5.backgroundColor = .white
            }
            break
        case 6:
            DispatchQueue.main.async {
                self.lbl_PassIndicate6.backgroundColor = .white
            }
            break   
        default:
            break
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            // your code here
            self.verifyUserPassword(str: "\(tag)")
        }
        
    }
    func verifyUserPassword(str: String) {
        self.strPassword = strPassword + str
        print("User Password is -", self.strPassword)
        
        if self.isPasswordCreated == false {
            if self.tapCounter == 6 {
                if passwordTag == 0 {
                    firstPassword = self.strPassword
                    passwordTag = 1
                    self.lbl_EnterPassword.text = "Confirm Password"
                    // re-enter password
                    tapCounter = 0
                    self.strPassword = ""
                    self.lbl_PassIndicate1.backgroundColor = .clear
                    self.lbl_PassIndicate2.backgroundColor = .clear
                    self.lbl_PassIndicate3.backgroundColor = .clear
                    self.lbl_PassIndicate4.backgroundColor = .clear
                    self.lbl_PassIndicate5.backgroundColor = .clear
                    self.lbl_PassIndicate6.backgroundColor = .clear
                    
                } else if passwordTag == 1 {
                    if self.firstPassword == self.strPassword {
                        // Save password
                        print("Save Password in user dafault")
                        UserDefaults.standard.set(self.strPassword, forKey: "userPassword")
                        self.redirectToHome(str: "Password Saved!!")
                    } else {
                        print("Password incorrect")
                        tapCounter = 0
                        self.strPassword = ""
                        self.reEnterPassword()
                    }
                }
            }
        } else {
            //true // Enter Password
            var userPass :String = ""
            if (UserDefaults.standard.string(forKey: "userPassword") != nil) {
                userPass = UserDefaults.standard.string(forKey: "userPassword")! //as! String
            }
            if tapCounter == 6 {
                if self.strPassword == userPass {
                    print("Password Correct")
                    
                    self.redirectToHome(str: "Note Unlocked!!")
                    
                    /*
                     let rootVC:LoginViewController = self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
                     let nvc:UINavigationController = self.storyboard?.instantiateViewControllerWithIdentifier("RootNavigationController") as! UINavigationController
                     nvc.viewControllers = [rootVC]
                     UIApplication.sharedApplication().keyWindow?.rootViewController = nvc
                     */
                } else {
                    reEnterPassword()
                }
                tapCounter = 0
                self.strPassword = ""
            } else {
                
            }
        }
    }
    func redirectToHome(str: String) {
        let alert = UIAlertController(title: "", message: str, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when){
            alert.dismiss(animated: true, completion: nil)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//            self.redirectToHome()
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let homeViewController = mainStoryboard.instantiateViewController(withIdentifier: "HostViewController") as! HostViewController
            let nav = UINavigationController(rootViewController: homeViewController)
            nav.navigationBar.isHidden = true
            appdelegate.window!.rootViewController = nav
        }
        
        
    }
    func reEnterPassword() {
        self.lbl_PassIndicate1.backgroundColor = .clear
        self.lbl_PassIndicate2.backgroundColor = .clear
        self.lbl_PassIndicate3.backgroundColor = .clear
        self.lbl_PassIndicate4.backgroundColor = .clear
        self.lbl_PassIndicate5.backgroundColor = .clear
        self.lbl_PassIndicate6.backgroundColor = .clear
        
        UIView.animate(withDuration: 0.1, animations: {
            self.vw_PassIndicate.transform = CGAffineTransform(translationX: -20, y: 0)
        })
        UIView.animate(withDuration: 0.1, delay: 0.1, options: UIViewAnimationOptions.transitionCurlUp, animations: {
            self.vw_PassIndicate.transform = CGAffineTransform(translationX: 20, y: 0)
        }) { (true) in
            UIView.animate(withDuration: 0.1, delay: 0, options: UIViewAnimationOptions.transitionCurlUp, animations: {
                self.vw_PassIndicate.transform = CGAffineTransform(translationX: 00, y: 0)
            }) { (true) in
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension UILabel {
     func setCustomBorder() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
    }
}

//
//  ChangePasscodeViewController.swift
//  Notepad Plus
//
//  Created by Vipul Pipaliya on April/28/2019.
//  Copyright © 2019 Vipul Pipaliya. All rights reserved.
//

import UIKit

class ChangePasscodeViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var txt_OldPassword : UITextField!
    @IBOutlet var txt_NewPassword : UITextField!
    @IBOutlet var txt_ConfirmPassword : UITextField!
    @IBOutlet var btn_passwordCheck : UIButton!
    @IBOutlet var btn_ChnagePassword : UIButton!
    @IBOutlet var vw_HeaderView : UIView!

     var isChecked: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUIs()
        // Do any additional setup after loading the view.
    }

    func setupUIs()  {
        
        self.txt_OldPassword.delegate = self
        self.txt_NewPassword.delegate = self
        self.txt_ConfirmPassword.delegate = self
        
        self.vw_HeaderView.backgroundColor = themeColor
        self.btn_ChnagePassword.backgroundColor = themeColor
        
        if isChecked {
            self.btn_passwordCheck.alpha = 1
        } else {
            self.btn_passwordCheck.alpha = 0.5
        }
    }
    @IBAction func onClickShowPassword(_ sender: UIButton) {
        if isChecked {
            self.btn_passwordCheck.alpha = 0.5
            self.isChecked = false
            
            self.txt_OldPassword.isSecureTextEntry = true
            self.txt_NewPassword.isSecureTextEntry = true
            self.txt_ConfirmPassword.isSecureTextEntry = true
            
        } else {
            self.btn_passwordCheck.alpha = 1
            self.isChecked = true
            
            self.txt_OldPassword.isSecureTextEntry = false
            self.txt_NewPassword.isSecureTextEntry = false
            self.txt_ConfirmPassword.isSecureTextEntry = false
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 6
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    @IBAction func onClickBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func onClickChangePassword(_ sender: UIButton) {
        
        let oldPass = self.txt_OldPassword.text!
        var userPass :String = ""
        if (UserDefaults.standard.string(forKey: "userPassword") != nil) {
            userPass = UserDefaults.standard.string(forKey: "userPassword")! //as! String
        }
        
        let newPass = self.txt_NewPassword.text!
        let confiPass = self.txt_ConfirmPassword.text!
        
        if oldPass == userPass && newPass == confiPass {
            print("Password Matched")
            UserDefaults.standard.set(newPass, forKey: "userPassword")
        } else {
            print("Password Re-enter")
        }
        
        //self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

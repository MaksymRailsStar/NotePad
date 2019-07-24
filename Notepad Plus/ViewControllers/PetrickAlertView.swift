
//
//  PetrickAlertView.swift
//  CustomAlertView


// Add Your uiview to show in alert
//or pass blank

import Foundation
import UIKit

extension UIView {
    class func loadFromNibNamed(nibNamed: String, bundle : Bundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
}


class PetrickAlertView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.setupViews()
        self.setupWindow()
    }
    
    internal init(cv : UIView) {
        super.init(nibName: nil, bundle: nil)
        customeView_inner = cv
        self.setupViews()
        self.setupWindow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupViews() {
        if viewNotReady() {
            return
        }
        self.backgroundView_alert = UIView(frame: self.view.bounds)
        self.view = UIView(frame: (UIApplication.shared.keyWindow?.bounds)!)
        self.backgroundView_alert.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.tapOutsideTouchGestureRecognizer.addTarget(self, action: #selector(PetrickAlertView.hide))
        self.view.addSubview(backgroundView_alert)
        
        if customeView_inner != nil
        {
            customeView_inner.backgroundColor = UIColor.white
            customeView_inner.center = backgroundView_alert.center
            customeView_inner.removeGestureRecognizer(self.tapOutsideTouchGestureRecognizer)
            self.backgroundView_alert.addSubview(customeView_inner)
        }
    }
    func setupWindow() {
        if viewNotReady() {
            return
        }
        
        let window = UIWindow(frame: (UIApplication.shared.keyWindow?.bounds)!)
        self.alertWindow = window
        self.alertWindow.windowLevel = UIWindowLevelAlert
        self.alertWindow.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        self.alertWindow.rootViewController = self
        self.previousWindow = UIApplication.shared.keyWindow
    }
    
    func viewNotReady() -> Bool {
        return UIApplication.shared.keyWindow == nil
    }
    
    
    internal func show() {
        if viewNotReady() {
            return
        }
        self.alertWindow.addSubview(self.view)
        self.alertWindow.makeKeyAndVisible()
    }
    @objc internal func hide() {
        if viewNotReady() {
            return
        }
        self.alertWindow.isHidden = true
        //self.previousWindow.makeKeyAndVisible()
        //self.previousWindow = nil
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let t :UITouch = touches.first!
        if t.view == backgroundView_alert {
            hide()
        }
    }
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        let t : UITouch = touches.first!
//        if t.view == backgroundView_alert
//        {
//            hide()
//        }
//    }

    func dismiss()
    {
        self.view.removeFromSuperview()
        self.alertWindow.isHidden = true
        self.alertWindow = nil
        self.previousWindow.makeKeyAndVisible()
        self.previousWindow = nil
    }
    
    
    //MARK: Variable Area
    private var tapOutsideTouchGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()
    
    //Windows
    var previousWindow: UIWindow!
    var alertWindow: UIWindow!
    
    //View
    var backgroundView_alert: UIView!
    var customeView_inner : UIView!
    
}


/*
 Usage :
 let alert  = PetrickAlertView()
 alert.show()
 
 
 with NIB
 
 let alert  = pAlertView(cv: UIView.loadFromNibNamed("myPopUp")!)
 alert.show()
 
 */



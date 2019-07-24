//
//  HostViewController.swift
//  GoGoDriver
//
//  Created by Vipul Pipaliya on January/10/2018.
//  Copyright © 2018 Vipul Pipaliya. All rights reserved.
//

import UIKit

class HostViewController: MenuContainerViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let screenSize: CGRect = UIScreen.main.bounds
        self.transitionOptions = TransitionOptions(duration: 0.4, visibleContentWidth: screenSize.width / 6)
        // Instantiate menu view controller by identifier
        self.menuViewController = self.storyboard!.instantiateViewController(withIdentifier: "SideMenuViewController") as! MenuViewController
        // Gather content items controllers
        self.contentViewControllers = contentControllers()
        // Select initial content controller. It's needed even if the first view controller should be selected.
        self.selectContentViewController(contentViewControllers.first!)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    private func contentControllers() -> [UIViewController] {
        let controllersIdentifiers = ["MainViewController"]
        var contentList = [UIViewController]()
        
        /*
         Instantiate items controllers from storyboard.
         */
        for identifier in controllersIdentifiers {
            if let viewController = self.storyboard?.instantiateViewController(withIdentifier: identifier) {
                contentList.append(viewController)
            }
        }
        
        return contentList
    }
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        super.viewWillTransition(to: size, with: coordinator)
//
//        /*
//         Options to customize menu transition animation.
//         */
//        var options = TransitionOptions()
//
//        // Animation duration
//        options.duration = size.width < size.height ? 0.4 : 0.6
//
//        // Part of item content remaining visible on right when menu is shown
//        options.visibleContentWidth = size.width / 6
//        self.transitionOptions = options
//    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        var options = TransitionOptions()
        // Animation duration
        options.duration = size.width < size.height ? 0.4 : 0.6
        // Part of item content remaining visible on right when menu is shown
        options.visibleContentWidth = size.width / 6
        self.transitionOptions = options
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


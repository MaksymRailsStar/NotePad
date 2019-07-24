//
//  ThemeSelectionView.swift
//  Notepad
//
//  Created by Vipul Pipaliya on April/5/2019.
//  Copyright © 2019 Vipul Pipaliya. All rights reserved.
//

import Foundation
import UIKit

class ThemeSelectionView: UIView {
    
    @IBOutlet var lbl_ColorName : UILabel!
    @IBOutlet var vw_Color : UIView!
    @IBOutlet var btn_SelectColor : UIButton!
    
    override func awakeFromNib() {
        vw_Color.backgroundColor = UIColor(red: 0, green: 150/255, blue: 225/255, alpha: 1.0)
    }
}

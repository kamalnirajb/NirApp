//
//  AppAlertView.swift
//  Malomati
//
//  Created by Niraj Kumar on 1/26/17.
//  Copyright © 2017 Niraj Kumar. All rights reserved.
//

import UIKit

class AppAlertView: ParentCustomView {
    
    
    @IBOutlet weak var viewAlertBox: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var scrlMessage: UIScrollView!
    @IBOutlet weak var scrlHeight: NSLayoutConstraint!
    @IBOutlet weak var viewBoxHeight: NSLayoutConstraint!
    
    override func nibSetup() {
        super.nibSetup()
        self.fitHeight()
    }
    
    func fitHeight() -> Void {
        DispatchQueue.main.async {
            self.scrlMessage.contentSize = CGSize(width: self.scrlMessage.frame.size.width, height: self.lblMessage.requiredHeight(forFont: self.lblMessage.font))
            self.scrlHeight.constant = self.lblMessage.requiredHeight(forFont: self.lblMessage.font)
            self.viewBoxHeight.constant = self.lblMessage.requiredHeight(forFont: self.lblMessage.font) + 90.0
        }
    }
    
    @IBAction func btnOkClicked(_ sender: Any) {
        DispatchQueue.main.async {
            self.removeFromSuperview()
        }
    }
    
}

//
//  Utility.swift
//  Malomati
//
//  Created by Niraj Kumar on 1/18/17.
//  Copyright © 2017 Niraj Kumar. All rights reserved.
//

import UIKit


class Utility {
    
    class var sharedInstance: Utility {
        struct Singleton {
            static let instance = Utility()
        }
        return Singleton.instance
    }
    
    
    
    func trim(str:String?) -> String {
        if str != nil {
            return str!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        return ""
    }
    
    func showAlertOk(vc:UIViewController, title:String, message:String) -> Void {
        DispatchQueue.main.async {
            if vc.view.viewWithTag(999) != nil {
            }else {
                let alertVC:AppAlertView = AppAlertView(frame: vc.view.frame)
                alertVC.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                if alertVC.lblTitle != nil {
                    alertVC.lblTitle.text = title
                }
                if alertVC.lblMessage != nil {
                    alertVC.lblMessage.text = message
                }
                alertVC.tag = 999
                vc.view.addSubview(alertVC)
            }
        }
    }
    
    func showAppLoader(vc:UIViewController) -> Void {
        DispatchQueue.main.async {
            if vc.view.viewWithTag(999) != nil {
            }else {
                let appLoader:AppLoaderView = AppLoaderView(frame: vc.view.frame)
                appLoader.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                appLoader.tag = 999
                vc.view.addSubview(appLoader)
            }
        }
    }
    
    func hideAppLoader(vc:UIViewController) {
        DispatchQueue.main.async {
            vc.view.viewWithTag(999)?.removeFromSuperview()
        }
    }
    
    func lblHeight(txt:String, initframe:CGRect, forFont:UIFont) -> CGFloat {
        let lbl:UILabel = UILabel(frame: initframe)
        lbl.text = txt
        return lbl.requiredHeight(forFont: forFont)
    }

}

extension UILabel{
    func requiredHeight(forFont:UIFont) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = forFont
        label.text = self.text
        label.sizeToFit()
        return label.frame.height
    }
}


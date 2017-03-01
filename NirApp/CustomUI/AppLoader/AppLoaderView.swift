//
//  AppLoaderVC.swift
//  Malomati
//
//  Created by Niraj Kumar on 1/25/17.
//  Copyright © 2017 Niraj Kumar. All rights reserved.
//

import UIKit

class AppLoaderView: ParentCustomView {
    
    @IBOutlet weak var imgLoader: UIImageView!
    
    override func nibSetup() {
        super.nibSetup()
    }
    
    func goBack() {
        DispatchQueue.main.async {
            self.removeFromSuperview()
        }
    }
    
}


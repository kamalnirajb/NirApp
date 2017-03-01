//
//  InfoVC.swift
//  NirApp
//
//  Created by Niraj Kumar on 2/28/17.
//  Copyright © 2017 Niraj. All rights reserved.
//

import UIKit

class InfoVC: ParentVC, UITextFieldDelegate{

    var manufacturer:String = ""
    var model:String = ""
    
    
    @IBOutlet weak var viewInfoContainer: UIView!
    @IBOutlet weak var txtManufacturer: UITextField!
    @IBOutlet weak var txtModel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            
            self.viewInfoContainer.layer.borderColor = UIColor.red.cgColor
            self.viewInfoContainer.layer.borderWidth = 1.0
            
            self.txtManufacturer.text = self.manufacturer
            self.txtModel.text = self.model
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
}

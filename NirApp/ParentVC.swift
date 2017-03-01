//
//  ParentVC.swift
//  NirApp
//
//  Created by Niraj Kumar on 2/28/17.
//  Copyright © 2017 Niraj. All rights reserved.
//

import UIKit

class ParentVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func goBack(_ sender: UIBarButtonItem) {
        _ = self.navigationController?.popViewController(animated: true)
    }
}

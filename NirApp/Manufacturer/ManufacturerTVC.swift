//
//  ManufacturerTVC.swift
//  NirApp
//
//  Created by Niraj Kumar on 2/27/17.
//  Copyright © 2017 Niraj. All rights reserved.
//

import UIKit

class ManufacturerTVC: UITableViewCell {
    
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var lblManufactuer: UILabel!
    @IBOutlet weak var lblId: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setContent(content:[String:String], _ index:NSInteger) -> Void {
        DispatchQueue.main.async {
            self.lblManufactuer.text = content["title"]
            self.lblId.text = content["key"]
            self.viewContent.backgroundColor = index % 2 == 0 ? UIColor.gray.withAlphaComponent(0.5) : UIColor.blue.withAlphaComponent(0.5)
        }
    }
    
}

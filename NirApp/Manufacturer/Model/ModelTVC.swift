//
//  ManufacturerTVC.swift
//  NirApp
//
//  Created by Niraj Kumar on 2/27/17.
//  Copyright © 2017 Niraj. All rights reserved.
//

import UIKit

class ModelTVC: UITableViewCell {

    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var lblModel: UILabel!
    @IBOutlet weak var lblKey: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setContent(content:[String:String], _ index:NSInteger) -> Void {
        DispatchQueue.main.async {
            if let title:String = content["title"] {
                self.lblModel.text = title
            }
            
            if let key:String = content["key"] {
                self.lblKey.text = key
            }
            
            self.viewContent.backgroundColor = index % 2 == 0 ? UIColor.gray.withAlphaComponent(0.5) : UIColor.blue.withAlphaComponent(0.5)
            
        }
    }

}

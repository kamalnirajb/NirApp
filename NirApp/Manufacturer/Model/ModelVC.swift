//
//  ModelVC.swift
//  NirApp
//
//  Created by Niraj Kumar on 2/27/17.
//  Copyright © 2017 Niraj. All rights reserved.
//

import UIKit

class ModelVC: ParentVC, UITableViewDelegate, UITableViewDataSource {

    var page = 0
    var pageSize = 10
    var totalPageCount = 0
    var slectedRow = -1
    var selectedManufacturerIndex:NSInteger = 0
    
    
    @IBOutlet weak var actindLoadMore: UIActivityIndicatorView!
    @IBOutlet weak var tblviewModel: UITableView!
    @IBOutlet weak var lblNoRecords: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.actindLoadMore.stopAnimating()
        self.getModelListFromWS()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ModelOperation.sharedInstance.modelList.count == 0 {
            self.lblNoRecords.isHidden = false
            self.tblviewModel.isHidden = true
        }else {
            self.lblNoRecords.isHidden = true
            self.tblviewModel.isHidden = false
        }

        
        
        return ModelOperation.sharedInstance.modelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ModelTVC = tableView.dequeueReusableCell(withIdentifier: "ModelTVC", for: indexPath) as! ModelTVC
        cell.setContent(content:ModelOperation.sharedInstance.modelList[indexPath.row], indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.slectedRow = indexPath.row
        performSegue(withIdentifier: "info", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // check if the current row displayed is the last row to render
        if indexPath.row == (ModelOperation.sharedInstance.modelList.count - 1) && self.totalPageCount > self.page {
            self.getModelListFromWS()
        }else{
            cell.layer.transform = CATransform3DMakeTranslation(50.0, 50.0, 50.0)
            UIView.animate(withDuration: 0.8, animations: {
                cell.layer.transform = CATransform3DMakeTranslation(0.0, 0.0, 0.0)
            })
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc:InfoVC = segue.destination as? InfoVC, self.slectedRow != -1 {
            vc.manufacturer = ManufacturerOperation.sharedInstance.getValue(self.selectedManufacturerIndex, forKey: "title")
            vc.model = ModelOperation.sharedInstance.getValue(self.slectedRow, forKey: "title")
        }
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
    }
    
    func manufacturerlistReceived(response:AnyObject) -> Void {
        self.actindLoadMore.stopAnimating()
        if let res:[String:AnyObject] = response as? [String:AnyObject], let wkda:[String:String] = res["wkda"] as? [String:String] {
            self.page = self.page + 1
            self.totalPageCount = res["totalPageCount"] as! Int
            for (k,v) in wkda {
                ModelOperation.sharedInstance.modelList.append([
                    "key" : k,
                    "title" : v
                    ])
            }
            
            DispatchQueue.main.async {
                self.tblviewModel.reloadData()
            }
        }else {
            Utility.sharedInstance.showAlertOk(vc: self, title: "Error", message: "Invalid login")
        }
    }
    
    func getModelListFromWS() -> Void {
        if page > 0 {
            self.actindLoadMore.startAnimating()
        }
        NetworkManager.sharedInstance.callWs(isToShowLoader: (page == 0), vc: self, key: "Model", params: [
            "{manufacturer}" : "\(ManufacturerOperation.sharedInstance.getValue(self.selectedManufacturerIndex, forKey: "key"))",
            "{page}" : "\(page)",
            "{pageSize}" : "\(pageSize)",
            "{wa_key}" : "coding-puzzle-client-449cc9d"
            ], successCallback: manufacturerlistReceived, errorCallback:{_ in 
                    self.actindLoadMore.stopAnimating()
                    Utility.sharedInstance.showAlertOk(vc: self, title: "Error", message: "No response available")
        })
    }
    
}

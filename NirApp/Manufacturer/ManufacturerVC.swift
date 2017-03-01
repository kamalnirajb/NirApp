//
//  ManufacturerVC.swift
//  NirApp
//
//  Created by Niraj Kumar on 2/27/17.
//  Copyright © 2017 Niraj. All rights reserved.
//

import UIKit

class ManufacturerVC: ParentVC, UITableViewDelegate, UITableViewDataSource {
    
    var page = 0
    var pageSize = 10
    var totalPageCount = 0
    var selectedRow = -1
    
    
    @IBOutlet weak var actindLoadMore: UIActivityIndicatorView!
    @IBOutlet weak var tblviewManufacturers: UITableView!
    @IBOutlet weak var lblNoRecords: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getManufacturerListFromWS()
        self.actindLoadMore.stopAnimating()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ManufacturerOperation.sharedInstance.manufacturerList.count == 0 {
            self.lblNoRecords.isHidden = false
            self.tblviewManufacturers.isHidden = true
        }else {
            self.lblNoRecords.isHidden = true
            self.tblviewManufacturers.isHidden = false
        }
        
        return ManufacturerOperation.sharedInstance.manufacturerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ManufacturerTVC = tableView.dequeueReusableCell(withIdentifier: "ManufacturerTVC", for: indexPath) as! ManufacturerTVC
        cell.setContent(content: ManufacturerOperation.sharedInstance.manufacturerList[indexPath.row], indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRow = indexPath.row
        ModelOperation.sharedInstance.modelList = []
        performSegue(withIdentifier: "model", sender: nil)
    }
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // check if the current row displayed is the last row to render
        if indexPath.row == (ManufacturerOperation.sharedInstance.manufacturerList.count - 1) && self.totalPageCount > self.page{
            self.getManufacturerListFromWS()
        }else{
            cell.layer.transform = CATransform3DMakeScale(0.7,0.7,7)
            UIView.animate(withDuration: 0.8, animations: {
                cell.layer.transform = CATransform3DMakeScale(1,1,1)
            })
        }
        
    }
    
    func manufacturerlistReceived(response:AnyObject) -> Void {
        self.actindLoadMore.stopAnimating()
        if let res:[String:AnyObject] = response as? [String:AnyObject], let wkda:[String:String] = res["wkda"] as? [String:String] {
            self.page = self.page + 1
            self.totalPageCount = res["totalPageCount"] as! Int
            for (k,v) in wkda {
                ManufacturerOperation.sharedInstance.manufacturerList.append([
                    "key" : k,
                    "title" : v
                    ])
            }
            
            DispatchQueue.main.async {
                self.tblviewManufacturers.reloadData()
            }
        }else {
            Utility.sharedInstance.showAlertOk(vc: self, title: "Error", message: "No more record found.")
        }
    }
    
    func getManufacturerListFromWS() -> Void {
        if page > 0 {
            self.actindLoadMore.startAnimating()
        }
        NetworkManager.sharedInstance.callWs(isToShowLoader: (page == 0), vc: self, key: "Manufactuer", params: [
            "{page}" : "\(page)",
            "{pageSize}" : "\(pageSize)",
            "{wa_key}" : "coding-puzzle-client-449cc9d"
            ], successCallback: manufacturerlistReceived, errorCallback:{_ in
                self.actindLoadMore.stopAnimating()
                Utility.sharedInstance.showAlertOk(vc: self, title: "Error", message: "No response available")
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc:ModelVC = segue.destination as? ModelVC, selectedRow != -1 {
            vc.selectedManufacturerIndex = self.selectedRow
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
    }
    
}

//
//  ManufacturerOperation.swift
//  NirApp
//
//  Created by Niraj Kumar on 2/27/17.
//  Copyright © 2017 Niraj. All rights reserved.
//

import Foundation
import UIKit

class ManufacturerOperation {
    
    class var sharedInstance: ManufacturerOperation {
        struct Singleton {
            static let instance = ManufacturerOperation()
        }
        return Singleton.instance
    }
    
    var manufacturerList:[[String:String]] = []
    
    func getValue(_ index:NSInteger, forKey key:String) -> String {
        if manufacturerList.isEmpty == false, let manufacturer:String = (manufacturerList[index] as [String:String])[key] {
            return manufacturer
        }
        return ""
    }
    
}

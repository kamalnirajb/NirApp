//
//  ManufacturerOperation.swift
//  NirApp
//
//  Created by Niraj Kumar on 2/27/17.
//  Copyright © 2017 Niraj. All rights reserved.
//
import UIKit
import Foundation

class ModelOperation {
    
    class var sharedInstance: ModelOperation {
        struct Singleton {
            static let instance = ModelOperation()
        }
        return Singleton.instance
    }
    
    var modelList:[[String:String]] = []
    
    func getValue(_ index:NSInteger, forKey key:String) -> String {
        if modelList.isEmpty == false, let model:String = (modelList[index] as [String:String])[key] {
            return model
        }
        return ""
    }
    
}

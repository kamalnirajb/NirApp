//
//  NetworkManager.swift
//  Malomati
//
//  Created by Niraj Kumar on 1/26/17.
//  Copyright © 2017 Niraj Kumar. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration

class NetworkManager {
    
    let baseUrl:String = "http://api-aws-eu-qa-1.auto1-test.com/"
    let services = [
        "Manufactuer" : [
            "method" : "GET",
            "urlMethod" : "v1/car-types/manufacturer?page={page}&pageSize={pageSize}&wa_key={wa_key}",
            "headers": [
                "Content-Type": "application/json"
            ]
        ],
        "Model" : [
            "method" : "GET",
            "urlMethod" : "v1/car-types/main-types?manufacturer={manufacturer}&page={page}&pageSize={pageSize}&wa_key={wa_key}",
            "headers": [
                "Content-Type": "application/json"
            ]
        ]
    ]
    
    class var sharedInstance: NetworkManager {
        struct Singleton {
            static let instance = NetworkManager()
        }
        return Singleton.instance
    }
    
    func getUrlParams(key:String, params:[String:String]) -> [String:AnyObject] {
        if var urlParams:Dictionary<String, AnyObject> = services[key] as? Dictionary<String,AnyObject> {
            for (p,v) in params {
                if let m:String = urlParams["urlMethod"] as? String {
                    urlParams.updateValue(m.replacingOccurrences(of: p, with: v) as AnyObject, forKey: "urlMethod")
                }
            }
            return urlParams
        }
        
        return [:]
    }
    
    
    
    func callWs(isToShowLoader:Bool, vc: UIViewController, key:String, params:[String:String], successCallback:@escaping (_ response:AnyObject) -> Void, errorCallback:@escaping (_ response:Any) -> Void) -> Void {
        if isConnectedToNetwork() == false {
            Utility.sharedInstance.showAlertOk(vc: vc, title: "Error", message: "No internet connection")
        }else {
            let urlParams = self.getUrlParams(key: key, params: params)
            
            if let urlstr:String = urlParams["urlMethod"] as? String {
                if isToShowLoader {
                    Utility.sharedInstance.showAppLoader(vc: vc)
                }
                let url:URL = URL(string: "\(baseUrl)\(urlstr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)")!
                print(url.absoluteString)
                var urlRequest:URLRequest = URLRequest(url: url)
                if let m:String = urlParams["method"] as? String, m.compare("POST") == .orderedSame {
                    // Set the post body
                    urlRequest.httpMethod = "POST"
                    urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                }
                
                urlRequest.allHTTPHeaderFields = urlParams["headers"] as! [String : String]?
                let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                    Utility.sharedInstance.hideAppLoader(vc: vc)
                    if let httpResponse = response as? HTTPURLResponse {
                        if httpResponse.statusCode == 200 {
                            do {
                                guard error == nil else {
                                    print(error?.localizedDescription ?? "Error Occurred")
                                    Utility.sharedInstance.showAlertOk(vc: vc, title: "Error", message: (error?.localizedDescription)!)
                                    return
                                }
                                guard let data = data else {
                                    Utility.sharedInstance.showAlertOk(vc: vc, title: "Error", message: "No response available")
                                    return
                                }
                                let json:[String:AnyObject] = try JSONSerialization.jsonObject(with: data, options: []) as! [String:AnyObject]
                                successCallback(json as AnyObject)
                            }catch {
                                errorCallback(["message" : "Response not available" ])
                            }
                        }else {
                            errorCallback(["message" : "Response not available" ])
                        }
                    }else {
                        errorCallback(["message" : "Response not available" ])
                    }
                })
                
                task.resume()
            }
        }
    }
    
    func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
        
    }
    
}

//
//  ParentCustomView.swift
//  Malomati
//
//  Created by Niraj Kumar on 1/31/17.
//  Copyright © 2017 Niraj Kumar. All rights reserved.
//

import UIKit

class ParentCustomView: UIView {

    var view: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    
    func nibSetup() {
        self.backgroundColor = .clear
        self.view = self.loadViewFromNib()
        self.view.frame = self.bounds
        self.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.translatesAutoresizingMaskIntoConstraints = true
        self.addSubview(self.view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return nibView
    }
}

extension Date {
    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    func getDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter
    }
    
    func getDateString(with format:String) -> String {
        let dateformatter:DateFormatter = getDateFormatter()
        dateformatter.dateFormat = format
        let ds:String =  dateformatter.string(from: self)
        return ds != nil ? ds : ""
    }
    
    static func from(dateStr:String) -> Date {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: dateStr)!
    }
    
    static func parse(_ string: String, format: String = "yyyy-MM-dd") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = format
        
        let date = dateFormatter.date(from: string)!
        return date
    }
    
    func getDateComponents() -> DateComponents {
        return Calendar.current.dateComponents([.year, .month, .day, .weekday], from: self)
    }
    
    func getNumberOfDays() -> Int {
        return Calendar.current.range(of: .day, in: .month, for: self)!.count
    }
    
}

//
//  ViewController.swift
//  UDatePickerDemo
//
//  Created by wen on 16/7/21.
//  Copyright © 2016年 wenfeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var textGroup = [
        "Default",
        "MaximumDate is today. Picker locale is China.",
        "Custom date mode, transition, Color."
    ]
    var buttonGroup = [UIButton]()
    var datePickerGroup: [UDatePicker?] = [nil, nil, nil]
    var dateGroup = [NSDate(), NSDate(), NSDate()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for (index, text) in textGroup.enumerate() {
            
            // create label
            let label = UILabel(frame: CGRect(x: 16, y: 90 * index + 60, width: 300, height: 20))
            label.font = label.font.fontWithSize(14)
            label.text = text
            view.addSubview(label)
            
            // create button
            let button = UIButton(frame: CGRect(x: 16, y: 90 * index + 90, width: 160, height: 36))
            button.backgroundColor = view.tintColor
            button.setTitle("select a \(index == 2 ? "time": "date")", forState: .Normal)
            button.addTarget(self, action: #selector(self.showDatePicker(_:)), forControlEvents: .TouchUpInside)
            button.layer.cornerRadius = 4
            button.layer.masksToBounds = true
            button.tag = index
            view.addSubview(button)
        }
        
    }

    func showDatePicker(sender: UIButton) {
        let index = sender.tag
        if datePickerGroup[index] == nil {
            
            // init picker when it is nil
            let picker = UDatePicker(frame: view.frame, didDisappear: {date in
                if let date = date {
                    self.dateGroup[index] = date
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateStyle = .MediumStyle
                    
                    if index == 1 {
                        dateFormatter.locale = NSLocale(localeIdentifier: "zh_CN")
                    } else if index == 2 {
                        dateFormatter.dateFormat = "h:mm a"
                    }
                    
                    sender.setTitle(dateFormatter.stringFromDate(date), forState: .Normal)
                }
            })
            
            // config picker
            switch index {
            case 1:
                picker.picker.datePicker.maximumDate = NSDate()
                picker.picker.datePicker.locale = NSLocale(localeIdentifier: "zh_CN")
                picker.picker.doneButton.setTitle("完成", forState: .Normal)
            case 2:
                picker.picker.doneButton.setTitleColor(UIColor.redColor(), forState: .Normal)
                picker.picker.datePicker.backgroundColor = UIColor.groupTableViewBackgroundColor()
                picker.picker.datePicker.datePickerMode = .Time
                picker.modalTransitionStyle = .FlipHorizontal
            default:
                break
            }
            
            datePickerGroup[index] = picker
        }
        
        // set current date
        // present view controller
        datePickerGroup[index]!.picker.date = dateGroup[index]
        datePickerGroup[index]!.present(self)
    }
}


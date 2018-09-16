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
    var dateGroup = [Date(), Date(), Date()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for (index, text) in textGroup.enumerated() {
            
            // create label
            let label = UILabel(frame: CGRect(x: 16, y: 90 * index + 60, width: 300, height: 20))
            label.font = label.font.withSize(14)
            label.text = text
            view.addSubview(label)
            
            // create button
            let button = UIButton(frame: CGRect(x: 16, y: 90 * index + 90, width: 160, height: 36))
            button.backgroundColor = view.tintColor
            button.setTitle("select a \(index == 2 ? "time": "date")", for: UIControlState())
            button.addTarget(self, action: #selector(self.showDatePicker(_:)), for: .touchUpInside)
            button.layer.cornerRadius = 4
            button.layer.masksToBounds = true
            button.tag = index
            view.addSubview(button)
        }
        
    }

    @objc func showDatePicker(_ sender: UIButton) {
        let index = sender.tag
        if datePickerGroup[index] == nil {
            
            // init picker when it is nil
            let picker = UDatePicker(frame: view.frame, willDisappear: {date in
                if let date = date {
                    self.dateGroup[index] = date as Date
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateStyle = .medium
                    
                    if index == 1 {
                        dateFormatter.locale = Locale(identifier: "zh_CN")
                    } else if index == 2 {
                        dateFormatter.dateFormat = "h:mm a"
                    }
                    
                    sender.setTitle(dateFormatter.string(from: date as Date), for: UIControlState())
                }
            })
            
            // config picker
            switch index {
            case 1:
                picker.picker.datePicker.maximumDate = Date()
                picker.picker.datePicker.locale = Locale(identifier: "zh_CN")
                picker.picker.doneButton.setTitle("完成", for: UIControlState())
            case 2:
                picker.picker.doneButton.setTitleColor(UIColor.red, for: UIControlState())
                picker.picker.datePicker.backgroundColor = UIColor.groupTableViewBackground
                picker.picker.datePicker.datePickerMode = .time
                picker.modalTransitionStyle = .flipHorizontal
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


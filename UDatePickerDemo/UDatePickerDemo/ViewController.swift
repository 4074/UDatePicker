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
        "Custom transition. Custom Color."
    ]
    var buttonGroup = [UIButton]()
    var datePickerGroup: [UDatePicker?] = [nil, nil, nil]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for (index, text) in textGroup.enumerate() {
            let label = UILabel(frame: CGRect(x: 16, y: 80 * (index + 1), width: 300, height: 20))
            label.font = label.font.fontWithSize(14)
            label.text = text
            view.addSubview(label)
            
            let button = UIButton(frame: CGRect(x: 16, y: 28 + 80 * (index + 1), width: 120, height: 32))
            button.backgroundColor = view.tintColor
            button.setTitle("select a date", forState: .Normal)
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
            let picker = UDatePicker(frame: view.frame, didDisappear: {date in
                
            })
            
            switch index {
            case 1:
                picker.picker.datePicker.maximumDate = NSDate()
                picker.picker.datePicker.locale = NSLocale(localeIdentifier: "zh_CN")
            case 2:
                picker.picker.doneButton.setTitleColor(UIColor.redColor(), forState: .Normal)
                picker.picker.datePicker.backgroundColor = UIColor.groupTableViewBackgroundColor()
                picker.modalTransitionStyle = .FlipHorizontal
            default:
                break
            }
            
            datePickerGroup[index] = picker
        }
        
        datePickerGroup[index]!.present(self)
    }
}


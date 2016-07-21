//
//  DatePickerView.swift
//  udata
//
//  Created by wen on 16/6/12.
//  Copyright © 2016年 netease. All rights reserved.
//

import UIKit

class UDatePicker: UIViewController {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal var picker: UDatePickerView!
    
    init(frame: CGRect, didDisappear: ((NSDate?) -> Void)? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .OverFullScreen
        
        let view = UDatePickerView(frame: frame)
        view.didDisappear = { date in
            if didDisappear != nil {
                didDisappear!(date)
            }
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        picker = view
        self.view = view
    }
    
    internal func present(previous: UIViewController) {
        previous.presentViewController(self, animated: true, completion: nil)
    }
    
    internal class UDatePickerView: UIView {
        
        internal var didDisappear: ((NSDate?) -> Void)?
        
        internal var date = NSDate() {
            didSet {
                datePicker.setDate(date, animated: false)
            }
        }
        
        internal var duration = 0.4
        
        internal var height = (
            widget: CGFloat(248),
            picker: CGFloat(216),
            bar: CGFloat(32)
        )
        
        internal var width = (
            button: CGFloat(56)
        )
        
        internal let blankView = UIView()
        
        internal let widgetView = UIView()
        internal let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .ExtraLight))
        
        internal let datePicker = UIDatePicker()
        internal let barView = UIView()
        internal let doneButton = UIButton()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            initView()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func layoutSubviews() {
            let frame = self.frame
            
            widgetView.frame = CGRect(x: 0, y: frame.height - height.widget, width: frame.width, height: height.widget)
            blurView.frame = CGRect(x: 0, y: 0, width: frame.width, height: height.bar)
            
            blankView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height - height.widget)
            
            datePicker.frame = CGRect(x: 0, y: height.bar, width: frame.width, height: height.widget)
            
            barView.frame = CGRect(x: 0, y: 0, width: frame.width, height: height.bar)
            doneButton.frame = CGRect(x: frame.width - width, y: 0, width: width, height: height.bar)
        }
        
        private func initView() {
            
            self.addSubview(widgetView)
            
            widgetView.addSubview(blurView)
            blurView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            
            self.addSubview(blankView)
            let tapBlankGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapBlankView))
            blankView.addGestureRecognizer(tapBlankGesture)
            
            widgetView.addSubview(datePicker)
            datePicker.datePickerMode = .Date
            datePicker.backgroundColor = UIColor.whiteColor()

            widgetView.addSubview(barView)
            
            barView.addSubview(doneButton)
            doneButton.titleLabel?.font = UIFont.systemFontOfSize(16)
            doneButton.setTitle("Done", forState: .Normal)
            doneButton.setTitleColor(self.tintColor, forState: .Normal)
            doneButton.addTarget(self, action: #selector(self.tapDoneButton), forControlEvents: .TouchUpInside)
        }
        
        func tapBlankView() {
            if didDisappear != nil {
                didDisappear!(nil)
            }
        }
        
        func tapDoneButton() {
            if didDisappear != nil {
                didDisappear!(datePicker.date)
            }
        }
    }
}

//
//  DatePickerView.swift
//
//  Created by 4074 on 16/6/12.
//  Copyright © 2016年 4074. All rights reserved.
//

import UIKit

public class UDatePicker: UIViewController {
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var picker: UDatePickerView!
    
    public init(frame: CGRect, willDisappear: ((NSDate?) -> Void)? = nil, didDisappear: ((NSDate?) -> Void)? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
        
        // init picker view
        let view = UDatePickerView(frame: frame)
        view.didDisappear = { date in
            if willDisappear != nil {
                willDisappear!(date)
            }
            self.dismissViewControllerAnimated(true) {
                if didDisappear != nil {
                    didDisappear!(date)
                }
            }
        }
        picker = view
        self.view = view
    }
    
    // present the view controller
    public func present(previous: UIViewController) {
        previous.presentViewController(self, animated: true, completion: nil)
    }
    
    public class UDatePickerView: UIView {
        
        private var didDisappear: ((NSDate?) -> Void)?
        
        // current date be shown
        public var date = NSDate() {
            didSet {
                datePicker.setDate(date, animated: false)
            }
        }
        
        public var duration = 0.4
        
        // height of views
        public var height = (
            widget: CGFloat(248),
            picker: CGFloat(216),
            bar: CGFloat(32)
        )
        
//        // width of views
//        public var width = (
//            button: CGFloat(56)
//        )
        
        public let widgetView = UIView()
        public let blankView = UIView()
        public let blurView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.ExtraLight))
        
        public let datePicker = UIDatePicker()
        public let barView = UIView()
        public let doneButton = UIButton()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            initView()
        }
        
        required public init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override public func layoutSubviews() {
            let frame = self.frame
            
            // reset frame of views
            widgetView.frame = CGRect(x: 0, y: frame.height - height.widget, width: frame.width, height: height.widget)
            blankView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height - height.widget)
            
            datePicker.frame = CGRect(x: 0, y: height.bar, width: frame.width, height: height.picker)
            
            barView.frame = CGRect(x: 0, y: 0, width: frame.width, height: height.bar)
            blurView.frame = barView.frame
            
            doneButton.sizeToFit()
            let width = doneButton.frame.size.width + 15 /*padding*/
            doneButton.frame = CGRect(x: frame.width - width, y: 0, width: width, height: height.bar)
        }
        
        private func initView() {
            
            self.addSubview(widgetView)
            
            // blur view
            widgetView.addSubview(blurView)
            blurView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            
            // blank view
            self.addSubview(blankView)
            let tapBlankGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapBlankView))
            blankView.addGestureRecognizer(tapBlankGesture)
            
            // date picker view
            widgetView.addSubview(datePicker)
            datePicker.datePickerMode = .Date
            datePicker.backgroundColor = UIColor.whiteColor()
            
            // bar view and done button
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

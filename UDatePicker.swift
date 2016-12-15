//
//  DatePickerView.swift
//
//  Created by 4074 on 16/6/12.
//  Copyright © 2016年 4074. All rights reserved.
//

import UIKit

open class UDatePicker: UIViewController {
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open var picker: UDatePickerView!
    
    public init(frame: CGRect, willDisappear: ((Date?) -> Void)? = nil, didDisappear: ((Date?) -> Void)? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        
        // init picker view
        let view = UDatePickerView(frame: frame)
        view.didDisappear = { date in
            if willDisappear != nil {
                willDisappear!(date)
            }
            self.dismiss(animated: true) {
                if didDisappear != nil {
                    didDisappear!(date)
                }
            }
        }
        picker = view
        self.view = view
    }
    
    // present the view controller
    open func present(_ previous: UIViewController) {
        previous.present(self, animated: true, completion: nil)
    }
    
    open class UDatePickerView: UIView {
        
        fileprivate var didDisappear: ((Date?) -> Void)?
        
        // current date be shown
        open var date = Date() {
            didSet {
                datePicker.setDate(date, animated: false)
            }
        }
        
        open var duration = 0.4
        
        // height of views
        open var height = (
            widget: CGFloat(248),
            picker: CGFloat(216),
            bar: CGFloat(32)
        )
        
//        // width of views
//        public var width = (
//            button: CGFloat(56)
//        )
        
        open let widgetView = UIView()
        open let blankView = UIView()
        open let blurView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.extraLight))
        
        open let datePicker = UIDatePicker()
        open let barView = UIView()
        open let doneButton = UIButton()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            initView()
        }
        
        required public init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override open func layoutSubviews() {
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
        
        fileprivate func initView() {
            
            self.addSubview(widgetView)
            
            // blur view
            widgetView.addSubview(blurView)
            blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            // blank view
            self.addSubview(blankView)
            let tapBlankGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapBlankView))
            blankView.addGestureRecognizer(tapBlankGesture)
            
            // date picker view
            widgetView.addSubview(datePicker)
            datePicker.datePickerMode = .date
            datePicker.backgroundColor = UIColor.white
            
            // bar view and done button
            widgetView.addSubview(barView)
            barView.addSubview(doneButton)
            doneButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            doneButton.setTitle("Done", for: UIControlState())
            doneButton.setTitleColor(self.tintColor, for: UIControlState())
            doneButton.addTarget(self, action: #selector(self.tapDoneButton), for: .touchUpInside)
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

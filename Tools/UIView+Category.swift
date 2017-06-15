//
//  UIView+Category.swift
//  ly
//
//  Created by 李勇 on 2017/6/5.
//  Copyright © 2017年 ly. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    //添加点击事件
    func addTapAction(action:Selector, target:Any) {
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target:target, action:action)
        self.addGestureRecognizer(tap)
    }
    
    var x : CGFloat!{
        get {
            return self.frame.origin.x
        }
        set {
            var tempFrame : CGRect = frame
            tempFrame.origin.x = newValue
            frame = tempFrame
        }
    }
    var y : CGFloat!{
        get {
            return self.frame.origin.y
        }
        set {
            var tempFrame : CGRect = frame
            tempFrame.origin.y = newValue
            frame = tempFrame
        }
    }
    var center_x : CGFloat {
        get {
            return self.center.x
        }
        set {
            var tempCenter = center
            tempCenter.x = newValue
            center = tempCenter
        }
    }
    var center_y : CGFloat {
        get {
            return self.center.y
        }
        set {
            var tempCenter = center
            tempCenter.y = newValue
            center = tempCenter
        }
    }
    var w : CGFloat!{
        get {
            return self.frame.size.width
        }
        set {
            var tempFrame : CGRect = frame
            tempFrame.size.width = newValue
            frame = tempFrame
        }
    }
    var h : CGFloat!{
        get {
            return self.frame.size.height
        }
        set {
            var tempFrame : CGRect = frame
            tempFrame.size.height = newValue
            frame = tempFrame
        }
    }

    
}

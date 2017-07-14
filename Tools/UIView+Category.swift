//
//  UIView+Category.swift
//  ly
//   _
//  | |      /\   /\
//  | |      \ \_/ /
//  | |       \_~_/
//  | |        / \
//  | |__/\    [ ]
//  |_|__,/    \_/
//
//  Created by ly on 2017/6/5.
//  Copyright © 2017年 ly. All rights reserved.
//

import Foundation
import UIKit


let kScreenW = UIScreen.main.bounds.width
let kScreenH = UIScreen.main.bounds.height

typealias UIViewCategoryActionBlock = () -> Void
var tapActionBlock : UIViewCategoryActionBlock?



extension UIView{
    //添加点击事件
    func addTapAction(action:Selector, target:Any) {
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target:target, action:action)
        self.addGestureRecognizer(tap)
    }
    
    func addTapActionBlock(action : UIViewCategoryActionBlock?) {
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target:self, action:#selector(UIView.testHandle))
        self.addGestureRecognizer(tap)
        if (action != nil){
            tapActionBlock = action
        }
        //        objc_setAssociatedObject(self, "testtesttesttesttest", action, .OBJC_ASSOCIATION_COPY_NONATOMIC)
    }
    
    func testHandle()  {
        if ((tapActionBlock) != nil){
            tapActionBlock!()
        }
        //        let block : (() -> Void) = objc_getAssociatedObject(self, "testtesttesttesttest") as! (() -> Void)
        //            block()
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
    //    var ly_center : CGPoint {
    //        get {
    //            return self.ly_center
    //        }
    //        set {
    //            var tempCenter = center
    //            tempCenter.x = newValue
    //            center = tempCenter
    //        }
    //    }
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
    
    
    func loadFromNib(nibName:String){
        let shadow = UIView.loadFromNibName(nibName: nibName)
        shadow.frame = self.bounds
        self.addSubview(shadow)
    }
    class func loadFromNib() -> UIView{
        let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        let nibName = NSStringFromClass(self).replacingOccurrences(of: nameSpace + ".", with: "")
        return self.loadFromNibName(nibName: nibName)
    }
    
    class func loadFromNibName(nibName:String) -> UIView{
        return UINib.init(nibName: nibName, bundle: Bundle.main).instantiate(withOwner: nil, options: nil).last as! UIView
    }
    
}


extension UIImage{
    func reSizeImage(reSize:CGSize)->UIImage {
        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale);
        self.draw(in: CGRect.init(x: 0, y: 0, width: reSize.width, height: reSize.height));
        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        return reSizeImage;
    }
}

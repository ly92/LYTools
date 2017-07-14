//
//  LYAlertView.swift
//  ly
//   _
//  | |      /\   /\
//  | |      \ \_/ /
//  | |       \_~_/
//  | |        / \
//  | |__/\    [ ]
//  |_|__,/    \_/
//
//  Created by ly on 2017/6/29.
//  Copyright © 2017年 ly. All rights reserved.
//

import UIKit
import QuartzCore

let KTitltOringy:CGFloat = 15.0
let KTitltHeight:CGFloat = 25.0
let KContentOringy:CGFloat = 30.0
let KBetweenLableOffset:CGFloat = 20.0
let KAlertWidth:CGFloat = 245.0
let KAlertHeight:CGFloat = 160.0

typealias leftBlock = () ->()
typealias rightBlock = ()->()
typealias DelaydismissBlock = ()->()


class LYAlertView: UIView {
    
    var leftblock : leftBlock?
    var rightblock : rightBlock?
    var dismissblock : DelaydismissBlock?
    var alertTitleLabel : UILabel?
    var alertContentLabel : UILabel?
    var leftBtn : UIButton?
    var rightBtn : UIButton?
    var backImageView:UIView?
    
    var delayTime:Int64 = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        self.addTapActionBlock {
            if (self.dismissblock != nil){
                self.dismissblock!()
            }
            self.removeFromSuperview()
        }
    }
    
    //没有按钮
    func initBody(title:String,message:String,DismissDelay:Int64)
    {
        self.delayTime = DismissDelay
        self.initTwoBtn(title: title, message: message, cancelButtonTitle: "", otherButtonTitle: "")
    }
    //一个按钮
    func initOneBtn(title:String,message:String,ButtonTitle:String)
    {
        self.initTwoBtn(title: title, message: message, cancelButtonTitle: "", otherButtonTitle: ButtonTitle)
    }
    //两个按钮
    func initTwoBtn(title:String,message:String,cancelButtonTitle:String,otherButtonTitle:String) {
        
        //super.init(frame: CGRectZero)
        backImageView = UIImageView(frame: CGRect(x:0, y:0, width:KAlertWidth, height:KAlertHeight))
        backImageView?.center = self.center
        backImageView?.backgroundColor = UIColor.RGBS(s: 250)
        backImageView?.layer.cornerRadius = 15.0
        backImageView?.isUserInteractionEnabled = true
        self.addSubview(backImageView!)
        
        
        alertTitleLabel = UILabel(frame: CGRect(x:0, y:KTitltOringy, width:KAlertWidth, height:KTitltHeight))
        alertTitleLabel!.font = UIFont.boldSystemFont(ofSize: 20.0)
        alertTitleLabel!.textColor = UIColor(red:56.0/255.0,green:64.0/255.0,blue:71.0/255.0,alpha:1)
        backImageView?.addSubview(alertTitleLabel!)
        
        
        let contentLabelWidth = KAlertWidth - 16
        alertContentLabel = UILabel(frame:CGRect(x:(KAlertWidth - contentLabelWidth) * 0.5, y:alertTitleLabel!.frame.maxY, width:contentLabelWidth, height:60))
        alertContentLabel!.numberOfLines = 0
        alertContentLabel!.textAlignment = NSTextAlignment.center
        alertTitleLabel!.textAlignment = NSTextAlignment.center
        alertContentLabel!.textColor = UIColor(red:127.0/255.0,green:127.0/255.0,blue:127.0/255.0,alpha:1)
        alertContentLabel!.font = UIFont.systemFont(ofSize: 15.0)
        backImageView?.addSubview(alertContentLabel!)
        
        alertTitleLabel!.text = title as String
        alertContentLabel!.text = message as String
        
        let KSingleButtonWidth:CGFloat = 160.0
        let kCoupleButtonWidth:CGFloat = 107.0
        let kButtonHeight:CGFloat = 40.0
        let kButtonBottomOffset:CGFloat = 10.0
        
        //没有按钮
        if cancelButtonTitle.isEmpty && otherButtonTitle.isEmpty{
            alertTitleLabel?.frame.origin.y = KTitltOringy+20
            alertContentLabel?.frame.size.height = 100
            if(self.delayTime==0){
                self.delayTime = 2
            }
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double((Int64)(UInt64(self.delayTime) * NSEC_PER_SEC)) / Double(NSEC_PER_SEC), execute: {
                if (self.dismissblock != nil){
                    self.dismissblock!()
                }
                self.removeFromSuperview()
            })
            return
        }else if !cancelButtonTitle.isEmpty && !otherButtonTitle.isEmpty {
            //两个按钮
            let leftBtnFrame = CGRect(x:(KAlertWidth - 2 * kCoupleButtonWidth - kButtonBottomOffset) * 0.5, y:KAlertHeight - kButtonBottomOffset/2.0 - kButtonHeight, width:kCoupleButtonWidth, height:kButtonHeight);
            let rightBtnFrame = CGRect(x:leftBtnFrame.maxX + kButtonBottomOffset, y:KAlertHeight - kButtonBottomOffset/2.0 - kButtonHeight, width:kCoupleButtonWidth, height:kButtonHeight);
            leftBtn = UIButton(frame:leftBtnFrame);
            rightBtn = UIButton(frame:rightBtnFrame)
            
            //        rightBtn!.setBackgroundImage( UIImage(named: "button_orange_normal") ,for:UIControlState.normal)
            //        rightBtn!.setBackgroundImage( UIImage(named: "button_orange_click") ,for:UIControlState.selected)
            rightBtn!.setTitle(otherButtonTitle as String, for: UIControlState.normal)
            rightBtn!.titleLabel!.font = UIFont.boldSystemFont(ofSize: 14)
            rightBtn!.setTitleColor(UIColor.RGBS(s: 33),for:UIControlState.normal)
            rightBtn!.addTarget(self, action: #selector(LYAlertView.rightBtnClicked), for: UIControlEvents.touchUpInside)
            rightBtn!.layer.masksToBounds = true
            rightBtn!.layer.cornerRadius = 3.0
            backImageView?.addSubview(rightBtn!)
            
            //按钮上面的线
            let topLine = UIView.init(frame: CGRect(x:0, y:KAlertHeight - kButtonBottomOffset - kButtonHeight, width:KAlertWidth, height:1.5))
            topLine.backgroundColor = UIColor.RGBS(s: 240)
            backImageView?.addSubview(topLine)
            
            
            //按钮之间的线
            let bottomLine = UIView.init(frame: CGRect(x:leftBtnFrame.maxX + kButtonBottomOffset/2.0, y:KAlertHeight - kButtonBottomOffset - kButtonHeight, width:1.5, height:kButtonHeight + kButtonBottomOffset))
            bottomLine.backgroundColor = UIColor.RGBS(s: 240)
            backImageView?.addSubview(bottomLine)
            
        }else{
            //按钮上面的线
            let topLine = UIView.init(frame: CGRect(x:0, y:KAlertHeight - kButtonBottomOffset - kButtonHeight, width:KAlertWidth, height:1.5))
            topLine.backgroundColor = UIColor.RGBS(s: 240)
            backImageView?.addSubview(topLine)
            //一个按钮
            leftBtn = UIButton(frame:CGRect(x:(KAlertWidth-KSingleButtonWidth)/2, y:KAlertHeight - kButtonBottomOffset/2.0 - kButtonHeight, width:KSingleButtonWidth, height:kButtonHeight))
        }
        
        //            leftBtn?.setBackgroundImage(UIImage(named: "button_white_normal"), for: UIControlState.normal)
        //            leftBtn?.setBackgroundImage(UIImage(named: "button_white_clicked"), for: UIControlState.selected)
        leftBtn!.setTitle(cancelButtonTitle as String, for: UIControlState.normal)
        leftBtn!.titleLabel!.font = UIFont.boldSystemFont(ofSize: 14)
        leftBtn!.setTitleColor(UIColor.RGBS(s: 33),for:UIControlState.normal)
        leftBtn!.addTarget(self, action: #selector(LYAlertView.leftBtnClicked), for: UIControlEvents.touchUpInside)
        leftBtn!.layer.masksToBounds = true
        backImageView?.addSubview(leftBtn!)
        leftBtn!.layer.masksToBounds = true
        leftBtn!.layer.cornerRadius = 3.0
    }
    
    func leftBtnClicked(){
        if (self.leftblock != nil){
            self.leftblock!()
        }
        self.dismiss()
    }
    
    func rightBtnClicked(){
        if (self.rightblock != nil){
            self.rightblock!()
        }
        self.dismiss()
    }
    //MARK: - 显示
    //2个按钮
    class func show( _ title:String, _ message:String, _ leftTitle:String, _ rightTitle:String, _ rightClick:rightBlock? = nil, _ leftClick:leftBlock? = nil, _ dismissBlock:DelaydismissBlock? = nil)->Void{
        let alert = LYAlertView.init(frame: CGRect(x:0, y:0, width:UIScreen.main.bounds.width, height:UIScreen.main.bounds.height))
        alert.initTwoBtn(title: title, message: message, cancelButtonTitle: leftTitle, otherButtonTitle: rightTitle)
        alert.occur(animation: true)
        
        alert.leftblock = leftClick
        alert.rightblock = rightClick
        alert.dismissblock = dismissBlock
    }
    
    //1个按钮
    class func show( _ title:String, _ message:String, _ leftTitle:String, _ leftClick:leftBlock? = nil, _ dismissBlock:DelaydismissBlock? = nil)->Void{
        self.show(title, message, leftTitle, "", nil, leftClick, dismissBlock)
    }
    
    //0个按钮
    class func show( _ title:String, _ message:String, _ dismissBlock:DelaydismissBlock? = nil)->Void{
        self.show(title, message, "", "", nil, nil, dismissBlock)
    }
    
    func occur(animation:Bool) -> Void{
        
        UIApplication.shared.keyWindow?.addSubview(self)
        UIApplication.shared.keyWindow?.bringSubview(toFront: self)
        
        if animation {
            
            UIView.animate(withDuration: 0.1, delay: 0, options:
                UIViewAnimationOptions.transitionCrossDissolve, animations: { () -> Void in
                    self.alpha = 1.0
                    self.backImageView?.layer.setAffineTransform(CGAffineTransform(scaleX: 0.9, y: 0.9))
            }) { (Bool) -> Void in
                UIView.animate(withDuration: 0.1, delay: 0, options: UIViewAnimationOptions.transitionCrossDissolve, animations: { () -> Void in
                    self.backImageView?.layer.setAffineTransform(CGAffineTransform(scaleX: 1.1, y: 1.1))
                }) { (Bool) -> Void in
                    UIView.animate(withDuration: 0.1, delay: 0, options: UIViewAnimationOptions.transitionCrossDissolve, animations: { () -> Void in
                        self.backImageView?.layer.setAffineTransform(CGAffineTransform(scaleX: 0.9, y: 0.9))
                    }) { (Bool) -> Void in
                        self.backImageView?.layer.setAffineTransform(CGAffineTransform(scaleX: 1.0, y: 1.0))
                    }
                }
            }
        }
    }
    
    func dismiss() -> Void{
        UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions.transitionCrossDissolve, animations: { () -> Void in
            self.alpha = 0
        }) { (Bool) -> Void in
            self.removeFromSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

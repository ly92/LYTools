//
//  LYSwitch.swift
//  ly
//   _
//  | |      /\   /\
//  | |      \ \_/ /
//  | |       \_~_/
//  | |        / \
//  | |__/\    [ ]
//  |_|__,/    \_/
//
//  Created by 李勇 on 2017/6/13.
//  Copyright © 2017年 ly. All rights reserved.
//

import UIKit

@objc
protocol LYSwitchDelegate : NSObjectProtocol{
    @objc func lySwitchChangeIndex(lySwitch:LYSwitch, index:NSInteger)
}

class LYSwitch: UIView {
    
    
    typealias LYSwitchBlock = (LYSwitch,NSInteger) -> Void
    var ly_SwitchBlock : LYSwitchBlock?
    
    
    //右按钮名称
    var rightTitle : String {
        didSet{
            self.rightBtn.setTitle(self.rightTitle, for: .normal)
        }
    }
    //左按钮名
    var leftTitle : String{
        didSet{
            self.leftBtn.setTitle(self.leftTitle, for: .normal)
            self.thumbLbl.text = self.leftTitle
        }
    }
    //右安扭标题颜色
    var rightTitleColor : UIColor {
        didSet{
            self.rightBtn.setTitleColor(self.rightTitleColor, for: .normal)
        }
    }
    //左按钮标题颜色
    var leftTitleColor : UIColor{
        didSet{
            self.leftBtn.setTitleColor(self.leftTitleColor, for: .normal)
        }
    }
    //背景颜色
    var bgColor : UIColor{
        didSet{
            self.backgroundColor = self.bgColor
        }
    }
    //滑块标题颜色
    var thumbTitleColor : UIColor{
        didSet{
            self.thumbLbl.textColor = self.thumbTitleColor
        }
    }
    //滑块背景色
    var thumbColor : UIColor{
        didSet{
            self.thumbLbl.backgroundColor = self.thumbColor
        }
    }
    
    
    let rightBtn = UIButton(type: .custom)
    let leftBtn = UIButton(type: .custom)
    let thumbLbl = UILabel()
    
    var delegate : LYSwitchDelegate?
    
    
    init(frame:CGRect, tag:Int, delegate: LYSwitchDelegate) {
        self.rightTitle = "右标题"
        self.leftTitle = "左标题"
        self.rightTitleColor = UIColor.white
        self.leftTitleColor = UIColor.white
        self.bgColor = UIColor.red
        self.thumbColor = UIColor.white
        self.thumbTitleColor = UIColor.red
        
        self.delegate = delegate
        
        super.init(frame:frame)
        self.frame = frame
        self.tag = tag
        self.setUpleftAndRightBtns()
    }
    
    init(frame:CGRect, delegate: LYSwitchDelegate) {
        self.rightTitle = "右标题"
        self.leftTitle = "左标题"
        self.rightTitleColor = UIColor.white
        self.leftTitleColor = UIColor.white
        self.bgColor = UIColor.red
        self.thumbColor = UIColor.white
        self.thumbTitleColor = UIColor.red
        
        self.delegate = delegate
        
        super.init(frame:frame)
        self.frame = frame
        self.setUpleftAndRightBtns()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

extension LYSwitch{
    func setUpleftAndRightBtns() {
        //切边弧
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.height/2.0
        self.backgroundColor = self.bgColor
        
        /*
         左button
         */
        self.leftBtn.frame = CGRect(x:0, y:0, width:self.frame.width/2.0, height:self.frame.height)
        self.leftBtn.setTitle(self.leftTitle, for: .normal)
        self.leftBtn.backgroundColor = UIColor.clear
        self.leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.leftBtn.setTitleColor(self.leftTitleColor, for: .normal)
        self.leftBtn.addTarget(self, action: #selector(LYSwitch.leftBtnAction), for: .touchUpInside)
        
        /*
         右button
         */
        self.rightBtn.frame = CGRect(x:self.frame.width/2.0, y:0, width:self.frame.width/2.0, height:self.frame.height)
        self.rightBtn.setTitle(self.rightTitle, for: .normal)
        self.rightBtn.backgroundColor = UIColor.clear
        self.rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.rightBtn.setTitleColor(self.rightTitleColor, for: .normal)
        self.rightBtn.addTarget(self, action: #selector(LYSwitch.rightBtnAction), for: .touchUpInside)
        
        /*
         thumb滑动条
         */
        self.thumbLbl.frame = CGRect(x:1, y:1, width:self.frame.width/2.0, height:self.frame.height - 2)
        self.thumbLbl.clipsToBounds = true
        //切边弧
        self.thumbLbl.layer.cornerRadius = self.frame.height/2.0 - 1
        self.thumbLbl.backgroundColor = self.thumbColor
        self.thumbLbl.textColor = UIColor.red
        self.thumbLbl.text = self.leftTitle
        self.thumbLbl.font = UIFont.systemFont(ofSize: 14)
        self.thumbLbl.textAlignment = .center
        //添加手势
        let pan = UIPanGestureRecognizer(target:self, action:#selector(changed(sender:)))
        pan.delegate = self as? UIGestureRecognizerDelegate
        self.addGestureRecognizer(pan)
        
        
        self.addSubview(self.rightBtn)
        self.addSubview(self.leftBtn)
        self.addSubview(self.thumbLbl)
        
    }
}


extension LYSwitch{
    @objc func leftBtnAction()  {
        if self.thumbLbl.x == 1{
            return;
        }
        self.thumbLbl.text = self.leftTitle
        UIView.animate(withDuration: 0.3) {
            self.thumbLbl.frame = CGRect(x:1, y:1, width:self.frame.width/2.0, height:self.frame.height - 2)
            self.delegate?.lySwitchChangeIndex(lySwitch: self, index: 1)
            if (self.ly_SwitchBlock != nil){
                self.ly_SwitchBlock!(self,1)
            }
        }
        
    }
    
    @objc func rightBtnAction() {
        if self.thumbLbl.x == self.frame.width/2.0 - 2{
            return;
        }
        self.thumbLbl.text = self.rightTitle
        UIView.animate(withDuration: 0.3) {
            self.thumbLbl.frame = CGRect(x:self.frame.width/2.0 - 2, y:1, width:self.frame.width/2.0, height:self.frame.height - 2)
            self.delegate?.lySwitchChangeIndex(lySwitch: self, index: 2)
            if (self.ly_SwitchBlock != nil){
                self.ly_SwitchBlock!(self,2)
            }
        }
        
    }
    
    /// 手势处理
    ///
    /// - Parameter sender: 手势
    func changed(sender:UIPanGestureRecognizer) {
        var point = sender.translation(in: self.thumbLbl)
        
        if point.x > 0{
            /*向右*/
            if self.thumbLbl.x == self.frame.width/2.0 - 2{
                return;
            }
            
            //1.移动最大距离
            if (point.x > self.frame.width/2.0 - 2){
                point.x = self.frame.width/2.0 - 2
            }
            //2.移动滑块
            self.thumbLbl.x = point.x
            
            //3.停止滑动
            if sender.state == UIGestureRecognizerState.ended{
                if point.x > self.frame.width / 4.0{
                    //滑动超过了thumb的一半
                    self.thumbLbl.frame = CGRect(x:self.frame.width/2.0 - 2, y:1, width:self.frame.width/2.0, height:self.frame.height - 2)
                    self.thumbLbl.text = self.rightTitle
                    //代理方法
                    self.delegate?.lySwitchChangeIndex(lySwitch: self, index: 2)
                    if (self.ly_SwitchBlock != nil){
                        self.ly_SwitchBlock!(self,2)
                    }
                }else{
                    //滑动未超过thumb的一半
                    self.thumbLbl.frame = CGRect(x:1, y:1, width:self.frame.width/2.0, height:self.frame.height - 2)
                }
            }
        }else{
            //向左
            if self.thumbLbl.x == 1{
                return;
            }
            
            //1.移动最大距离
            var pointX = -point.x
            
            if (pointX > self.frame.width/2.0 - 2){
                pointX = self.frame.width/2.0 - 2
            }
            //2.移动滑块
            self.thumbLbl.x = self.frame.width/2.0 - 2 - pointX
            
            //3.停止滑动
            if sender.state == UIGestureRecognizerState.ended{
                if pointX > self.frame.width / 4.0{
                    //滑动超过了thumb的一半
                    self.thumbLbl.frame = CGRect(x:1, y:1, width:self.frame.width/2.0, height:self.frame.height - 2)
                    self.thumbLbl.text = self.leftTitle
                    //代理方法
                    self.delegate?.lySwitchChangeIndex(lySwitch: self, index: 1)
                    if (self.ly_SwitchBlock != nil){
                        self.ly_SwitchBlock!(self,1)
                    }
                }else{
                    //滑动未超过thumb的一半
                    self.thumbLbl.frame = CGRect(x:self.frame.width/2.0 - 2, y:1, width:self.frame.width/2.0, height:self.frame.height - 2)
                }
            }
        }
    }
}











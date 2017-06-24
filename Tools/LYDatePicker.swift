//
//  LYDatePicker.swift
//  ly
//   _
//  | |      /\   /\
//  | |      \ \_/ /
//  | |       \_~_/
//  | |        / \
//  | |__/\    [ ]
//  |_|__,/    \_/
//
//  Created by ly on 2017/6/23.
//  Copyright © 2017年 ly. All rights reserved.
//

import UIKit

let kScreenW = UIScreen.main.bounds.width
let kScreenH = UIScreen.main.bounds.height

@objc
protocol LYDatePickerDelete : NSObjectProtocol{
    @objc func ly_datePickerChoosedTime(date:Date)
}

class LYDatePicker: UIControl {
    
    var component : Int = 3
    
    var delegate : LYDatePickerDelete?
    
    var date = Date()
    var year = Date.currentYear()
    var month = Date.currentMonth()
    var day = Date.currentDay()
    var hour = Date.currentHour()
    var minute = Date.currentMinute()
    
    let yearEerliest = 1900//年份从1900年开始
    let yearSum = 200//年份一共有200个选择
    
    //点击确定后的block回调
    typealias OneComponentBlock = (Date,NSInteger) -> Void
    var ly_datepickerWithOneComponent : OneComponentBlock?
    typealias TwoComponentBlock = (Date,NSInteger,NSInteger) -> Void
    var ly_datepickerWithTwoComponent : TwoComponentBlock?
    typealias ThreeComponentBlock = (Date,NSInteger,NSInteger,NSInteger) -> Void
    var ly_datepickerWithThreeComponent : ThreeComponentBlock?
    typealias FourComponentBlock = (Date,NSInteger,NSInteger,NSInteger,NSInteger) -> Void
    var ly_datepickerWithFourComponent : FourComponentBlock?
    typealias FiveComponentBlock = (Date,NSInteger,NSInteger,NSInteger,NSInteger,NSInteger) -> Void
    var ly_datepickerWithFiveComponent : FiveComponentBlock?
    
    
    fileprivate lazy var subView : UIView = {
        let view = UIView(frame:CGRect(x:0,y:kScreenH - 230 - 44,width:kScreenW,height:230 + 44))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    fileprivate lazy var pickerView : UIPickerView = {
        let pickerView = UIPickerView(frame:CGRect(x:0,y:44,width:kScreenW,height:230))
        pickerView.backgroundColor = UIColor.white
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    fileprivate lazy var sureBtn : UIButton = {
        let btn = UIButton(type:.custom)
        btn.setTitle("确定", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
        btn.setTitleColor(UIColor.RGBS(s: 33), for: .normal)
        btn.addTarget(self, action: #selector(LYDatePicker.sureAction), for: .touchUpInside)
        return btn
    }()
    fileprivate lazy var cancleBtn : UIButton = {
        let btn = UIButton(type:.custom)
        btn.setTitle("取消", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
        btn.setTitleColor(UIColor.RGBS(s: 33), for: .normal)
        btn.addTarget(self, action: #selector(LYDatePicker.cancleAction), for: .touchUpInside)
        return btn
    }()
    fileprivate lazy var titleLbl : UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.textColor = UIColor.RGBS(s: 33)
        lbl.font = UIFont.systemFont(ofSize: 15.0)
        lbl.text = "请选择时间"
        return lbl
    }()
    
    init(component:Int) {
        if component > 5{
            self.component = 5
        }else{
            self.component = component
        }
        
        super.init(frame:CGRect(x:0,y:0,width:kScreenW,height:kScreenH))
        
        self.setUpGlobalViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LYDatePicker{
    
    func setUpGlobalViews() {
        //1.点击背景取消选择
        self.backgroundColor = UIColor.clear
        let bg_btn = UIButton(frame:self.bounds)
        bg_btn.backgroundColor = UIColor.black
        bg_btn.alpha = 0.3
        self.addSubview(bg_btn)
        bg_btn.addTarget(self, action: #selector(LYDatePicker.cancleAction), for: .touchDown)
        
        //2.时间选择器
        self.subView.addSubview(self.pickerView)
        //年是从1900开始计算，时和分都是从0开始计算，尾数为0，因此索引正常；月和日从1计算，因此索引要减去1
        self.pickerView.selectRow(self.year - yearEerliest, inComponent: 0, animated: false)
        if self.component > 1{
            self.pickerView.selectRow(self.month - 1, inComponent: 1, animated: false)
        }
        if self.component > 2{
            self.pickerView.selectRow(self.day - 1, inComponent: 2, animated: false)
        }
        if self.component > 3{
            self.pickerView.selectRow(self.hour, inComponent: 3, animated: false)
        }
        if self.component > 4{
            self.pickerView.selectRow(self.minute, inComponent: 4, animated: false)
        }
        
        
        
        //3.确定，取消按钮
        let btnView = UIView(frame:CGRect(x:0,y:0,width:kScreenW,height:44))
        self.cancleBtn.frame = CGRect(x:10,y:5,width:60,height:35)
        self.titleLbl.frame = CGRect(x:80,y:5,width:kScreenW-160,height:35)
        self.sureBtn.frame = CGRect(x:kScreenW-60-10,y:5,width:60,height:35)
        let line = UIView(frame:CGRect(x:0,y:43,width:kScreenW,height:1))
        line.backgroundColor = UIColor.RGBS(s: 240)
        btnView.backgroundColor = UIColor.white
        btnView.addSubview(cancleBtn)
        btnView.addSubview(titleLbl)
        btnView.addSubview(sureBtn)
        btnView.addSubview(line)
        self.subView.addSubview(btnView)
    }
    
    
    func sureAction() {
        
        if (self.ly_datepickerWithOneComponent != nil) {
            self.ly_datepickerWithOneComponent!(self.date,self.year)
        }
        if (self.ly_datepickerWithTwoComponent != nil) {
            self.ly_datepickerWithTwoComponent!(self.date,self.year,self.month)
        }
        if (self.ly_datepickerWithThreeComponent != nil) {
            self.ly_datepickerWithThreeComponent!(self.date,self.year,self.month,self.day)
        }
        if (self.ly_datepickerWithFourComponent != nil) {
            self.ly_datepickerWithFourComponent!(self.date,self.year,self.month,self.day,self.hour)
        }
        if (self.ly_datepickerWithFiveComponent != nil) {
            self.ly_datepickerWithFiveComponent!(self.date,self.year,self.month,self.day,self.hour,self.minute)
        }
        
        if (self.delegate != nil){
            self.delegate?.ly_datePickerChoosedTime(date: self.date)
        }
        
    }
    
    
    func cancleAction() {
        UIApplication.shared.keyWindow?.addSubview(self)
        UIApplication.shared.keyWindow?.bringSubview(toFront: self)
        
        UIView.animate(withDuration: 0.25, animations: {
            self.subView.y = kScreenH
        }){(completion) in
            self.removeFromSuperview()
        }
    }
    
    func show() {
        UIApplication.shared.keyWindow?.addSubview(self)
        UIApplication.shared.keyWindow?.bringSubview(toFront: self)
        
        self.subView.y = kScreenH
        self.addSubview(self.subView)
        UIView.animate(withDuration: 0.25, animations: {
            self.subView.y = kScreenH - 230 - 44
        })
        
        
    }
}



extension LYDatePicker : UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return self.component
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return yearSum
        case 1:
            return 12
        case 2:
            return Date.dayCountInYearAndMonth(year: self.year, month: self.month)
        case 3:
            return 24
        case 4:
            return 60
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let lbl = UILabel(frame:CGRect(x:0, y:0, width:kScreenW / 6.0, height:30))
        lbl.textColor = UIColor.RGBS(s: 33)
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 14.0)
        switch component {
        case 0:
            lbl.text = "\(row + self.yearEerliest)年"
        case 1:
            lbl.text = "\(row + 1)月"
        case 2:
            lbl.text = "\(row + 1)日"
        case 3:
            lbl.text = "\(row)时"
        case 4:
            lbl.text = "\(row)分"
        default:
            lbl.text = ""
        }
        
        return lbl
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 || component == 1{
            if self.component > 2{
                let nextYear = self.pickerView.selectedRow(inComponent: 0)
                let nextMonth = self.pickerView.selectedRow(inComponent: 1) + 1
                
                if self.day == 31{
                    if [4,6,9,11].contains(nextMonth){
                        self.pickerView.selectRow(29, inComponent: 2, animated: false)
                    }else if nextMonth == 2{
                        if Date.dayCountInYearAndMonth(year: nextYear, month: nextMonth) == 28{
                            self.pickerView.selectRow(27, inComponent: 2, animated: false)
                        }else{
                            self.pickerView.selectRow(28, inComponent: 2, animated: false)
                        }
                    }
                }else if self.day == 30 || self.day == 29{
                    if nextMonth == 2{
                        if Date.dayCountInYearAndMonth(year: nextYear, month: nextMonth) == 28{
                            self.pickerView.selectRow(27, inComponent: 2, animated: false)
                        }else{
                            self.pickerView.selectRow(28, inComponent: 2, animated: false)
                        }
                    }
                }
            }
        }
        self.resetDate()
    }
    
    func resetDate() {
        
        self.year = self.pickerView.selectedRow(inComponent: 0) + yearEerliest
        if self.component > 1{
            self.month = self.pickerView.selectedRow(inComponent: 1) + 1
        }
        if self.component > 2{
            self.day = self.pickerView.selectedRow(inComponent: 2) + 1
        }
        if self.component > 3{
            self.hour = self.pickerView.selectedRow(inComponent: 3)
        }
        if self.component > 4{
            self.minute = self.pickerView.selectedRow(inComponent: 4)
        }
        
        self.date = Date.dateFromDateString(format: "yyyy-MM-dd HH:mm", dateString: "\(self.year)-\(self.month)-\(self.day) \(self.hour):\(self.minute)")
        
        self.pickerView.reloadAllComponents()
        
    }
    
}

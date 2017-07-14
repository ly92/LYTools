//
//  LYPickerView.swift
//  ly
//   _
//  | |      /\   /\
//  | |      \ \_/ /
//  | |       \_~_/
//  | |        / \
//  | |__/\    [ ]
//  |_|__,/    \_/
//
//  Created by 李勇 on 2017/6/29.
//  Copyright © 2017年 ly. All rights reserved.
//

import UIKit

typealias LYPickerViewBlock = (String,NSInteger) -> Void

class LYPickerView: UIView {
    
    var ly_PickerViewSelectBlock : LYPickerViewBlock?
    
    fileprivate lazy var pickerView : UIPickerView = {
        let pickerView = UIPickerView.init(frame: CGRect.init(x: 0, y: 50, width: kScreenW, height: 200))
        pickerView.backgroundColor = UIColor.white
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    fileprivate lazy var btnView : UIView = {
        //底部线
        let btnView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenW, height: 50))
        btnView.backgroundColor = UIColor.white
        let line = UIView.init(frame: CGRect.init(x: 0, y: 49, width: kScreenW, height: 1))
        line.backgroundColor = UIColor.RGBS(s: 240)
        btnView.addSubview(line)
        //取消按钮
        let cancelBtn = UIButton.init(frame: CGRect.init(x: 15, y: 0, width: 60, height: 49))
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.setTitleColor(UIColor.lightGray, for: .normal)
        cancelBtn.addTarget(self, action: #selector(LYPickerView.hide), for: .touchUpInside)
        btnView.addSubview(cancelBtn)
        let sureBtn = UIButton.init(frame: CGRect.init(x: kScreenW - 75, y: 0, width: 60, height: 49))
        //确定按钮
        sureBtn.setTitle("确定", for: .normal)
        sureBtn.setTitleColor(UIColor.RGBS(s: 33), for: .normal)
        sureBtn.addTarget(self, action: #selector(LYPickerView.sureAction), for: .touchUpInside)
        btnView.addSubview(sureBtn)
        
        return btnView
    }()
    
    fileprivate var subView : UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: kScreenH - 250, width: kScreenW, height: 250))
        
        return view
    }()

    
    fileprivate var bgBtn : UIButton = {
        let bg_btn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: kScreenW, height: kScreenH))
        bg_btn.backgroundColor = UIColor.black
        bg_btn.alpha = 0.4
        bg_btn.addTarget(self, action: #selector(LYPickerView.hide), for: .touchUpInside)
        return bg_btn
    }()
    
    
    fileprivate lazy var dataArray : Array<String> = {
        let array = Array<String>()
        
        return array
    }()
    
    class func show(titles : Array<String>,selectBlock:LYPickerViewBlock?) {
        let picker = LYPickerView(frame:CGRect.init(x: 0, y: 0, width: kScreenW, height: kScreenH))
        
        picker.setUpMainUI()
        
        picker.dataArray = titles
        if (selectBlock != nil){
            picker.ly_PickerViewSelectBlock = selectBlock
        }
        
        UIApplication.shared.keyWindow?.addSubview(picker)
        picker.subView.y = kScreenH
        UIView.animate(withDuration: 0.25) {
            picker.subView.y = kScreenH - 250
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 0.25, animations: {
            self.subView.y = kScreenH
        }) { (completion) in
            self.removeFromSuperview()
        }
    }
    
    func sureAction() {
        let row = self.pickerView.selectedRow(inComponent: 0)
        if self.dataArray.count > row{
            if (self.ly_PickerViewSelectBlock != nil){
                self.ly_PickerViewSelectBlock!(self.dataArray[row],row)
            }
        }
        self.hide()
    }
    
}



extension LYPickerView {
    func setUpMainUI() {
        //1.基础设置
        self.backgroundColor = UIColor.clear
        //2.背景按钮
        self.addSubview(self.bgBtn)
        //3.选择控件,按钮
        self.subView.addSubview(self.btnView)
        self.subView.addSubview(self.pickerView)
        
        self.addSubview(self.subView)
    }
    
    
}

extension LYPickerView : UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.dataArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if self.dataArray.count > row{
            return self.dataArray[row]
        }
        return "无效选项"
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 25
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
}

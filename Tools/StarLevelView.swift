//
//  StarLevelView.swift
//  qixiaofu
//
//  Created by ly on 2017/6/27.
//  Copyright © 2017年 qixiaofu. All rights reserved.
//

import UIKit

class StarLevelView: UIView {
    
    typealias StarLevelViewBlock = (Int) -> Void
    var starLevelBlock : StarLevelViewBlock?
    
    //星标级别
    var level : Float{
        didSet{
            self.resetStartLevel(level: level)
        }
    }
    //背景颜色
    var bg_color : UIColor{
        didSet{
            self.backgroundColor = bg_color
        }
    }
    
    init(frame: CGRect, level: Float) {
        self.level = level
        self.bg_color = UIColor.clear
        super.init(frame: frame)
        self.frame = CGRect(x:frame.origin.x, y:frame.origin.y, width:frame.size.height * 5 + 5, height:frame.size.height)
        self.setUpMainUI()
    }
    
    override init(frame: CGRect) {
        self.level = 0
        self.bg_color = UIColor.clear
        super.init(frame: frame)
        self.frame = CGRect(x:frame.origin.x, y:frame.origin.y, width:frame.size.height * 5 + 5, height:frame.size.height)
        self.setUpMainUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StarLevelView{
    func setUpMainUI() {
        //1.添加5个btn
        let W = self.frame.width / 5 - 1
        let H = self.frame.height
        for index in 0...4{
            let btn = UIButton(frame:CGRect(x:CGFloat(index)*(W + 1), y:0, width:W, height:H))
            btn.backgroundColor = UIColor.clear
            btn.tag = index
            btn.addTarget(self, action: #selector(StarLevelView.btnSelectedAction(btn:)), for: .touchUpInside)
            self.addSubview(btn)
        }
        self.resetStartLevel(level: level)
    }
    
    func resetStartLevel(level:Float) {
        if level > 5{
            self.resetStartLevel(level: 5)
            return
        }
        if level.truncatingRemainder(dividingBy: 1) == 0{
            for index in 0...4 {
                let subBtn = self.subviews[index] as! UIButton
                if index < Int(level){
                    subBtn.setImage(UIImage(named:"selected_star"), for: .normal)
                }else{
                    subBtn.setImage(UIImage(named:"unselected_star"), for: .normal)
                }
            }
        }else{
            let level2 = level / 1
            for index in 0...4 {
                let subBtn = self.subviews[index] as! UIButton
                if index < Int(level2){
                    subBtn.setImage(UIImage(named:"selected_star"), for: .normal)
                }else{
                    subBtn.setImage(UIImage(named:"unselected_star"), for: .normal)
                }
            }
            let subBtn = self.subviews[Int(level2)] as! UIButton
            subBtn.setImage(UIImage(named:"half_star"), for: .normal)
        }
    }
    
    //回调
    func btnSelectedAction(btn : UIButton) {
        if (self.starLevelBlock != nil){
            self.resetStartLevel(level: Float(btn.tag + 1))
            self.starLevelBlock!(btn.tag + 1)
        }
    }
}

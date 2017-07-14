//
//  String+Category.swift
//  ly
//   _
//  | |      /\   /\
//  | |      \ \_/ /
//  | |       \_~_/
//  | |        / \
//  | |__/\    [ ]
//  |_|__,/    \_/
//
//  Created by ly on 2017/6/7.
//  Copyright © 2017年 ly. All rights reserved.
//

import Foundation
import UIKit


//
extension String{
    
    //手机号识别
    func isMobelPhone() -> Bool {
        if self.characters.count != 11{
            return false
        }
        
        let MOBILE = "^1(3[0-9]|5[0-9]|7[0-9]|8[0-9])\\d{8}$"
        let CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
        let CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
        let CT = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
        
        let regrxtestMobile = NSPredicate(format: "SELF MATCHES %@", MOBILE)
        let regrxtestCm = NSPredicate(format: "SELF MATCHES %@", CM)
        let regrxtestCu = NSPredicate(format: "SELF MATCHES %@", CU)
        let regrxtestCt = NSPredicate(format: "SELF MATCHES %@", CT)
        
        return regrxtestMobile.evaluate(with:self) || regrxtestCm.evaluate(with:self) || regrxtestCu.evaluate(with:self) || regrxtestCt.evaluate(with:self)
    }
    
    //身份证识别
    func isIdCard() -> Bool {
        if self.characters.count != 18{
            return false
        }
        let pattern = "(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)"
        let regrxtest = NSPredicate(format:"SELF MATCHES %@",pattern)
        return regrxtest.evaluate(with: self)
    }
    
    func sizeFit(width:CGFloat,height:CGFloat,fontSize:CGFloat) -> CGSize {
        let lbl = UILabel()
        lbl.text = self
        lbl.font = UIFont.systemFont(ofSize: fontSize)
        lbl.numberOfLines = 0
        return lbl.sizeThatFits(CGSize.init(width: width, height: height))
    }
    
    
}

//MARK: - 数值
extension String{
    
    var floatValue : Float {
        var str = self
        if str.isEmpty{
            return 0
        }
        str = str.trimmingCharacters(in: .whitespacesAndNewlines)
        if str.hasPrefix("-"){
            str.remove(at: str.startIndex)
            let pattern = "^[0-9]\\d*?\\.?[0-9]*?"
            let regrxtest = NSPredicate(format:"SELF MATCHES %@",pattern)
            if regrxtest.evaluate(with: str){
                return -Float(str)!
            }
        }else{
            let pattern = "^[0-9]\\d*?\\.?[0-9]*?"
            let regrxtest = NSPredicate(format:"SELF MATCHES %@",pattern)
            if regrxtest.evaluate(with: str){
                return Float(str)!
            }
        }
        return 0
    }
    
    var intValue : Int {
        var str = self
        if str.isEmpty{
            return 0
        }
        str = str.trimmingCharacters(in: .whitespacesAndNewlines)
        if str.contains("."){
            let array = str.components(separatedBy: ".")
            str = array[0]
        }
        if str.hasPrefix("-"){
            str.remove(at: str.startIndex)
            let pattern = "^[0-9]\\d*?"
            let regrxtest = NSPredicate(format:"SELF MATCHES %@",pattern)
            if regrxtest.evaluate(with: str){
                return -Int(str)!
            }
        }else{
            let pattern = "^[0-9]\\d*?"
            let regrxtest = NSPredicate(format:"SELF MATCHES %@",pattern)
            if regrxtest.evaluate(with: str){
                return Int(str)!
            }
        }
        return 0
    }
    
    var doubleValue : Double {
        var str = self
        if str.isEmpty{
            return 0
        }
        str = str.trimmingCharacters(in: .whitespacesAndNewlines)
        if str.hasPrefix("-"){
            str.remove(at: str.startIndex)
            let pattern = "^[0-9]\\d*?\\.?[0-9]*?"
            let regrxtest = NSPredicate(format:"SELF MATCHES %@",pattern)
            if regrxtest.evaluate(with: str){
                return -Double(str)!
            }
        }else{
            let pattern = "^[0-9]\\d*?\\.?[0-9]*?"
            let regrxtest = NSPredicate(format:"SELF MATCHES %@",pattern)
            if regrxtest.evaluate(with: str){
                return Double(str)!
            }
        }
        return 0
    }
    
    
}

//
//  UIColor+Category.swift
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

extension UIColor{
    //颜色
    class func RGB(r:CGFloat, g:CGFloat, b:CGFloat) -> UIColor{
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)}
    class func RGBA(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor{
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)}
    class func RGBS(s:CGFloat) -> UIColor{
        return UIColor(red: s / 255.0, green: s / 255.0, blue: s / 255.0, alpha: 1.0)}
    class func colorHex(hex: String) -> UIColor{
        return colorHexWithAlpha(hex: hex, alpha: 1.0)
    }
    class func colorHexWithAlpha(hex: String, alpha: CGFloat) -> UIColor{
        //传入的字符串为空
        if hex.isEmpty{
            return UIColor.clear
        }
        //去除空格换行符，并将所有字符大写
        let whiteSpace = NSCharacterSet.whitespacesAndNewlines
        var hHex = (hex.trimmingCharacters(in: whiteSpace)).uppercased()
        //如果处理后字符长度小于6
        if hHex.characters.count < 6{
            return UIColor.clear
        }
        //开头是0x或者##
        if hHex.hasPrefix("0X") || hHex.hasPrefix("##"){
            hHex = String(hHex.characters.dropFirst(2))
        }
        //开头是#
        if hHex.hasPrefix("#"){
            hHex = (hHex as NSString).substring(from: 1)
        }
        //截取后的长度应该保证是6位
        if hHex.characters.count != 6{
            return UIColor.clear
        }
        /** R G B */
        var range = NSMakeRange(0, 2)
        //R
        let rHex = (hHex as NSString).substring(with: range)
        //G
        range.location = 2
        let gHex = (hHex as NSString).substring(with: range)
        //B
        range.location = 4
        let bHex = (hHex as NSString).substring(with: range)
        
        //类型转换
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0
        
        Scanner(string: rHex).scanHexInt32(&r)
        Scanner(string: gHex).scanHexInt32(&g)
        Scanner(string: bHex).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }

}

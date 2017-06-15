//
//  UILabel+Category.swift
//  ly
//
//  Created by 李勇 on 2017/6/5.
//  Copyright © 2017年 ly. All rights reserved.
//

import Foundation
import UIKit

extension UILabel{
    func resizeHeight() -> CGFloat {
        let frame = self.frame
        let size = self.sizeThatFits(CGSize(width:frame.size.width, height:CGFloat(MAXFLOAT)))
        return size.height
    }
    
    func resizeWidth() -> CGFloat {
        let frame = self.frame
        let size = self.sizeThatFits(CGSize(width:CGFloat(MAXFLOAT), height:frame.size.height))
        return size.width
    }
    
    func autoCalculateTextViewFrame() {
//        let frame = self.frame
//        let constraint = CGSize(width:frame.size.width, height:CGFloat(MAXFLOAT))
//        let size = self.textRect(forBounds: self.bounds, limitedToNumberOfLines: 3)
        self.adjustsFontSizeToFitWidth = true
        
    }

}

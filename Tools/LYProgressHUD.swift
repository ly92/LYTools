//
//  LYProgressHUD.swift
//  LYProgressHUD
//   _
//  |.|      /\   /\
//  |.|      \ \_/ /
//  |.|       \_~_/
//  |.|        /.\
//  |.|__/\    [.]
//  |_|__,/    \_/
//
//  Created by ly on 16/12/16.
//  Copyright © 2016年 aoke. All rights reserved.
//

import UIKit

public enum ShowType {
    case success
    case error
    case info
}

public extension LYProgressHUD {
    
    /**
     加载动画图片
     
     - parameter images:       图片数组
     - parameter timeInterval: 动画每次执行时间
     */
    public static func showWaitingWithImages(images : Array<UIImage>, timeInterval : TimeInterval = 0, autoRemove: Bool = true) {
        LYProgressHUD.showWaitWithImages(images: images, timeInterval: timeInterval, autoRemove: autoRemove)
    }
    /**
     显示菊花
     
     - parameter text:       需要显示的文字,如果不设置文字,则只显示菊花
     - parameter autoRemove: 是否自动移除,默认3秒后自动移除
     */
    public static func showLoading(_ text: String = "", autoRemove: Bool = true) {
        LYProgressHUD.showWaitingWithText(text: text, autoRemove: autoRemove)
    }
    /**
     状态栏显示
     
     - parameter text:       需要显示的文字
     - parameter color:      背景颜色
     - parameter autoRemove: 是否自动移除,默认3秒后自动移除
     */
    public static func showStatusBarWithText(text: String = "OK", color: UIColor = UIColor(red: 131 / 255.0, green: 178 / 255.0, blue: 158 / 255.0, alpha: 1), autoRemove: Bool = true) {
        LYProgressHUD.showStatusBar(text: text, color: color, autoRemove: autoRemove)
    }
    /**
     只显示文字
     
     - parameter text:       需要显示的文字
     - parameter autoRemove: 是否自动移除,默认3秒后自动移除
     */
    public static func showOnlyText(_ text: String = "", autoRemove: Bool = true) {
        LYProgressHUD.onlyText(text: text, autoRemove: autoRemove)
    }
    /**
     Success样式
     
     - parameter successText: 需要显示的文字,默认为 Success!
     - parameter autoRemove:  是否自动移除,默认3秒后自动移除
     */
    public static func showSuccess(_ success: String = "Success!", autoRemove: Bool = true) {
        LYProgressHUD.showText(type: .success, text: success, autoRemove: autoRemove)
    }
    /**
     Error样式
     
     - parameter error:  需要显示的文字,默认为 Error!
     - parameter autoRemove: 是否自动移除,默认3秒后自动移除
     */
    public static func showError(_ error: String = "Error!", autoRemove: Bool = true) {
        LYProgressHUD.showText(type: .error, text: error, autoRemove: autoRemove)
    }
    /**
     Info样式
     
     - parameter infoText:   需要显示的文字,默认为 Info!
     - parameter autoRemove: 是否自动移除,默认3秒后自动移除
     */
    public static func showInfo(_ infoText: String = "info!", autoRemove: Bool = true) {
        LYProgressHUD.showText(type: .info, text: infoText, autoRemove: autoRemove)
    }
    /**
     移除HUD,会移除所有
     */
    public static func dismiss() {
        LYProgressHUD.clear()
    }
}

//提示框大小
private let hudW : CGFloat = 150
private let hudH : CGFloat = 150
//提示图片大小
private let imgW : CGFloat = 30
private let imgH : CGFloat = 30
//提示图标大小
private let circleSize = CGSize(width: imgW, height: imgH)
private let windowBgColor = UIColor.black.withAlphaComponent(0.5)
private let bgColor : UIColor = UIColor(red: 250 / 255.0, green: 250 / 255.0, blue: 250 / 255.0, alpha:1)
private let textColor = UIColor(red: 33 / 255.0, green: 33 / 255.0, blue: 33 / 255.0, alpha: 1)


public class LYProgressHUD : NSObject {
    
    static var windows = Array<UIWindow!>()
    static var angle: Double {
        return [0, 0, 180, 270, 90][UIApplication.shared.statusBarOrientation.hashValue] as Double
    }
    static public func showWaitWithImages(images : Array<UIImage>, timeInterval : TimeInterval, autoRemove: Bool = true) {
        self.dismiss()
        let frame = CGRect(x: 0, y: 0, width: hudW, height: hudH)
        let imageView = UIImageView()
        imageView.frame = frame
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = bgColor
        imageView.layer.cornerRadius = 10
        imageView.animationImages = images
        imageView.animationDuration = timeInterval == 0 ? TimeInterval(images.count) * 0.07 : timeInterval
        imageView.animationRepeatCount = 0
        imageView.startAnimating()
        
        let window = LYProgressHUD.createWindow(frame: frame, view: imageView)
        
        if autoRemove {
            perform(#selector(LYProgressHUD.removeHUD(object:)), with: window, afterDelay: 2)
        }
    }
    static public func showWaitingWithText(text: String, autoRemove: Bool) {
        self.dismiss()
        let frame = CGRect(x: 0, y: 0, width: hudW, height: hudH)
        let view = UIView(frame: frame)
        view.backgroundColor = bgColor
        view.layer.cornerRadius = 10
        
        let activity = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        if text.isEmpty {
            activity.frame = CGRect(x: (hudW-60)/2.0, y: (hudH-60)/2.0, width: 60, height: 60)
            activity.transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
        }else{
            activity.frame = CGRect(x: (hudW-40)/2.0, y: 20, width: 40, height: 40)
            activity.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            let lable = LYProgressHUD.createLable()
            lable.frame = CGRect(x: 5, y: 20+40+10, width: hudW-10, height: hudH-20-40-20)
            lable.text = text
            view.addSubview(lable)
        }
        
        activity.color = textColor
        activity.startAnimating()
        view.addSubview(activity)
        
        let window = LYProgressHUD.createWindow(frame: frame, view: view)
        if autoRemove {
            perform(#selector(LYProgressHUD.removeHUD(object:)), with: window, afterDelay: 10)
        }
        
    }
    static public func showStatusBar(text: String, color: UIColor, autoRemove: Bool) {
        self.dismiss()
        var frame = UIApplication.shared.statusBarFrame
        frame.size.height = 64
        let lable = LYProgressHUD.createLable()
        lable.text = text
        let window = UIWindow(frame:frame)
        window.transform = CGAffineTransform(rotationAngle: CGFloat(angle * Double.pi / 180))
        window.isHidden = false
        window.addSubview(lable)
        windows.append(window)
        window.backgroundColor = color
        window.windowLevel = UIWindowLevelStatusBar
        lable.frame = frame
        window.center = CGPoint(x: frame.width * 0.5, y: frame.height * 0.5)
        lable.center = window.center
        
        if autoRemove {
            perform(#selector(LYProgressHUD.removeHUD(object:)), with: window, afterDelay: 2.0)
        }
    }
    static public func onlyText(text: String, autoRemove: Bool) {
        self.dismiss()
        let view = UIView()
        view.backgroundColor = bgColor
        view.layer.cornerRadius = 10
        
        let label = LYProgressHUD.createLable()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 13)
        label.frame = CGRect(x: 5, y: 5, width: 200, height: 100)
        view.addSubview(label)
        
        let frame = CGRect(x: 0, y: 0, width: 210, height: 110)
        view.frame = frame
        
        let window = LYProgressHUD.createWindow(frame: frame, view: view)
        
        if autoRemove {
            perform(#selector(LYProgressHUD.removeHUD(object:)), with: window, afterDelay: 3)
        }
    }
    static public func showText(type: ShowType, text: String, autoRemove: Bool) {
        self.dismiss()
        let frame = CGRect(x: 0, y: 0, width: hudW, height: hudH)
        
        let view = UIView(frame: frame)
        view.layer.cornerRadius = 10
        view.backgroundColor = bgColor
        
        var image = UIImage()
        switch type {
        case .success:
            image = drawImage.imageOfSuccess
        case .error:
            image = drawImage.imageOfError
        case .info:
            image = drawImage.imageOfInfo
        }
        
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(origin: CGPoint(x: (hudW-imgW)/2.0, y: 20), size: circleSize)
        imageView.contentMode = .center
        view.addSubview(imageView)
        
        let lable = LYProgressHUD.createLable()
        lable.frame = CGRect(x: 5, y: 20+imgH+10, width: hudW-10, height: hudH-20-imgH-20)
        lable.text = text
        view.addSubview(lable)
        
        let window = LYProgressHUD.createWindow(frame: frame, view: view)
        
        if autoRemove {
            perform(#selector(LYProgressHUD.removeHUD(object:)), with: window, afterDelay: 1.0)
        }
        
    }
    
    static private func createLable() -> UILabel {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 13)
        lable.backgroundColor = UIColor.clear
        lable.textColor = textColor
        lable.numberOfLines = 0
        lable.textAlignment = .center
        return lable
    }
    static private func createWindow(frame: CGRect, view: UIView) -> UIWindow {
        
        let window = UIWindow(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        
        window.backgroundColor = windowBgColor
        window.windowLevel = UIWindowLevelAlert
        window.transform = CGAffineTransform(rotationAngle: CGFloat(angle * Double.pi / 180))
        window.isHidden = false
        window.center = getCenter()
        view.center = window.center
        window.addSubview(view)
        windows.append(window)
        return window
    }
    @objc static public func removeHUD(object: AnyObject) {
        if let window = object as? UIWindow {
            if let index = windows.index(where: { (item) -> Bool in
                return item == window
            }) {
                windows.remove(at: index)
            }
        }
    }
    static public func clear() {
        if windows.isEmpty { return }
        self.cancelPreviousPerformRequests(withTarget: self)
        windows.removeAll(keepingCapacity: false)
    }
    static func getCenter() -> CGPoint {
        let view = UIApplication.shared.keyWindow?.subviews.first as UIView!
        if UIApplication.shared.statusBarOrientation.hashValue >= 3 {
            return CGPoint(x: view!.center.y, y: view!.center.x)
        } else {
            return view!.center
        }
    }
}


class drawImage  {
    
    struct imageCache {
        static var imageOfSuccess: UIImage?
        static var imageOfError: UIImage?
        static var imageOfInfo: UIImage?
    }
    
    class func draw(type : ShowType) {
        
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: imgW, y: imgH/2.0))
        path.addArc(withCenter: CGPoint(x: imgW/2.0, y: imgH/2.0), radius: imgW/2.0-1, startAngle: 0, endAngle: CGFloat(Double.pi*2), clockwise: true)
        //        path.move(to: CGPoint(x: imgW/2.0, y: imgH/2.0))
        path.close()
        
        switch type {
        case .success:
            path.move(to: CGPoint(x: imgW/2.0-5, y: imgH/2.0))
            path.addLine(to: CGPoint(x: imgW/2.0, y: imgH/2.0+5))
            path.addLine(to: CGPoint(x: imgW/2.0+7, y: imgH/2.0-7))
            path.move(to: CGPoint(x: imgW/2.0-5, y: imgH/2.0))
            path.close()
        case .error:
            path.move(to: CGPoint(x: imgW/2.0-7, y: imgH/2.0-7))
            path.addLine(to: CGPoint(x: imgW/2.0+7, y: imgH/2.0+7))
            path.move(to: CGPoint(x: imgW/2.0+7, y: imgH/2.0-7))
            path.addLine(to: CGPoint(x: imgW/2.0-7, y: imgH/2.0+7))
            path.move(to: CGPoint(x: imgW/2.0-7, y: imgH/2.0-7))
            path.close()
        case .info:
            path.move(to: CGPoint(x: imgW/2.0, y: imgH/2.0-7))
            path.addLine(to: CGPoint(x: imgW/2.0, y: imgH/2.0+4))
            path.move(to: CGPoint(x: imgW/2.0, y: imgH/2.0+6))
            path.addLine(to: CGPoint(x: imgW/2.0, y: imgH/2.0+7))
            path.move(to: CGPoint(x: imgW/2.0, y: imgH/2.0-7))
            path.close()
            
            let tmpPath = UIBezierPath()
            tmpPath.move(to: CGPoint(x: 20, y: 30))
            tmpPath.addArc(withCenter: CGPoint(x: 20, y: 30), radius: 1, startAngle: 0, endAngle: CGFloat(Double.pi*2), clockwise: true)
            tmpPath.close()
            UIColor.white.setFill()
            tmpPath.fill()
        }
        UIColor.black.setStroke()
        path.stroke()
    }
    
    class var imageOfSuccess: UIImage {
        if imageCache.imageOfSuccess != nil {
            return imageCache.imageOfSuccess!
        }
        UIGraphicsBeginImageContextWithOptions(circleSize, false, 0)
        drawImage.draw(type: .success)
        imageCache.imageOfSuccess = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageCache.imageOfSuccess!
    }
    class var imageOfError: UIImage {
        if imageCache.imageOfError != nil {
            return imageCache.imageOfError!
        }
        UIGraphicsBeginImageContextWithOptions(circleSize, false, 0)
        drawImage.draw(type: .error)
        imageCache.imageOfError = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageCache.imageOfError!
    }
    class var imageOfInfo: UIImage {
        if imageCache.imageOfInfo != nil {
            return imageCache.imageOfInfo!
        }
        UIGraphicsBeginImageContextWithOptions(circleSize, false, 0)
        drawImage.draw(type: .info)
        imageCache.imageOfInfo = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageCache.imageOfInfo!
    }
}

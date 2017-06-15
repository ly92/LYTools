//
//  LYProgressHUD.swift
//  ly
//   _
//  | |      /\   /\
//  | |      \ \_/ /
//  | |       \_~_/
//  | |        / \
//  | |__/\    [ ]
//  |_|__,/    \_/
//
//  Created by ly on 16/12/16.
//  Copyright © 2016年 ly. All rights reserved.
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
    public static func showWaitingWithImages(images : Array<UIImage>, timeInterval : TimeInterval = 0) {
        LYProgressHUD.showWaitWithImages(images: images, timeInterval: timeInterval)
    }
    /**
     显示菊花
     
     - parameter text:       需要显示的文字,如果不设置文字,则只显示菊花
     - parameter autoRemove: 是否自动移除,默认3秒后自动移除
     */
    public static func showWaiting(text: String = "", autoRemove: Bool = true) {
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
    public static func showOnlyText(text: String, autoRemove: Bool = true) {
        LYProgressHUD.onlyText(text: text, autoRemove: autoRemove)
    }
    /**
     Success样式
     
     - parameter successText: 需要显示的文字,默认为 Success!
     - parameter autoRemove:  是否自动移除,默认3秒后自动移除
     */
    public static func showSuccess(successText: String = "Success!", autoRemove: Bool = true) {
        LYProgressHUD.showText(type: .success, text: successText, autoRemove: autoRemove)
    }
    /**
     Error样式
     
     - parameter errorText:  需要显示的文字,默认为 Error!
     - parameter autoRemove: 是否自动移除,默认3秒后自动移除
     */
    public static func showError(errorText: String = "Error!", autoRemove: Bool = true) {
        LYProgressHUD.showText(type: .error, text: errorText, autoRemove: autoRemove)
    }
    /**
     Info样式
     
     - parameter infoText:   需要显示的文字,默认为 Info!
     - parameter autoRemove: 是否自动移除,默认3秒后自动移除
     */
    public static func showInfo(infoText: String = "info!", autoRemove: Bool = true) {
        LYProgressHUD.showText(type: .info, text: infoText, autoRemove: autoRemove)
    }
    /**
     移除HUD,会移除所有
     */
    public static func dismiss() {
        LYProgressHUD.clear()
    }
}


private let circleSize = CGSize(width: 40, height: 40)
private let windowBgColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.002)
private func bgColor(alpha: CGFloat) -> UIColor {
    return UIColor(red: 0, green: 0, blue: 0, alpha: alpha)
}

public class LYProgressHUD : NSObject {
    
    static var windows = Array<UIWindow!>()
    static var angle: Double {
            return [0, 0, 180, 270, 90][UIApplication.shared.statusBarOrientation.hashValue] as Double
    }
    static public func showWaitWithImages(images : Array<UIImage>, timeInterval : TimeInterval) {
        
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let imageView = UIImageView()
        imageView.frame = frame
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = bgColor(alpha: 0.7)
        imageView.layer.cornerRadius = 10
        imageView.animationImages = images
        imageView.animationDuration = timeInterval == 0 ? TimeInterval(images.count) * 0.07 : timeInterval
        imageView.animationRepeatCount = 0
        imageView.startAnimating()
        
        _ = LYProgressHUD.createWindow(frame: frame, view: imageView)

    }
    static public func showWaitingWithText(text: String, autoRemove: Bool) {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.backgroundColor = bgColor(alpha: 0.7)
        view.layer.cornerRadius = 10
        
        let activity = UIActivityIndicatorView(activityIndicatorStyle: .white)
        if !text.isEmpty {
            activity.frame = CGRect(x: 35, y: 25, width: 30, height: 30)
            
            let lable = LYProgressHUD.createLable()
            lable.frame = CGRect(x: 0, y: 55, width: 100, height: 45)
            lable.text = text
            view.addSubview(lable)
        }
        activity.frame = CGRect(x: 30, y: 30, width: 40, height: 40)
        activity.startAnimating()
        view.addSubview(activity)
        
        
        let window = LYProgressHUD.createWindow(frame: view.frame, view: view)

        
        if autoRemove {
            perform(#selector(LYProgressHUD.removeHUD(object:)), with: window, afterDelay: 3)
        }
    
    }
    static public func showStatusBar(text: String, color: UIColor, autoRemove: Bool) {
        
        let frame = UIApplication.shared.statusBarFrame
        
        let lable = LYProgressHUD.createLable()
        lable.text = text
        
        let window = LYProgressHUD.createWindow(frame: frame, view: lable)
        window.backgroundColor = color
        window.windowLevel = UIWindowLevelStatusBar
        lable.frame = frame
        window.center = CGPoint(x: frame.width * 0.5, y: frame.height * 0.5)
        lable.center = window.center
        
        if autoRemove {
            perform(#selector(LYProgressHUD.removeHUD(object:)), with: window, afterDelay: 3)
        }
    }
    static public func onlyText(text: String, autoRemove: Bool) {
        
        let view = UIView()
        view.backgroundColor = bgColor(alpha: 0.7)
        view.layer.cornerRadius = 10
        
        
        let label = LYProgressHUD.createLable()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 12)
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        view.addSubview(label)
        
        let frame = CGRect(x: 0, y: 0, width: 210, height: 110)
        view.frame = frame
        label.center = view.center
 
        let window = LYProgressHUD.createWindow(frame: frame, view: view)
        
        if autoRemove {
            perform(#selector(LYProgressHUD.removeHUD(object:)), with: window, afterDelay: 3)
        }
    }
    static public func showText(type: ShowType, text: String, autoRemove: Bool) {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
       
        let view = UIView(frame: frame)
        view.layer.cornerRadius = 10
        view.backgroundColor = bgColor(alpha: 0.7)
        
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
        imageView.frame = CGRect(origin: CGPoint(x: 30, y: 25), size: circleSize)
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        
        let lable = LYProgressHUD.createLable()
        lable.frame = CGRect(x: 0, y: 70, width: 100, height: 30)
        lable.text = text
        view.addSubview(lable)
        
        let window = LYProgressHUD.createWindow(frame: frame, view: view)
        
        if autoRemove {
            perform(#selector(LYProgressHUD.removeHUD(object:)), with: window, afterDelay: 3)
        }
        
    }
    
    static private func createLable() -> UILabel {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 10)
        lable.backgroundColor = UIColor.clear
        lable.textColor = UIColor.white
        lable.numberOfLines = 0
        lable.textAlignment = .center
        return lable
    }
    static private func createWindow(frame: CGRect, view: UIView) -> UIWindow {
        
        let window = UIWindow(frame: frame)
        window.backgroundColor = windowBgColor
        window.windowLevel = UIWindowLevelAlert
        window.transform = CGAffineTransform(rotationAngle: CGFloat(angle * Double.pi / 180))
        window.isHidden = false
        window.center = getCenter()
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
        
        path.move(to: CGPoint(x: 40, y: 20))
        path.addArc(withCenter: CGPoint(x: 20, y: 20), radius: 19, startAngle: 0, endAngle: CGFloat(Double.pi*2), clockwise: true)
        path.close()
        
        switch type {
        case .success:
            path.move(to: CGPoint(x: 15, y: 20))
            path.addLine(to: CGPoint(x: 20, y: 25))
            path.addLine(to: CGPoint(x: 30, y: 15))
            path.move(to: CGPoint(x: 15, y: 20))
            path.close()
        case .error:
            path.move(to: CGPoint(x: 10, y: 10))
            path.addLine(to: CGPoint(x: 30, y: 30))
            path.move(to: CGPoint(x: 10, y: 30))
            path.addLine(to: CGPoint(x: 30, y: 10))
            path.move(to: CGPoint(x: 10, y: 10))
            path.close()
        case .info:
            path.move(to: CGPoint(x: 20, y: 8))
            path.addLine(to: CGPoint(x: 20, y: 28))
            path.move(to: CGPoint(x: 20, y: 8))
            path.close()
            
            let tmpPath = UIBezierPath()
            tmpPath.move(to: CGPoint(x: 20, y: 30))
            tmpPath.addArc(withCenter: CGPoint(x: 20, y: 30), radius: 1, startAngle: 0, endAngle: CGFloat(Double.pi*2), clockwise: true)
            tmpPath.close()
            UIColor.white.setFill()
            tmpPath.fill()
        }
        UIColor.white.setStroke()
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

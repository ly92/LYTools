//
//  LYPhotoBrowseCell.swift
//  qixiaofu
//
//  Created by ly on 2017/7/3.
//  Copyright © 2017年 qixiaofu. All rights reserved.
//

import UIKit

typealias LYPhotoBrowseCellBlock = () -> Void


class LYPhotoBrowseCell: UICollectionViewCell {
    var deleteBlock : LYPhotoBrowseCellBlock?
    
    @IBOutlet weak var imgV: UIImageView!
//    @IBOutlet weak var leftDis: NSLayoutConstraint!
//    @IBOutlet weak var rightDis: NSLayoutConstraint!
    @IBOutlet weak var deleteBtn: UIButton!
    
    var lastScaleFactor : CGFloat! = 1  //放大、缩小
    var isScalBig = false
    
    
    @IBAction func deleteAction() {
        if (self.deleteBlock != nil){
            self.deleteBlock!()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    /*
    func addTapAction() {
        //手势为捏的姿势:按住option按钮配合鼠标来做这个动作在虚拟器上
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(LYPhotoBrowseCell.handlePinchGesture(sender:)))
        self.imgV.addGestureRecognizer(pinchGesture)
        //双击手势
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LYPhotoBrowseCell.handleTapGesture(sender:)))
        //设置手势点击数,双击：点2下
        tapGesture.numberOfTapsRequired = 2
        self.imgV.addGestureRecognizer(tapGesture)
    }
    
    //双击屏幕时会调用此方法,放大和缩小图片
    func handleTapGesture(sender: UITapGestureRecognizer){
        
        if self.isScalBig{
            UIView.animate(withDuration: 0.25, animations: {
                self.imgV.layer.transform = CATransform3DMakeScale(1, 1, 1)
            })
        }else{
            UIView.animate(withDuration: 0.25, animations: {
                let imgScal = self.imgV.image!.size.height / self.imgV.image!.size.width
                let scal = (self.h - 64) / self.w / imgScal
                self.imgV.transform = CGAffineTransform(scaleX:scal, y:scal)
            })
        }
        self.isScalBig = !self.isScalBig
    }
    
    //捏的手势，使图片放大和缩小，捏的动作是一个连续的动作
    func handlePinchGesture(sender: UIPinchGestureRecognizer){
        let factor = sender.scale
        if factor > 1{
            //图片放大
            self.imgV.transform = CGAffineTransform(scaleX: lastScaleFactor+factor-1, y: lastScaleFactor+factor-1)
        }else{
            //缩小
            self.imgV.transform = CGAffineTransform(scaleX: lastScaleFactor*factor, y: lastScaleFactor*factor)
        }
        //状态是否结束，如果结束保存数据
        if sender.state == UIGestureRecognizerState.ended{
            if factor > 1{
                let imgScal = self.imgV.image!.size.height / self.imgV.image!.size.width
                let scal = (self.h - 64) / self.w / imgScal
                if lastScaleFactor + factor - 1 > scal{
                    lastScaleFactor = scal
                    self.imgV.transform = CGAffineTransform(scaleX:scal, y:scal)
                }else{
                    lastScaleFactor = lastScaleFactor + factor - 1
                }
            }else{
                if lastScaleFactor * factor < 0.7{
                    lastScaleFactor = 0.7
                    self.imgV.transform = CGAffineTransform(scaleX:lastScaleFactor, y:lastScaleFactor)
                }else{
                    lastScaleFactor = lastScaleFactor * factor
                }
            }
        }
        
        
    }
    */
}

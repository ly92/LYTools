//
//  LYPhotoBrowseViewController.swift
//  qixiaofu
//
//  Created by ly on 2017/7/4.
//  Copyright © 2017年 qixiaofu. All rights reserved.
//

import UIKit

typealias LYPhotoBrowseViewControllerBlock = (Array<UIImage>) -> Void

class LYPhotoBrowseViewController: UIViewController {
    
    var backImgArrayBlock : LYPhotoBrowseViewControllerBlock?
    var showDeleteBtn : Bool = true//是否显示图片的删除按钮
    
    var collectionView : UICollectionView!
    var imgArray : Array<UIImage> = Array<UIImage>()
    var selectIndex : NSInteger = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpCollectionView()
        self.navigationItem.title = "\(self.selectIndex + 1)/\(self.imgArray.count)"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named:"btn_back"), target: self, action: #selector(LYPhotoBrowseViewController.backClick))
        if (self.showDeleteBtn){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "删除", target: self, action: #selector(LYPhotoBrowseViewController.deleteImage))
        }
    }
    
    func deleteImage() {
        self.imgArray.remove(at: self.selectIndex)
        if self.imgArray.count == 0{
            if (self.backImgArrayBlock != nil && self.showDeleteBtn){
                self.backImgArrayBlock!(self.imgArray)
            }
            self.navigationController?.popViewController(animated: true)
        }
        if self.selectIndex == self.imgArray.count{
            self.selectIndex -= 1
        }
        self.navigationItem.title = "\(self.selectIndex + 1)/\(self.imgArray.count)"
        self.collectionView.reloadData()
        
    }
    
    func backClick() {
        if (self.backImgArrayBlock != nil && self.showDeleteBtn){
            self.backImgArrayBlock!(self.imgArray)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //collection
    func setUpCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.view.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        self.collectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout)
        self.collectionView.register(LYPhotoPreviewCell.self, forCellWithReuseIdentifier: "LYPhotoPreviewCell")
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.backgroundColor = UIColor.black
        self.collectionView.isPagingEnabled = true
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.contentOffset = CGPoint.init(x: kScreenW * CGFloat(self.selectIndex), y: 0)
        
        self.view.addSubview(self.collectionView)
    }
    
}


extension LYPhotoBrowseViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imgArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell : LYPhotoPreviewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LYPhotoPreviewCell", for: indexPath) as! LYPhotoPreviewCell
        if self.imgArray.count > indexPath.row{
            cell.renderModel(image: self.imgArray[indexPath.row])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.imgArray.count > indexPath.row{
            print(indexPath.row)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var showIndex : NSInteger
        showIndex = NSInteger(scrollView.contentOffset.x / kScreenW)
        self.navigationItem.title = "\(showIndex + 1)/\(self.imgArray.count)"
        self.selectIndex = showIndex
    }
    
    
}

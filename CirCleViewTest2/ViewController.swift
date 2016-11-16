//
//  ViewController.swift
//  CirCleViewTest2
//
//  Created by rxj on 2016/9/21.
//  Copyright © 2016年 renxiaojian. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XJCircleViewDelegate {

    var imgs = [UIImage]()
    var clipImgView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        for i in 1...4 {
            let img = UIImage(named: "\(i)")
            imgs.append(img!)
        }
       let circleView = XJCirCleView()
        circleView.circleViewDelegate = self
        circleView.backgroundColor = UIColor.groupTableViewBackground
        circleView.frame = CGRect(x: 0, y: 120, width: view.frame.width, height: 120)
        circleView.reloadData()
        circleView.didSelectedItemBlock = { (index) -> Void in
            print(index)
        }
        view.addSubview(circleView)
        
//        let imgView = UIImageView()
//        imgView.backgroundColor = UIColor.blue
//        var img = UIImage.imageForColor(UIColor.purple, size: CGSize(width: 80, height: 80))
//        img = img?.circleImage()
//        imgView.image = img
//        imgView.frame = CGRect(origin: CGPoint(x: 100, y: 280), size: CGSize(width: 80, height: 80))
//        view.addSubview(imgView)
//        clipImgView = imgView
//        var edge = 40
//        
//        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
//            edge -= 1
//            imgView.image = imgView.image?.clipImageByEdge(edge)
//        }
        
        
       
    }
    
    func numbersOfItemsInCircleView(_ circleView: XJCirCleView) -> Int {
        return imgs.count
    }
    func circleView(_ circleView: XJCirCleView, configCell cellRef: XJCircleViewCellRef) {
        let cell = cellRef.pointee
        cell.imgView.backgroundColor = UIColor.purple
        cell.imgView.image = imgs[cell.index!]
    }
    func circleView(_ circleView: XJCirCleView, didSelectedItemOfIndex index: Int) {
        print(index)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}


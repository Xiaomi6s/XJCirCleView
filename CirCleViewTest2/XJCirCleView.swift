//
//  XJCirCleView.swift
//  CirCleViewTest2
//
//  Created by rxj on 2016/9/21.
//  Copyright © 2016年 renxiaojian. All rights reserved.
//

import UIKit

typealias XJCircleViewCellRef = AutoreleasingUnsafeMutablePointer<XJCirCleViewCell>

@objc protocol XJCircleViewDelegate: NSObjectProtocol {
    func numbersOfItemsInCircleView(_ circleView: XJCirCleView) ->Int
    func circleView(_ circleView: XJCirCleView, configCell cellRef: XJCircleViewCellRef)
    @objc optional func circleView(_ circleView: XJCirCleView, didSelectedItemOfIndex index: Int)
    
}

class XJCirCleView: UIView {
    public weak var circleViewDelegate: XJCircleViewDelegate?
    private var scrollView: UIScrollView!
    private var cells = [XJCirCleViewCell]()
    fileprivate  var timer: Timer?
    fileprivate var currentUIndex: Int = 0 {
        didSet{
            pageControl?.currentPage = dataIndexFromUIndex(currentUIndex)
        }
    }
    private var pageControl: UIPageControl?
    public var didSelectedItemBlock: ((Int)-> Void)?
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        pageControl?.snp.makeConstraints({ (make) in
            make.bottom.equalTo(scrollView.snp.bottom).offset(0)
            make.height.equalTo(20)
            make.centerX.equalTo(scrollView)
        })
    }
    
    private func initUI() {
        scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        addSubview(scrollView)
        
        pageControl = UIPageControl()
        addSubview(pageControl!)
        
    }
    public func reloadData() {
        let count = circleViewDelegate?.numbersOfItemsInCircleView(self)
        guard count != nil && count! > 0 else {
            return
        }
        let size = bounds.size
        var contentSize = CGSize(width: 0, height: bounds.height)
        for i in 0..<count! + 2 {
            let index = dataIndexFromUIndex(i)
            let origin = CGPoint(x: bounds.origin.x + CGFloat(i) * bounds.width, y: bounds.origin.x)
            let frame = CGRect(origin: origin, size: size)
            var cell = XJCirCleViewCell(frame: frame)
            cell.index = index
            circleViewDelegate?.circleView(self, configCell: &cell)
            scrollView.addSubview(cell)
            contentSize.width += bounds.width
            addTapGesOfCell(cell)
            cells.append(cell)
        }
        scrollView.contentSize = contentSize
        scrollView.contentOffset = CGPoint(x: bounds.width, y: 0)
        
        pageControl?.numberOfPages = count!
        pageControl?.currentPage = 0
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(onTimer), userInfo: nil, repeats: true)
        
    }
    
    private func addTapGesOfCell(_ cell: XJCirCleViewCell) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)))
        cell.addGestureRecognizer(tap)
    }
   @objc private func onTap(_ tap: UITapGestureRecognizer) {
        circleViewDelegate?.circleView?(self, didSelectedItemOfIndex: (tap.view as! XJCirCleViewCell).index!)
        //        guard didSelectedItemBlock != nil else {
        //            return
        //        }
        //        didSelectedItemBlock!((tap.view as! XJCirCleViewCell).index!)
    }
    
    @objc fileprivate func onTimer() {
        let offset = scrollView.contentOffset
        scrollView.setContentOffset(CGPoint(x: offset.x + scrollView.bounds.width, y: 0), animated: true)
    }
    
    fileprivate func offsetAtUIndex(_ index: Int) -> CGPoint {
        let cell = cells[index]
        let offsetX = cell.frame.origin.x
        return CGPoint(x: offsetX, y: 0)
    }
    private  func dataIndexFromUIndex(_ index: Int) -> Int {
        let count = circleViewDelegate?.numbersOfItemsInCircleView(self)
        guard count != nil && count! > 0 else {
            return 0
        }
        var dataIndex = index - 1
        if index == 0 {
            dataIndex = count! - 1
        } else if index == count! + 1 {
            dataIndex = 0
        }
        return dataIndex
    }
    
    
    
}
extension XJCirCleView: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer?.invalidate()
        timer = nil
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(onTimer), userInfo: nil, repeats: true)
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.bounds.width > 0 else {
            return
        }
        let count = circleViewDelegate?.numbersOfItemsInCircleView(self)
        guard count != nil && count! > 0 else {
            return
        }
        let floatIndex = scrollView.contentOffset.x / scrollView.bounds.width
        if floatIndex - CGFloat(Int(floatIndex)) == 0 {
            currentUIndex = Int(floatIndex)
            if currentUIndex == 0 {
                scrollView.contentOffset = offsetAtUIndex(count!)
                return
            } else if currentUIndex == count! + 1 {
                scrollView.contentOffset = offsetAtUIndex(1)
                return
            }
        }
    }
}
















//
//  XJCirCleViewCell.swift
//  CirCleViewTest2
//
//  Created by rxj on 2016/9/21.
//  Copyright © 2016年 renxiaojian. All rights reserved.
//

import UIKit

class XJCirCleViewCell: UIView {

    
    var index: Int?
    var imgView: UIImageView!
    var titleLabel: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.red
        imgView = UIImageView()
        imgView.backgroundColor = UIColor.purple
        addSubview(imgView)
        titleLabel = UILabel()
        titleLabel.textColor = UIColor.red
        imgView.addSubview(titleLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(imgView)
            make.centerX.equalTo(imgView)
        }
    }
    

}

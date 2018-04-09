//
//  ViewController.swift
//  one
//
//  Created by 陈欢 on 2017/11/18.
//  Copyright © 2017年 陈欢. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let lable = UILabel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lable.text = " Who I Am"
        lable.textAlignment = NSTextAlignment.center
        
        self.view.addSubview(lable)
        
        lable.snp.makeConstraints { (make) in
            make.top.equalTo(100)
            make.centerX.equalTo(self.view)
        }
        
        lable.font = UIFont.systemFont(ofSize: 30)
        
        let changeBtn = UIButton(type: .custom)
        changeBtn.setTitle("点击更改字体", for: UIControlState.normal)
        changeBtn.addTarget(self, action: #selector(changeFont), for: UIControlEvents.touchUpInside)
        changeBtn.setTitleColor(UIColor.blue, for: UIControlState.normal)
        
        self.view.addSubview(changeBtn)
        
        changeBtn.layer.borderColor = UIColor.blue.cgColor
        changeBtn.layer.borderWidth = 1
        changeBtn.layer.cornerRadius = 5
        
        changeBtn.snp.makeConstraints { (make) in
            make.top.equalTo(500)
            make.centerX.equalTo(self.view)
            make.width.equalTo(200)
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func changeFont() {
        lable.font = UIFont(name: "Savoye Let", size: 30)
    }


}


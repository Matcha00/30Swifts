//
//  ViewController.swift
//  sevent
//
//  Created by 陈欢 on 2017/11/18.
//  Copyright © 2017年 陈欢. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {

    var imageView:UIImageView!
    
    var scrollView:UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView = UIImageView(frame: self.view.bounds)
        imageView.image = UIImage(named: "samplePhoto.jpeg")
        imageView.isUserInteractionEnabled = true
        scrollView = UIScrollView(frame: self.view.frame)
        scrollView.maximumZoomScale = 4.0
        scrollView.minimumZoomScale = 1
        scrollView.backgroundColor = UIColor.black
        scrollView.contentSize = imageView.bounds.size
        scrollView.delegate = self;
        self.view.addSubview(scrollView)
        scrollView.addSubview(imageView);
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }


}


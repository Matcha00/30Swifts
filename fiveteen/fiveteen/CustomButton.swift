//
//  CustomButton.swift
//  fiveteen
//
//  Created by 陈欢 on 2017/11/20.
//  Copyright © 2017年 陈欢. All rights reserved.
//

import UIKit

enum ButtonImagePosition : Int {
    
    case PositionTop = 0
    case Positionleft
    case PositionBottom
    case PositionRight
    
}

extension UIButton {
    
    
    func setImageAndTitle(imageName: String, title: String, type: ButtonImagePosition, Space space:CGFloat) {
        self.setTitle(title, for: .normal)
        self.setImage(UIImage(named: imageName), for: .normal)
        self.setTitleColor(UIColor.white, for: .normal)
        
        let imageWith: CGFloat = (self.imageView?.frame.size.width)!
        
        let imageHeight: CGFloat = (self.imageView?.frame.size.height)!
        
        var labelWidth: CGFloat = 0.0
        var labelHeight: CGFloat = 0.0
        labelWidth = CGFloat(self.titleLabel!.intrinsicContentSize.width)
        labelHeight = CGFloat(self.titleLabel!.intrinsicContentSize.height)
        var  imageEdgeInsets :UIEdgeInsets = UIEdgeInsets();
        var  labelEdgeInsets :UIEdgeInsets = UIEdgeInsets();
        switch type {
        case .PositionTop:
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight - space/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
            break;
        case .Positionleft:
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
            break;
        case .PositionBottom:
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
            break;
        case .PositionRight:
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
            break;
        }
        
        // 4. 赋值
        self.titleEdgeInsets = labelEdgeInsets;
        self.imageEdgeInsets = imageEdgeInsets;
    }
    
            
            
            
            
            
    
    
}

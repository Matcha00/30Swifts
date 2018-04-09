//
//  fetchSubString.swift
//  eight
//
//  Created by 陈欢 on 2017/11/18.
//  Copyright © 2017年 陈欢. All rights reserved.
//

import Foundation

extension String {
    
    subscript (r:Range<Int>) -> String {
        
        get {
            
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)

            return self[startIndex..<endIndex]
            
        }
        
        
    }
    
    
}

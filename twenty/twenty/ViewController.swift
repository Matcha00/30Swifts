//
//  ViewController.swift
//  twenty
//
//  Created by 陈欢 on 2017/11/21.
//  Copyright © 2017年 陈欢. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {

    
    var wcsession: WCSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let generateNumberBtn = UIButton(type: .custom)
        generateNumberBtn.frame = CGRect(x: 10, y: 10, width: 200, height: 50)
        generateNumberBtn.setTitle("Generate Number", for: .normal)
        generateNumberBtn.setTitleColor(UIColor.black, for: .normal)
        self.view.addSubview(generateNumberBtn)
        generateNumberBtn.center = self.view.center
        generateNumberBtn.addTarget(self, action: #selector(generateNumber), for: .touchUpInside)
        generateNumberBtn.setTitleColor(UIColor.red, for: .highlighted)
        generateNumberBtn.setTitleColor(UIColor.green, for: .selected)
        generateNumberBtn.layer.borderColor = UIColor.black.cgColor
        generateNumberBtn.layer.borderWidth = 1
        generateNumberBtn.layer.cornerRadius = 8
        
        
        wcsession = WCSession.default()
        
        if WCSession.isSupported() {
            wcsession.delegate = self
            wcsession.activate()
        }
        
        
        self.view.backgroundColor = UIColor.yellow
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func generateNumber() {
        
        
        let number:Int = Int(arc4random()) % 5 + 1
        
        do {
            try wcsession.updateApplicationContext(["numberToBeGuessed": number])
            
        } catch  {
            print("error")
        }
        
     
        
        
        
        func sessionDidDeactivate(session: WCSession) {
            
        }
        
        func sessionDidBecomeInactive(session: WCSession) {
            
        }
        
        
        func session(session: WCSession, activationDidCompleteWith: WCSessionActivationState, error: Error?) {
            
        }
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    


}


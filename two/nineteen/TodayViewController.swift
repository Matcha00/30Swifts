//
//  TodayViewController.swift
//  nineteen
//
//  Created by 陈欢 on 2017/11/21.
//  Copyright © 2017年 陈欢. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var currentTIME: UILabel!
    
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefaults = UserDefaults(suiteName: "group.nimoAndHisFriend.two")
        
        var leftTimeWhenQuit = userDefaults?.double(forKey: "lefttime")
        
        currentTIME.text = String(format: "%0.1f", leftTimeWhenQuit!)
        
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (Timer) in
            leftTimeWhenQuit = leftTimeWhenQuit! + 0.1
            
            self.currentTIME.text = String(format: "%0.1f", leftTimeWhenQuit!)
        }
        self.timer.fire()
        
        // Do any additional setup after loading the view from its nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}

//
//  InterfaceController.swift
//  watchtwenty WatchKit Extension
//
//  Created by 陈欢 on 2017/11/21.
//  Copyright © 2017年 陈欢. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController, WCSessionDelegate{
   
    @IBOutlet var resultOfGuess: WKInterfaceLabel!
    
    @IBOutlet var resultSlider: WKInterfaceSlider!
    
    @IBOutlet var resultLabel: WKInterfaceLabel!
    @IBOutlet var resultConfirmButton: WKInterfaceButton!
    
    var numberToBeGuessed: Int!
    var numberOfSlider: Int  = 3
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    @IBAction func sliderUpdate(_ value: Float) {
        
        numberOfSlider = Int(value * 5)
        resultLabel.setText("You guess: \(numberOfSlider)")
        
    }

    @IBAction func guessAction() {
 
    
        if numberToBeGuessed == nil {
            resultOfGuess.setText("open iPhone App first")
        }
        
        else if numberOfSlider == numberToBeGuessed {
            resultOfGuess.setText("回答正确")
        }
        
        else {
            resultOfGuess.setText("zailaiyici")
        }
    
    
    }
    
    
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        numberToBeGuessed = applicationContext["numberToBeGuessed"] as! Int
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

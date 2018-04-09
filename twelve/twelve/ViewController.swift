//
//  ViewController.swift
//  twelve
//
//  Created by 陈欢 on 2017/11/18.
//  Copyright © 2017年 陈欢. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    
    var slotMacHine : UIPickerView!
    
    var emojiArray = ["😀","😎","😈","👻","🙈","🐶","🌚","🍎","🎾","🐥","🐔"]
    var resultLabel : UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createSloMachine()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    func createSloMachine() {
        
        slotMacHine = UIPickerView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 220))
        self.view.addSubview(slotMacHine)
        slotMacHine.delegate = self
        slotMacHine.dataSource = self
        slotMacHine.center.x = self.view.center.x
        slotMacHine.center.y = self.view.center.y - 50
        
        slotMacHine.selectRow(Int(arc4random())%(emojiArray.count - 2) + 1, inComponent: 0, animated: false)
        
        slotMacHine.selectRow(Int(arc4random())%(emojiArray.count - 2) + 1, inComponent: 1, animated: false)
        slotMacHine.selectRow(Int(arc4random())%(emojiArray.count - 2) + 1, inComponent: 2, animated: false)
        
        
        let goButton = UIButton(type: .roundedRect)
        goButton.backgroundColor = UIColor.green
        goButton.frame = CGRect(x: 0, y: 0, width: 275, height: 40)
        //goButton.backgroundColor = UIColor.green
        self.view.addSubview(goButton)
        goButton.setTitle("Go", for: UIControlState.normal)
        goButton.setTitleColor(UIColor.white, for: .normal)
        goButton.center.x = self.view.center.x
        goButton.center.y = self.view.center.y + 140
        goButton.addTarget(self, action: #selector(goAction), for: UIControlEvents.touchUpInside)
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(longTapAction))
        doubleTapGesture.numberOfTapsRequired = 2
        goButton.addGestureRecognizer(doubleTapGesture)
        
        resultLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        resultLabel.textAlignment = .center
        resultLabel.font = UIFont.systemFont(ofSize: 20)
        resultLabel.text = ""
        resultLabel.textColor = UIColor.black
        self.view.addSubview(resultLabel)
        resultLabel.center.x = self.view.center.x
        resultLabel.center.y = goButton.center.y + 100
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return emojiArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 90
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLable = UILabel()
        pickerLable.text = emojiArray[row]
        pickerLable.textAlignment = .center
        pickerLable.font = UIFont.systemFont(ofSize: 60)
        return pickerLable
    }
    
    
    func goAction() {
        
        slotMacHine.selectRow(Int(arc4random())%(emojiArray.count - 2) + 1, inComponent: 0, animated: true)
        slotMacHine.selectRow(Int(arc4random())%(emojiArray.count - 2) + 1, inComponent: 1, animated: true)
        slotMacHine.selectRow(Int(arc4random())%(emojiArray.count - 2) + 1, inComponent: 2, animated: true)
        
        self.judge()
        
    }
    
    func longTapAction() {
        
        let result = Int(arc4random())%(emojiArray.count - 2)
        slotMacHine.selectRow(result + 1, inComponent: 0, animated: true)
        slotMacHine.selectRow(result + 1, inComponent: 1, animated: true)
        slotMacHine.selectRow(result + 1, inComponent: 2, animated: true)
        
        self.judge()

        
    }
    
    
    func judge() {
        
        if slotMacHine.selectedRow(inComponent: 0) == slotMacHine.selectedRow(inComponent: 1) && slotMacHine.selectedRow(inComponent: 1) == slotMacHine.selectedRow(inComponent: 2) {
            resultLabel.text = "👏👏👏"
        }
        else {
            resultLabel.text = "💔💔💔"
        }
    }
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


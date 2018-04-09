//
//  ViewController.swift
//  seventeen
//
//  Created by 陈欢 on 2017/11/20.
//  Copyright © 2017年 陈欢. All rights reserved.
//

import UIKit
import SafariServices
class ViewController: UIViewController, UIViewControllerPreviewingDelegate {

    
    
    var actionLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actionLable = UILabel(frame: CGRect(x: 50, y: 50, width: 400, height: 50))
        
        actionLable.text = "3D Touch"
        
        self.view.addSubview(actionLable)
        
        
        let notificationName = Notification.Name(rawValue: "ShortcutAction")
        
        NotificationCenter.default.addObserver(self, selector: #selector(shortCutActionClicked(sender:)), name: notificationName, object: nil)
        
        let fingerPrintImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 128, height: 128))
        fingerPrintImageView.image = #imageLiteral(resourceName: "fingerprint.png")
        self.view.addSubview(fingerPrintImageView)
        fingerPrintImageView.center = self.view.center
        
        self.registerForPreviewing(with: self, sourceView: self.view)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func changeLable(with name:String) {
        actionLable.text = name
    }
    
    
    func shortCutActionClicked(sender:Notification) {
        
        let shortcutItem = sender.userInfo?["shortcutItem"] as! UIApplicationShortcutItem
        
        
        
        if shortcutItem.type == "LoveItem" {
            self.changeLable(with: "Yes, I do ❤️ you!")
                }
        
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        // 通过上下文可以调整不被虚化的范围
        previewingContext.sourceRect = CGRect(x: 10, y: 10, width: self.view.frame.width - 20, height: self.view.frame.height - 10)
        return SFSafariViewController(url: NSURL(string: "http://www.qq.com")! as URL)
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        self.show(viewControllerToCommit, sender: self)
    }
}
extension SFSafariViewController {
    open var previewActionTtems: [UIPreviewActionItem] {
        
        let deleteAction = UIPreviewAction(title: "删除", style: .destructive) { (previewAction, vc) in
            print("Delete")
        }
        let doneAction = UIPreviewAction(title: "完成", style: .default) { (previewAction, vc) in
            print("Done")
        }
        return [deleteAction,doneAction]
        
    }
}





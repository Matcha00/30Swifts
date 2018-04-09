//
//  ViewController.swift
//  five
//
//  Created by 陈欢 on 2017/11/18.
//  Copyright © 2017年 陈欢. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    var dataSource = Array<Date>()
    let refresh = UIRefreshControl()
    
    var table : UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table = UITableView(frame: self.view.bounds)
        table.frame.origin.y   = 44
        self.view.addSubview(table)
        table.delegate = self
        table.dataSource = self
        addNewElementToArray()
        
        refresh.attributedTitle = NSAttributedString(string: "dont ")
        refresh.addTarget(self, action: #selector(pullTheRefresh), for: UIControlEvents.valueChanged)

        table.addSubview(refresh)
        table.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pullTheRefresh() {
        addNewElementToArray()
        refresh.endRefreshing()
        table.reloadData()
    }
    
    func addNewElementToArray() {
        dataSource.insert(NSDate() as Date, at: 0)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  UITableViewCell(style: .default, reuseIdentifier: "CHId")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        let dateStr = dateFormatter.string(from: dataSource[indexPath.row])
        cell.textLabel?.text = dateStr
        return cell
    }
}


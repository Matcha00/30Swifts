//
//  ViewController.swift
//  twenty-one
//
//  Created by 陈欢 on 2017/11/21.
//  Copyright © 2017年 陈欢. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    
    
    let table = UITableView()
    
    var datasource = Array<ChenHuan>()
    
    let EntityName = "ChenHuan"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Todo List"
        
        let rightBarItem = UIBarButtonItem(title: "+", style: .done, target: self, action: #selector(addTodoList))
        self.navigationItem.rightBarButtonItem = rightBarItem
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        table.frame = self.view.frame
        self.view.addSubview(table)
        
        table.delegate = self
        table.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addTodoList() {
        
        let alertController = UIAlertController(title: "Add New Todo List", message: "", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: UIAlertActionStyle.default, handler: ({
            (_) in
            if let field = alertController.textFields![0] as? UITextField {
                self.saveContent(content: field.text!)
                self.updateDataSource()
                self.table.reloadData()
            }
        }))

        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Please input the todo Item"

        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
            
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "chtest")
        
        cell.textLabel?.text = datasource[indexPath.row].ooooo
        
        return cell
    }
   
    
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func saveContent(content:String){
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: EntityName, in: context)
        
        let todoList = NSManagedObject(entity: entity!, insertInto: context)
        
        todoList.setValue(content, forKey: "ooooo")
        
        do {
            try context.save()
        }catch{
            print(error)
        }
    }
    
  
    func updateDataSource(){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName)
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            datasource = searchResults as! [ChenHuan]
        } catch  {
            print(error)
        }


}
}


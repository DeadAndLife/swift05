//
//  ViewController.swift
//  07-SQLite第三方库
//
//  Created by qingyun on 16/8/5.
//  Copyright © 2016年 QingYun. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var db:Connection!
        let students = Table("students")
        let id = Expression<Int64>("id")
        let name = Expression<String>("name")

        let path = NSHomeDirectory() + "/students.db"
        print(path)
        do {
            try db = Connection(path)
            
            try db.run(students.create{t in
                t.column(id,primaryKey:true)
                t.column(name)
                
                })

        }catch{
            print("创建失败")
        }
        
        let insert = students.insert(name <- "zhangsan")
        let rowid = try? db.run(insert)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  ViewController.swift
//  01-两个tableView联动
//
//  Created by qingyun on 16/8/5.
//  Copyright © 2016年 QingYun. All rights reserved.
//

import UIKit

//全局常量可以实现类似宏定义的功能
let ScreenWidth = UIScreen.mainScreen().bounds.size.width
let ScreenHeight = UIScreen.mainScreen().bounds.size.height

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var leftTableView:UITableView!
    var rightVC:RightViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        automaticallyAdjustsScrollViewInsets = false
        
        leftTableView = UITableView(frame: CGRectMake(0, 64, ScreenWidth*0.25, ScreenHeight), style: .Plain)
        leftTableView.dataSource = self
        leftTableView.delegate = self
        view.addSubview(leftTableView)
        
        rightVC = RightViewController()
        self.addChildViewController(rightVC)
        view.addSubview(rightVC.view)
        //设置左侧控制器为右侧的代理
        rightVC.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    //MARK: - UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = "分类\(indexPath.row)"
        
        return cell!
    }
    
    //MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        rightVC.categorySelectedIndexPath = indexPath
    }
}
extension ViewController:RightTableViewDelegate{
    func didScrollUp(row: Int) {
        leftTableView.selectRowAtIndexPath(NSIndexPath(forRow: row,inSection: 0), animated: true, scrollPosition: .Top)
    }
    func didScrollDown(row: Int) {
        leftTableView.selectRowAtIndexPath(NSIndexPath(forRow: row,inSection: 0), animated: true, scrollPosition: .Top)
    }
}

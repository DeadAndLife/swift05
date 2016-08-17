//
//  RightViewController.swift
//  01-两个tableView联动
//
//  Created by qingyun on 16/8/5.
//  Copyright © 2016年 QingYun. All rights reserved.
//

import UIKit

class RightViewController: UIViewController {

    var rightTableView:UITableView!
    var isScrollDown:Bool = false
    var lastContentOffsetY:CGFloat = 0
    var delegate:RightTableViewDelegate!
    
    var categorySelectedIndexPath:NSIndexPath!{
        didSet{
            rightTableView.selectRowAtIndexPath(NSIndexPath(forRow: 0,inSection: categorySelectedIndexPath.row), animated: true, scrollPosition: .Top)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.frame = CGRectMake(ScreenWidth*0.25, 64, ScreenWidth*0.75, ScreenHeight-64)
        
        rightTableView = UITableView(frame: view.bounds, style: .Plain)
        //rightTableView.contentSize = CGSizeMake(ScreenWidth*0.75, 5*ScreenHeight)
        rightTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 300, right: 0)
        rightTableView.dataSource = self
        rightTableView.delegate = self
        view.addSubview(rightTableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    //MARK: - UITableViewDataSource
    
}

extension RightViewController:UITableViewDataSource,UITableViewDelegate{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = "row\(indexPath.row)"
        return cell!
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "分区\(section)"
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        //向上滑,对应左侧应该选中section对应的行
        if !isScrollDown {
            if delegate != nil{
                delegate.didScrollUp(section)
            }
        }
        
    }
    func tableView(tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        //向下滑,对应左侧应该选中section+1对应的行
        if isScrollDown{
            if delegate != nil{
                delegate.didScrollDown(section+1)
            }
        }
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if lastContentOffsetY < scrollView.contentOffset.y{
            print("向下")
            isScrollDown = true
        }else {
            print("向上")
            isScrollDown = false
        }
        
        lastContentOffsetY = scrollView.contentOffset.y
    }
    
    
}

protocol RightTableViewDelegate {
    func didScrollDown(row:Int)
    func didScrollUp(row:Int)
}
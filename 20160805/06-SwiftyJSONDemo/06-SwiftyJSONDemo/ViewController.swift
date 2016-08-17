//
//  ViewController.swift
//  06-SwiftyJSONDemo
//
//  Created by qingyun on 16/8/5.
//  Copyright © 2016年 QingYun. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

let url="http://news-at.zhihu.com/api/4/news/latest"
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        Alamofire.request(.GET, url).responseJSON { (response) in
            switch response.result{
            case .Success(let value):
                //解析
                let json = JSON(value)
                print(json["date"])
                
                
                //多下标的使用
                print(json["stories"][0]["title"])
                print(json["stories",1,"id"])
                
                
                //转换类型
                //.int/bool/string...取到的为可选类型
                let id = json["stories",2,"id"].int
                print(id)
                
                //.intValue/.stringValue...非可选
                let imageURL = json["stories",0,"images",0].stringValue
                print(imageURL)
                
                //元素个数/键值对数
                print(json["stories"].count)
                
                
                //取出原始值
                let stories = json["stories"].rawValue as! NSArray
                print(stories.count)
                
                
            case .Failure(let err):
                print(err)
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


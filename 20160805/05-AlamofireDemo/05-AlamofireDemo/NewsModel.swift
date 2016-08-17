//
//  NewsModel.swift
//  05-AlamofireDemo
//
//  Created by qingyun on 16/8/5.
//  Copyright © 2016年 QingYun. All rights reserved.
//

import UIKit
import ObjectMapper

class NewsModel: NSObject,Mappable {
    var date:String?
    var stories:[StoryModel]?
    
    required init?(_ map: Map) {
        
    }
    func mapping(map: Map) {
        date <- map["date"]
        stories <- map["stories"]
    }
}

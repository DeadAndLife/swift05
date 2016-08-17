//
//  StoryModel.swift
//  05-AlamofireDemo
//
//  Created by qingyun on 16/8/5.
//  Copyright © 2016年 QingYun. All rights reserved.
//

import UIKit
import ObjectMapper

class StoryModel: NSObject, Mappable{
    var images:[String]?
    var type:Int?
    var id:Int?
    var ga_prefix:String?
    var title:String?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        images <- map["images"]
        type <- map["type"]
        id <- map["id"]
        ga_prefix <- map["ga_prefix"]
        title <- map["title"]
    }
}

//
//  ViewController.swift
//  05-AlamofireDemo
//
//  Created by qingyun on 16/8/5.
//  Copyright © 2016年 QingYun. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

let url="http://news-at.zhihu.com/api/4/news/latest"
let downloadUrl = "http://www.hangge.com/blog/images/logo.png"
let downloadQQUrl = "http://dldir1.qq.com/qqfile/qq/QQ7.9/16621/QQ7.9.exe"
class ViewController: UIViewController {

    @IBOutlet weak var progressView: UIProgressView!
    
    let defaultDest = Alamofire.Request.suggestedDownloadDestination(directory: .DocumentDirectory, domain: .UserDomainMask)
    var downloadRequest:Request!
    
    var cancelData:NSData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //网络请求数据及解析为模型:
//        Alamofire.request(.GET, url).responseString { (response) in
//            //print(response.result)
//            switch response.result{
//            case .Success(let value):
//                //print(value)
//                let news = Mapper<NewsModel>().map(value)
//                
//                print(news?.stories?.count)
//                for story in news!.stories! {
//                    print("\(story.id):\(story.title)")
//                }
//                
//            case .Failure(let err):
//                print(err)
//            }
//        }
        
//        downloadFile()//默认路径
//        downloadFileWithCustomDir()//自定义路径
        
        progressView.progress = 0
        
        progressView.transform = CGAffineTransformMakeScale(1, 3.0)
        
    }

    func downloadFile(){
        let defaultDest = Alamofire.Request.suggestedDownloadDestination(directory: .DocumentDirectory, domain: .UserDomainMask)
//        Alamofire.download(.GET, downloadUrl,defaultDest)
        Alamofire.download(.GET, downloadQQUrl, destination: defaultDest).progress { (bytes, totalReadBytes, totalBytes) in
            print("\(CGFloat(totalReadBytes)/CGFloat(totalBytes))")
        }
//        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first
//        print(path)
    }
    func downloadFileWithCustomDir(){
        Alamofire.download(.GET, downloadUrl) { (tempURL, response) -> NSURL in
            let fileMng = NSFileManager.defaultManager()
            let documentDir = fileMng.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first
            let dir = documentDir?.URLByAppendingPathComponent("file1",isDirectory: true)
            
            if !fileMng.fileExistsAtPath((dir?.path)!){
                do {
                try fileMng.createDirectoryAtURL(dir!, withIntermediateDirectories: true, attributes: nil)
                }catch{
                    print("创建目录失败")
                }
            }
            return dir!.URLByAppendingPathComponent("myimg.png")
        }
    }

    @IBAction func btnClick(sender: UIButton) {
        if sender.titleLabel?.text == "开始下载"{
            sender.setTitle("暂停下载", forState: .Normal)
            //开始下载或者继续下载
            if cancelData == nil{
                //首次下载

                downloadRequest = Alamofire.download(.GET, downloadQQUrl, destination: defaultDest)
            }else{
                downloadRequest = Alamofire.download(resumeData: cancelData!, destination: defaultDest)
            }
            downloadRequest.progress(downloadProgress)
            downloadRequest.response(completionHandler: downloadResponse)
            
        }else {
            sender.setTitle("开始下载", forState: .Normal)
            //取消下载
            downloadRequest.cancel()
        }
        
    }
    func downloadProgress(bytes:Int64, totalReadBytes:Int64, totalBytes:Int64){
        //计算进度
        let progress = Float(totalReadBytes)/Float(totalBytes)
        //设置进度条的进度
        dispatch_async(dispatch_get_main_queue()) { 
            self.progressView.setProgress(progress, animated: true)
        }
    }
    func downloadResponse(request:NSURLRequest?, response:NSHTTPURLResponse?, data:NSData?, error:NSError?){
        if let err = error{//下载出错
            if err.code == NSURLErrorCancelled{//下载取消的错误码
                cancelData = data
            }else {
                print("Failed to download")
            }
        } else{
            print("Success download")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  ViewController.swift
//  02-storyboard的使用
//
//  Created by qingyun on 16/8/5.
//  Copyright © 2016年 QingYun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let secondVC = segue.destinationViewController as! SecondViewController
        secondVC.detailString = textField.text
        
    }

    @IBAction func unwindSegueToFirstVC(segue:UIStoryboardSegue){
    
        //swift is == OC的isKindOfClass
        if segue.sourceViewController is SecondViewController {
            print("从secondVC跳转来的")
        } else if segue.sourceViewController is GreenViewController {
            print("从greenVC跳转来的")
        }
    }
}


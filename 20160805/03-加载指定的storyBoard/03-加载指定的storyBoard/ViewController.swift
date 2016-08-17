//
//  ViewController.swift
//  03-加载指定的storyBoard
//
//  Created by qingyun on 16/8/5.
//  Copyright © 2016年 QingYun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    @IBAction func toSecondVC(sender: UIButton) {
        
        let secondStoryboard = UIStoryboard(name: "Second", bundle: nil)
        let secondVC = secondStoryboard.instantiateViewControllerWithIdentifier("secondVC") as! SecondViewController
        
        presentViewController(secondVC, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  Test1ViewController.swift
//  KDTK
//
//  Created by 李顺风 on 2017/10/28.
//  Copyright © 2017年 lishunfeng.org. All rights reserved.
//

import UIKit

class Test1ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var test1: UIButton!
    
    @IBAction func testclick(_ sender: Any) {
        
        let vc = KDWebVC()
        vc.urlStr = "www.baidu.com"
        pushVC(vc, animated: true)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  Random.swift
//  Drawlots
//
//  Created by 林家辉 on 2019/1/7.
//  Copyright © 2019年 Georgehu. All rights reserved.
//

import UIKit

class RandomViewController: UIViewController {

    var flag: Bool = true
    @IBOutlet weak var start: UITextField!
    @IBOutlet weak var end: UITextField!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    
    @IBAction func random(_ sender: Any) {
         result.text = String(Int(arc4random()) % (Int(end.text!)! - Int(start.text!)! + 1) + Int(start.text!)!)
    }

    //开始按钮
    @IBAction func startBtn(_ sender: Any) {
        //var timer = Timer()
        if(flag)
        {
            startBtn.setTitle("停止",for: .normal)
            // 启用计时器，控制每秒执行一次tickDown方法
            //timer = Timer.scheduledTimer(timeInterval: 0.5,target:self,selector:Selector(("random")),userInfo:nil,repeats:true)
            
        }
        else
        {
            startBtn.setTitle("开始",for: .normal)
            //timer.invalidate()
        }
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

//
//  Random.swift
//  Drawlots
//
//  Created by 林家辉 on 2019/1/7.
//  Copyright © 2019年 Georgehu. All rights reserved.
//

import UIKit

class RandomViewController: UIViewController {

    @IBOutlet weak var start: UITextField!
    @IBOutlet weak var end: UITextField!
    @IBOutlet weak var result: UILabel!
    
    @IBAction func random(_ sender: Any) {
         result.text = String(Int(arc4random()) % (Int(end.text!)! - Int(start.text!)! + 1) + Int(start.text!)!)
    }

    /*
    func randomIn(min: Int, max: Int) -> Int {
        return Int(arc4random()) % (max - min + 1) + min
    }
    */
    
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

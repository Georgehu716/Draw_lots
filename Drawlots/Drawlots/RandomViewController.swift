//
//  Random.swift
//  Drawlots
//
//  Created by Georgehu on 2019/1/7.
//  Copyright © 2019年 Georgehu. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation
import AudioToolbox


class RandomViewController: UIViewController {

    var flag: Bool = true
    var timer = Timer()
    var audioPlayer: AVAudioPlayer!
    
    @IBOutlet weak var start: UITextField!
    @IBOutlet weak var end: UITextField!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    
    
    
    //生成随机数
    /*浮点随机数
    func randomF() -> Float {
        return Float(arc4random())
    }
    func random(min: Float, max: Float) -> Float {
        return randomF() * (max - min + 1) + min
    }*/
    
    @IBAction func random(_ sender: Any) {
         result.text = String(Int(arc4random()) % (Int(end.text!)! - Int(start.text!)! + 1) + Int(start.text!)!)
    }

    //开始按钮
    @IBAction func startBtn(_ sender: Any) {
        if start.text == "" || end.text == ""{
            showMsgbox(_message: "请输入随机数范围！")
            return
        }
        if Int(start.text!)! > Int(end.text!)!{
            showMsgbox(_message: "请输入正确的随机数范围！")
            return
        }
        
        if(flag)
        {
            //audioPlayer.play()
            startBtn.setTitle("停止",for: .normal)
            flag = false
            //启用计时器，控制每秒执行一次tickDown方法
            timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(random), userInfo: nil, repeats: true)
            
        }
        else
        {
            startBtn.setTitle("开始",for: .normal)
            flag = true
            timer.invalidate()
        }
    }
    
    //错误提示
    func showMsgbox(_message: String, _title: String = "提示"){
        
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertControllerStyle.alert)
        let btnOK = UIAlertAction(title: "好的", style: .default, handler: nil)
        alert.addAction(btnOK)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //音频播放器
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
        let soundFileURL: NSURL = NSURL.init(fileURLWithPath: NSTemporaryDirectory()+"sound.caf")
        let soundSetting = [
            AVSampleRateKey: 44100.0,
            AVFormatIDKey: NSNumber(value: kAudioFormatMPEG4AAC),
            AVNumberOfChannelsKey: 2,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ] as [String : Any]
        
        //audioRecorder = try?AVAudioRecorder(URL: soundFileURL, setting: soundSetting)
        
        let noSoundFileURL: NSURL = NSURL.init(fileURLWithPath: Bundle.main.path(forResource: "bg", ofType: "mp3")!)
        audioPlayer = try?AVAudioPlayer(contentsOf: noSoundFileURL as URL)

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

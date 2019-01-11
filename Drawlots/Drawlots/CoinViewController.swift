//
//  CoinViewController.swift
//  Drawlots
//
//  Created by 林家辉 on 2019/1/7.
//  Copyright © 2019年 fcxl9876. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation
import AudioToolbox


class CoinViewController: UIViewController {

    var flag: Bool = true
    var timer = Timer()
    var coin: Int!
    var audioPlayer: AVAudioPlayer!
    
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var coinImage: UIImageView!
    
    //随机
    @IBAction func random(_ sender: Any) {
        coin = Int(arc4random()) % (1 - 0 + 1) + 0
        if(coin == 1)
        {
            //result.text = "正面"
            coinImage.image = UIImage(named: "正面")
            
        }
        else
        {
            //result.text = "反面"
            coinImage.image = UIImage(named: "反面")
        }
    }
    //开始
    @IBAction func startBtn(_ sender: Any) {
        if(flag)
        {
            audioPlayer.play()
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
            if(coin == 1)
            {
                result.text = "正面"
                coinImage.image = UIImage(named: "正面")
            }
            else
            {
                result.text = "反面"
                coinImage.image = UIImage(named: "反面")
            }
        }
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
        
        let noSoundFileURL: NSURL = NSURL.init(fileURLWithPath: Bundle.main.path(forResource: "coin", ofType: "wav")!)
        audioPlayer = try?AVAudioPlayer(contentsOf: noSoundFileURL as URL)        // Do any additional setup after loading the view.
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

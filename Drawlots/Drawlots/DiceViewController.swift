//
//  DiceViewController.swift
//  Drawlots
//
//  Created by 林家辉 on 2019/1/7.
//  Copyright © 2019年 fcxl9876. All rights reserved.
//

import UIKit
import AudioToolbox
import SpriteKit
import AVFoundation


class DiceViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer!
    
    //骰子动画
    var diceAnimationView: CPK3DiceAnimationView?
    //是否正在进行骰子动画
    var isDiceMoving: Bool = false
    //骰子动画类型
    var typePlays: [DiceAnimationType] = [.hzType]
    var diceCount = 3
    var typePlay: DiceAnimationType = .hzType
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
        
        let noSoundFileURL: NSURL = NSURL.init(fileURLWithPath: Bundle.main.path(forResource: "dice", ofType: "wav")!)
        audioPlayer = try?AVAudioPlayer(contentsOf: noSoundFileURL as URL)
        
        
        let diceCount = UILabel()
        diceCount.text = "选择骰子个数"
        diceCount.textColor = UIColor.white
        diceCount.textAlignment = .left
        diceCount.frame = CGRect(x: 10, y: self.view.center.y + 150, width: self.view.frame.size.width - 20, height: 40)
        self.view.addSubview(diceCount)
        
        let diceBtnWidth = ScreenWidth / 3.0
        for i in 0..<3 {
            let btn = UIButton()
            btn.tag = 200 + i
            btn.frame = CGRect(x: diceBtnWidth * CGFloat(i), y: self.view.center.y + 200, width: diceBtnWidth, height: 40)
            btn.setTitle(String(i + 1) + "个", for: UIControlState())
            if i == 2 {
                btn.backgroundColor = UIColor.red
            } else {
                btn.backgroundColor = UIColor.white
            }
            btn.setTitleColor(UIColor.brown, for: UIControlState())
            btn.setBackgroundImage(#imageLiteral(resourceName: "button_default"), for: UIControlState.normal)
            btn.setBackgroundImage(#imageLiteral(resourceName: "button_highlight"), for: UIControlState.highlighted)
            btn.addTarget(self, action: #selector(self.changeDiceCount(btn:)), for: .touchUpInside)
            self.view.addSubview(btn)
        }
        
        let startBtn = UIButton()
        startBtn.frame = CGRect(x: 10, y: self.view.center.y + 250, width: ScreenWidth - 20, height: 40)
        startBtn.setTitle("摇一摇", for: UIControlState())
        startBtn.setTitleColor(UIColor.brown, for: UIControlState())
        startBtn.setBackgroundImage(#imageLiteral(resourceName: "button_default"), for: UIControlState.normal)
        startBtn.setBackgroundImage(#imageLiteral(resourceName: "button_highlight"), for: UIControlState.highlighted)
        startBtn.addTarget(self, action: #selector(self.shakeDice), for: .touchUpInside)
        self.view.addSubview(startBtn)
        
        self.initDiceAnimationView()
    }
    
    //返回骰子动画类型和骰子数
    func getDiceAnimationCount() -> Int {
        return self.diceCount
    }
    
    //返回骰子动画类型
    func getDiceAnimationType() -> DiceAnimationType {
        return self.typePlay
    }
    
    //骰子动画开始
    func diceAnimationStart() {
        audioPlayer.play()
        diceAnimationView?.isHidden = false
        self.view.isUserInteractionEnabled = false
        self.isDiceMoving = true
        diceAnimationView?.startAnimation()
    }
    
    //骰子动画结束
    func diceAnimationStop(_ diceArr:[Int]) {
        // Do nothing
    }
    
    func diceAnimationChangeFrame(){
        weak var ws = self
        UIView.animate(withDuration: 1.0, animations: {
            ws!.diceAnimationView?.alpha = 0.0
        }, completion: { (true) in
            ws!.diceAnimationView?.isHidden = true
            ws!.diceAnimationView?.alpha = 1.0
            ws!.isDiceMoving = false
        })
    }
    
    func diceAnimationDisappear() {
        diceAnimationView?.imageDong1.frame = CGRect(x:self.view.center.x, y: self.view.center.y, width: 0, height: 0)
        diceAnimationView?.imageDong2.frame = CGRect(x:self.view.center.x, y: self.view.center.y, width: 0, height: 0)
        diceAnimationView?.imageDong3.frame = CGRect(x:self.view.center.x, y: self.view.center.y, width: 0, height: 0)
        
    }
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            if isDiceMoving == false {
                self.diceAnimationStart()
            }
        }
    }
    
    //按钮的点击事件
    //改变类型（已作废）
    @objc func changeType(btn: UIButton) {
        // Do nothing.
    }
    
    //改变骰子个数
    @objc func changeDiceCount(btn: UIButton) {
        self.dismissDiceAnimationView()
        for btn in self.view.subviews {
            if btn.tag == 200 {
                btn.backgroundColor = UIColor.white
            } else if btn.tag == 201 {
                btn.backgroundColor = UIColor.white
            } else if btn.tag == 202 {
                btn.backgroundColor = UIColor.white
            }
        }
        if btn.tag == 200 {
            btn.backgroundColor = UIColor.red
        } else if btn.tag == 201 {
            btn.backgroundColor = UIColor.red
        } else if btn.tag == 202 {
            btn.backgroundColor = UIColor.red
        }
        self.diceCount = btn.tag - 200 + 1
        self.initDiceAnimationView()
    }
    
    @objc func shakeDice() {
        self.diceAnimationStart()
    }
    
    func initDiceAnimationView() {
        if self.diceAnimationView == nil {
            self.diceAnimationView = CPK3DiceAnimationView(diceCount: getDiceAnimationCount(), diceAnimationType: getDiceAnimationType(),animations:1.0)
            self.view.addSubview(diceAnimationView!)
            weak var ws = self
            self.diceAnimationView?.diceFinishBlock = { (finish,diceArr) -> Void in
                if finish == true {
                    ws!.view.isUserInteractionEnabled = true
                    ws!.diceAnimationStop(diceArr)
                }
            }
        }
    }
    
    func dismissDiceAnimationView() {
        if self.diceAnimationView != nil {
            self.diceAnimationView?.removeFromSuperview()
            self.diceAnimationView = nil
        }
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

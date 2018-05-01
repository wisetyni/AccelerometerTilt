//
//  ViewController.swift
//  AccelerometerTilt
//
//  Copyright © 2018 Learning Mobile Apps. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    let motionManager = CMMotionManager()
    var timer: Timer!
    var counter:Int = 0

    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var btnTiltOutlet: UIButton!
    @IBAction func btnTilt(_ sender: Any) {
        counter += 1
        lblScore.text = String(counter)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        counter = 0
        
        motionManager.accelerometerUpdateInterval = 0.05
        motionManager.startAccelerometerUpdates()
        motionManager.startGyroUpdates()
        motionManager.startMagnetometerUpdates()
        motionManager.startDeviceMotionUpdates()
        
        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func update() {
        if let accelerometerData = motionManager.accelerometerData {
            let acceleration = accelerometerData.acceleration
            let moveFactor = 15
            var rect: CGRect  = btnTiltOutlet.frame
            let moveToX = rect.origin.x + CGFloat((acceleration.x * Double(moveFactor)))          //3
            let moveToY = (rect.origin.y + rect.size.height) - CGFloat((acceleration.y * Double(moveFactor)))                                                                    //4
            let maxX = self.view.frame.size.width - rect.size.width                    //5
            let maxY = self.view.frame.size.height                                     //6
            if(moveToX > 0 && moveToX < maxX){                                            //7
                rect.origin.x += CGFloat((acceleration.x * Double(moveFactor)))
            }
            if(moveToY > rect.size.height && moveToY < maxY){                             //8
                rect.origin.y -= CGFloat((acceleration.y * Double(moveFactor)))
            }
            
            UIView.animate(withDuration: 0, delay: 0, options: [.curveEaseInOut], animations: {
                self.btnTiltOutlet.frame = rect;
            }, completion: nil)
            print(accelerometerData)
        }
        if let gyroData = motionManager.gyroData {
            print(gyroData)
        }
        if let magnetometerData = motionManager.magnetometerData {
            print(magnetometerData)
        }
        if let deviceMotion = motionManager.deviceMotion {
            print(deviceMotion)
        }
    }


}


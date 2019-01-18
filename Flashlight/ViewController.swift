//
//  ViewController.swift
//  Flashlight
//
//  Created by Евгений Дьяконов on 18/01/2019.
//  Copyright © 2019 Евгений Дьяконов. All rights reserved.
//

import AVFoundation
import UIKit

class ViewController: UIViewController {
    
    var flaslightOn = false
    let flashlightOnBgDefaultColor : UIColor = .white
    let flashlightOffBgDefaultColor : UIColor = .black
    
    @IBAction func flashlightButtonPressed(_ sender: UIButton) {
        toggleFlashlight()
        updateUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateUI()
    }
    
    func toggleFlashlight() {
        let device = AVCaptureDevice.default(for: AVMediaType.video)
        
        if let dev = device, dev.hasTorch {
            do {
                try dev.lockForConfiguration()
                
                if (dev.torchMode == AVCaptureDevice.TorchMode.on) {
                    dev.torchMode = AVCaptureDevice.TorchMode.off
                    flaslightOn = false
                    print("Flashlight is disabled.")
                } else {
                    do {
                        try dev.setTorchModeOn(level: 1.0)
                        flaslightOn = true
                        print("Flashligh is enabled.")
                    } catch {
                        print(error)
                    }
                }
                
                dev.unlockForConfiguration()
            } catch {
                print(error)
            }
        }
    }
    
    func updateUI() {
        view.backgroundColor = flaslightOn ? flashlightOnBgDefaultColor : flashlightOffBgDefaultColor
    }
}


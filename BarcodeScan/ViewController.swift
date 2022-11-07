//
//  ViewController.swift
//  BarcodeScan
//
//  Created by Rivaldo Fernandes on 07/11/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
                return
            }
            
            let videoInput: AVCaptureDeviceInput
            
            do {
                videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            }catch{
                return
            }
            
            if (self.captureSession.canAddInput(videoInput)){
                self.captureSession.addInput(videoInput)
            }else{
                return
            }
            
            let metadataOutput = AVCaptureMetadataOutput()
            
            if(self.captureSession.canAddOutput(metadataOutput)){
                self.captureSession.addOutput(metadataOutput)
                
                metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417]
            }else{
                return
            }
            
            
            self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
            self.previewLayer.frame = self.view.layer.bounds
            self.previewLayer.videoGravity = .resizeAspectFill
            self.view.layer.addSublayer(self.previewLayer)
            print("Running")
            self.captureSession.startRunning()
        })
    }


}


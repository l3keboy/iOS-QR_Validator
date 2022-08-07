//
//  CameraViewModel.swift
//  QR Validator
//
//  Created by Luke Hendriks on 16/07/2022.
//

import Foundation
import AVFoundation
import SwiftUI

class CameraModel {
    
    var session: AVCaptureSession?
    var delegate: AVCaptureMetadataOutputObjectsDelegate?
    
    let output = AVCaptureMetadataOutput()
    let previewLayer = AVCaptureVideoPreviewLayer()

    func start(delegate: AVCaptureMetadataOutputObjectsDelegate, completion: @escaping (Error?) -> ()) {
        self.delegate = delegate
        checkCameraPermissions()
    }
    
    private func checkCameraPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                guard granted else {
                    return
                }
                DispatchQueue.main.async {
                    self.initCamera()
                }
            }
        case .restricted:
            break
        case .denied:
            break
        case .authorized:
            initCamera()
        @unknown default:
            break
        }
    }
    
    private func initCamera() {
        let session = AVCaptureSession()
        
        if let device = AVCaptureDevice.default(for: .video) {
            do {
                let input = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input) {
                    session.addInput(input)
                }
                
                if session.canAddOutput(self.output) {
                    session.addOutput(self.output)
                }
                
                output.setMetadataObjectsDelegate(delegate, queue: DispatchQueue.main)
                output.metadataObjectTypes = [.qr]

                previewLayer.videoGravity = .resizeAspectFill
                previewLayer.session = session
                
                startSession()
                
                self.session = session
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func qrCodeContentIsURL(_ source: String) -> Bool {
        if let url = URL(string: source) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
    
    func startSession() {
        DispatchQueue.global(qos: .background).async {
            self.session?.startRunning()
        }
    }
    
    func stopSession() {
        session?.stopRunning()
    }
}

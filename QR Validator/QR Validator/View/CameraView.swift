//
//  CameraView.swift
//  QR Validator
//
//  Created by Luke Hendriks on 16/07/2022.
//

import SwiftUI
import AVFoundation

struct CameraView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController
    
    let cameraModel: CameraModel
    let didOutputMetadata: (Result<AVMetadataMachineReadableCodeObject, Error>) -> ()
    
    func makeUIViewController(context: Context) -> UIViewController {
        cameraModel.start(delegate: context.coordinator) { error in
            if let error = error {
                didOutputMetadata(.failure(error))
                return
            }
        }
        let viewController = UIViewController()
        viewController.view.backgroundColor = .init(named: "PrimaryColor")
        viewController.view.layer.addSublayer(cameraModel.previewLayer)
        cameraModel.previewLayer.frame = viewController.view.frame
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self, didOutputMetadata: didOutputMetadata)
    }
    
    class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        let parent: CameraView
        private var didOutputMetadata: (Result<AVMetadataMachineReadableCodeObject, Error>) -> ()
        
        init(parent: CameraView, didOutputMetadata: @escaping (Result<AVMetadataMachineReadableCodeObject, Error>) -> Void) {
            self.parent = parent
            self.didOutputMetadata = didOutputMetadata
        }
  
        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            if let metadataObjects = metadataObjects.first {
                if let readableObjects = metadataObjects as? AVMetadataMachineReadableCodeObject {
                    didOutputMetadata(.success(readableObjects))
                } else {
                    didOutputMetadata(.failure("Error" as! Error))
                }
            }
        }
    }
}

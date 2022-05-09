//
//  PhotoView.swift
//  PhotoKit
//
//  Created by 김세영 on 2022/05/09.
//

import AVFoundation
import UIKit

open class PhotoView: UIView {
    
    // MARK: - Properties
    private var captureSession: AVCaptureSession!
    private var stillImageOutput: AVCapturePhotoOutput!
    private var previewLayer: AVCaptureVideoPreviewLayer!
    private var backCamera: AVCaptureDevice!
    
    public weak var delegate: PhotoViewDelegate?
    
    // MARK: - Public
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .quaternarySystemFill
        getBackCamera()
        configurePreviewView()
    }
    
    public func startPreview() {
        if let _ = captureSession {
            DispatchQueue.global().async {
                self.captureSession.startRunning()
            }
        }
    }
    
    public func stopPreview() {
        if let _ = captureSession {
            DispatchQueue.global().async {
                self.captureSession.stopRunning()
            }
        }
    }
    
    public func takePhoto() {
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        stillImageOutput.capturePhoto(with: settings, delegate: self)
    }
    
    // MARK: - Private
    private func getBackCamera() {
        guard let backCamera = AVCaptureDevice.default(for: .video) else {
            print("Fail to call back camera.")
            return
        }
        self.backCamera = backCamera
    }
    
    private func configurePreviewView() {
        guard let backCamera = backCamera else {
            print("Fail to assign back camera.")
            return
        }
        
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .medium
        
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            stillImageOutput = AVCapturePhotoOutput()
            
            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput)
                
                setUpLivePreview()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func setUpLivePreview() {
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.connection?.videoOrientation = .portrait
        self.layer.addSublayer(previewLayer)
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()
            DispatchQueue.main.async {
                self.previewLayer.frame = self.bounds
            }
        }
    }
}

extension PhotoView: AVCapturePhotoCaptureDelegate {
    public func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation() else { return }
        
        let uiImage = UIImage(data: imageData)
        delegate?.photoView(self, didTakePhoto: uiImage)
    }
}

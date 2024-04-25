//
//  QRcodeViewController.swift
//  Doc_sign_app
//
//  Created by Екатерина on 08.04.2024.
//

import UIKit
import AVFoundation

class QRcodeViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    let backButton = CustomWhiteBackButton()
    let massageLabel = UILabel()
    
    var captureSession = AVCaptureSession()
    var vedioPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        layoutViews()
        configure()
        
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            Logg.err(.error, "Failed to get the camera device")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            captureSession.addInput(input)
            
            let captureMetaDataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetaDataOutput)
            
            captureMetaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetaDataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
            vedioPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            vedioPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            vedioPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(vedioPreviewLayer!)
            
            DispatchQueue.global(qos: .userInitiated).async {
                self.captureSession.startRunning()
            }
            
            view.bringSubviewToFront(backButton)
            view.bringSubviewToFront(massageLabel)
            
            qrCodeFrameView = UIView()
            
            if let qrcodeFrameView = qrCodeFrameView {
                qrcodeFrameView.layer.borderColor = Resources.Colors.redColor.cgColor
                qrcodeFrameView.layer.borderWidth = 2
                view.addSubview(qrcodeFrameView)
                view.bringSubviewToFront(qrcodeFrameView)
            }
        } catch {
            print(error)
            return
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        captureSession.stopRunning()
    }
}

extension QRcodeViewController {
    
    func addViews() {
        view.addSubview(backButton)
        view.addSubview(massageLabel)
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            backButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            
            massageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            massageLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -160),
            massageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            massageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            massageLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 160)
        ])
    }
    
    func configure() {
        backButton.translatesAutoresizingMaskIntoConstraints = false
        massageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        massageLabel.text = "Наведите камеру на QR-код"
        massageLabel.textColor = Resources.Colors.white
        massageLabel.textAlignment = .center
        massageLabel.font = Resources.Fonts.helveticaRegular(with: 18)
        massageLabel.backgroundColor = Resources.Colors.secondaryLabelColor
        massageLabel.clipsToBounds = true
        massageLabel.layer.cornerRadius = 8
        massageLabel.alpha = 0.7
        massageLabel.numberOfLines = 0
        massageLabel.lineBreakMode = .byWordWrapping

    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            massageLabel.text = "Наведите камеру на QR-код"
            return
        }
        
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObject.ObjectType.qr {
            let barCodeObj = vedioPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObj!.bounds
            
            if metadataObj.stringValue != nil {
                massageLabel.text = metadataObj.stringValue
            }
        }
    }
    
    @objc private func didTapBack() {
        let vc = ContainerViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
}

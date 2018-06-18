

//  ViewController.swift
//  Demo
//
//  Created by Jeevan chandra on 01/05/18.
//  Copyright © 2018 Jeevan chandra. All rights reserved.
//

import UIKit
import AVFoundation
class CameraController : UIViewController {

    var swipe = 0
    var stackLeftConstraint: NSLayoutConstraint?


    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var capturePhotoOutput: AVCapturePhotoOutput?
    var qrCodeFrameView: UIView?
    var multipleImages = [UIImage]()



    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        startCameraSettings()
        // Do any additional setup after loading the view, typically from a nib.

        navigationController?.navigationBar.isTranslucent = false
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        let leftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(swipeGesture:)))
        leftGesture.direction = .left
        let rightGesture =  UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(swipeGesture:)))

        let downGesture =  UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(swipeGesture:)))
        downGesture.direction = .down
        view.addGestureRecognizer(leftGesture)
        view.addGestureRecognizer(rightGesture)
        view.addGestureRecognizer(downGesture)
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }


    func startCameraSettings(){

        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else {


            return


        }

        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous deivce object
            let input = try AVCaptureDeviceInput(device: captureDevice)

            // Initialize the captureSession object
            captureSession = AVCaptureSession()

            // Set the input devcie on the capture session
            captureSession?.addInput(input)

            // Get an instance of ACCapturePhotoOutput class
            capturePhotoOutput = AVCapturePhotoOutput()
            capturePhotoOutput?.isHighResolutionCaptureEnabled = true

            // Set the output on the capture session
            captureSession?.addOutput(capturePhotoOutput!)

            // Initialize a AVCaptureMetadataOutput object and set it as the input device
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)

            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]

            //Initialise the video preview layer and add it as a sublayer to the viewPreview view's layer
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            previewView.layer.addSublayer(videoPreviewLayer!)

            //start video capture
            captureSession?.startRunning()

            //  messageLabel.isHidden = true

            //Initialize QR Code Frame to highlight the QR code
            qrCodeFrameView = UIView()

            if let qrCodeFrameView = qrCodeFrameView {
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                view.addSubview(qrCodeFrameView)
                view.bringSubview(toFront: qrCodeFrameView)
            }
        } catch {
            //If any error occurs, simply print it out
            print(error)
            return
        }
    }

    @objc func handleSwipe(swipeGesture: UISwipeGestureRecognizer){


        print(swipeGesture.direction)
        switch swipeGesture.direction {
        case .left:

            if swipe < -1{

            }else{
                UIView.animate(withDuration: 0.4) {
                    self.stackLeftConstraint?.constant = (self.stackLeftConstraint?.constant)! - 16 - 140
                    self.view.layoutSubviews()
                }
                swipe = swipe - 1
            }
        case .right:
            if swipe == 0{

            }else{
                UIView.animate(withDuration: 0.4) {
                    self.stackLeftConstraint?.constant = (self.stackLeftConstraint?.constant)! + 16 + 140
                    self.view.layoutSubviews()
                }
                swipe = swipe + 1
            }
        default:
            dismiss(animated: true, completion: nil)
        }
    }


    func addViews(){

        view.addSubview(previewView)
        view.addSubview(singleCameraButton)
        view.addSubview(multipleCameraButton)
        view.addSubview(combineCameraButton)
        view.addSubview(cameraButton)
        view.addSubview(multipleImageView)
        view.addSubview(closeButton)

        stackLeftConstraint = singleCameraButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: UIScreen.main.bounds.width / 2 - 70 )
        stackLeftConstraint?.isActive = true


        singleCameraButton.bottomAnchor.constraint(equalTo: cameraButton.topAnchor, constant: -16).isActive = true
        singleCameraButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        singleCameraButton.widthAnchor.constraint(equalToConstant: 140).isActive = true

        multipleCameraButton.bottomAnchor.constraint(equalTo: cameraButton.topAnchor, constant: -16).isActive = true
        multipleCameraButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        multipleCameraButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        multipleCameraButton.leftAnchor.constraint(equalTo: singleCameraButton.rightAnchor, constant: 16).isActive = true

        combineCameraButton.bottomAnchor.constraint(equalTo: cameraButton.topAnchor, constant: -16).isActive = true
        combineCameraButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        combineCameraButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        combineCameraButton.leftAnchor.constraint(equalTo: multipleCameraButton.rightAnchor, constant: 16).isActive = true


        cameraButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.2).isActive = true
        cameraButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.2).isActive = true
        cameraButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16).isActive = true
        cameraButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        previewView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        previewView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        previewView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        previewView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true


        multipleImageView.anchorWithConstantsToTop(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, topConstant: 0, leftConstant: 16, bottomConstant: 16, rightConstant: 16)
        multipleImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        multipleImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true



        closeButton.anchorWithConstantsToTop(top: nil, left: multipleImageView.rightAnchor, bottom: multipleImageView.topAnchor, right: nil, topConstant: 0, leftConstant: -20, bottomConstant: -20, rightConstant: 4)

        closeButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 25).isActive = true




    }


    let singleCameraButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("SINGLE", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        btn.layer.shadowOffset = CGSize(width: 0, height: 5)
        btn.layer.shadowOpacity = 5.0
        btn.layer.shadowRadius = 10.0
        btn.layer.masksToBounds = false
        return btn
    }()

    let multipleCameraButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("MULTI", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        btn.layer.shadowOffset = CGSize(width: 0, height: 5)
        btn.layer.shadowOpacity = 5.0
        btn.layer.shadowRadius = 10.0
        btn.layer.masksToBounds = false
        return btn
    }()

    let combineCameraButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("COMBINE", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        btn.layer.shadowOffset = CGSize(width: 0, height: 3)
        btn.layer.shadowOpacity = 5.0
        btn.layer.shadowRadius = 10.0
        btn.layer.masksToBounds = false
        return btn
    }()

    lazy var cameraButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(#imageLiteral(resourceName: "cameraImage").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(handleCamera), for: .touchUpInside)
        return btn
    }()

    let previewView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return view
    }()



    lazy var multipleImageView: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 25
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(handleMultiButton), for: .touchUpInside)
        return btn
    }()


    lazy var closeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(#imageLiteral(resourceName: "closeImage"), for: .normal)
        btn.tintColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        btn.layer.cornerRadius = 25 / 2
        btn.clipsToBounds = true
        btn.isHidden = true
        // btn.addTarget(self, action: #selector(handleClick), for: .touchUpInside)
        return btn
    }()





}


extension CameraController{


    @objc func handleCamera(){
        guard let capturePhotoOutput = self.capturePhotoOutput else { return }

        // Get an instance of AVCapturePhotoSettings class
        let photoSettings = AVCapturePhotoSettings()

        // Set photo settings for our need
        photoSettings.isAutoStillImageStabilizationEnabled = true
        photoSettings.isHighResolutionPhotoEnabled = true
        photoSettings.flashMode = .auto

        // Call capturePhoto method by passing our photo settings and a delegate implementing AVCapturePhotoCaptureDelegate
        capturePhotoOutput.capturePhoto(with: photoSettings, delegate: self)

    }

    func multiCamera(){


    }

    @objc func handleMultiButton(){
        let multipleObj = MultiImageClickController()
        multipleObj.photoClicked = multipleImages
        navigationController?.pushViewController(multipleObj, animated: true)
    }

}







extension CameraController : AVCapturePhotoCaptureDelegate {
    func photoOutput(_ captureOutput: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?,
                     previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?,
                     resolvedSettings: AVCaptureResolvedPhotoSettings,
                     bracketSettings: AVCaptureBracketedStillImageSettings?,
                     error: Error?) {
        // Make sure we get some photo sample buffer
        guard error == nil,
            let photoSampleBuffer = photoSampleBuffer else {
                print("Error capturing photo: \(String(describing: error))")
                return
        }

        // Convert photo same buffer to a jpeg image data by using AVCapturePhotoOutput
        guard let imageData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer, previewPhotoSampleBuffer: previewPhotoSampleBuffer) else {
            return
        }

        // Initialise an UIImage with our image data
        let capturedImage = UIImage.init(data: imageData , scale: 1.0)
        if let image = capturedImage {
            // Save our captured image to photos album
            //   UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)

            // Jeevan Code


            if swipe == 0{

                let singleImageClickedObj = SingleImageClickController()
                singleImageClickedObj.photoClicked = image
                navigationController?.pushViewController(singleImageClickedObj, animated: true)

            }else if swipe == -1{

                multipleImageView.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
                multipleImages.append(image)

                if multipleImages.count > 0 {
                    closeButton.isHidden = false
                }else{
                    closeButton.isHidden = true
                }
            }



            //            if cameraType == CameraType.MULTIPLE  || cameraType == CameraType.COMBINE{
            //                multipleImages.append(image)
            //
            //            }else{
            //                let sampleView = PhotoView()
            //                sampleView.sampleImageView.image = image
            //                view.addSubview(sampleView)
            //                sampleView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            //                sampleView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            //                sampleView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            //                sampleView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            //            }




        }
    }
}

extension CameraController : AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ captureOutput: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        // Check if the metadataObjects array is contains at least one object.
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            // messageLabel.isHidden = true
            return
        }

        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject

        if metadataObj.type == AVMetadataObject.ObjectType.qr {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds

            if metadataObj.stringValue != nil {
                // messageLabel.isHidden = false
                // messageLabel.text = metadataObj.stringValue
            }
        }
    }
}

//extension CameraController {
//    var videoOrientation: AVCaptureVideoOrientation? {
//        switch self {
//        case .portraitUpsideDown: return .portraitUpsideDown
//        case .landscapeRight: return .landscapeRight
//        case .landscapeLeft: return .landscapeLeft
//        case .portrait: return .portrait
//        default: return nil
//        }
//    }
//}



class SingleImageClickController: UIViewController{

    var photoClicked: UIImage?{
        didSet{
            clickedImage.image = photoClicked
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        addViews()
    }

    func addViews(){
        view.addSubview(clickedImage)
        clickedImage.anchorToTop(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }

    let clickedImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()


}


class MultiImageClickController: UIViewController{

    var photoClicked: [UIImage]?{
        didSet{
            //clickedImage.image = photoClicked
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        addViews()
    }

    func addViews(){
        view.addSubview(multiImageCollectionView)
        multiImageCollectionView.anchorToTop(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }

    lazy var multiImageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.register(MultiImageCollectionCell.self, forCellWithReuseIdentifier: "MultiImageCollectionCell")
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isPagingEnabled = true
        cv.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return cv
    }()


}


extension MultiImageClickController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: view.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoClicked?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MultiImageCollectionCell", for: indexPath) as! MultiImageCollectionCell
        cell.clickedImage.image = photoClicked?[indexPath.item]
        return cell
    }
}

class MultiImageCollectionCell: UICollectionViewCell{




    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addViews()
    }

    func addViews(){
        addSubview(clickedImage)
        clickedImage.anchorWithConstantsToTop(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 16, leftConstant: 8, bottomConstant: 16, rightConstant: 8)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let clickedImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
}


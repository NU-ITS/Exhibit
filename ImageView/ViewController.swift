//
//  ViewController.swift
//  ImageView
//
//  Created by Quentin Harouff on 10/6/18.
//  Copyright © 2018 Quentin Harouff. All rights reserved.
//

// Import Frameworks
import UIKit
import Foundation
import Nuke


// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
// Start: Build Objects that will store JSON Data
// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

struct PlayerData: Decodable {
    var images: [ImageObject]
    
    init(images: [ImageObject]){
        self.images = images
    }
}
struct ImageObject: Decodable{
    let name: String
    let url: String
    let duration: String
    let startOn: String
    let endBy: String
    
    init(name: String, url: String, duration: String, startOn: String, endBy: String){
        self.name = name
        self.url = url
        self.duration = duration
        self.startOn = startOn
        self.endBy = endBy
    }
}

var playerData: PlayerData? = nil

// <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
// End: Build Objects that will store JSON Data
// <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
// Start: Initialize and set defaults
// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

var dataURL = "https://unl.box.com/shared/static/b53laudd6bjirftfff5u7c1vtzatnjys.csv"
var imageTimer: Double = 10
var disableAirplayBoxMovement: Bool = false
var airplayViewTimer: Double = 33
var dataCheckTimer: Double = 180
var defaultBackground: String = "DefaultBackground"

// <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
// End: Initialize and set defaults
// <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

class ViewController: UIViewController {
    
    var imageCurrent = 0
    var imageUrlArray: [String] = []
    let dateFormatter = DateFormatter()

    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var deviceNameLabel: UILabel!
    @IBOutlet weak var airplayView: UIView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        dateFormatter.dateFormat = "M/d/yy H:mm"
        loadInputRecognizer()
        loadGUIConfig()
        loadImageSelection()
        loadRepeatingFunctions()
        
    }

    
    // ----------------------------------------
    // function: getManagedAppConfiguration:
    //
    // This function looks for managed app configuration values
    // loaded to the Apple TV by an MDM. If no values exist, the
    // defaults will be used.
    //
    // ----------------------------------------
    
    func getManagedAppConfiguration() {
        
        // Update Device Name
        deviceNameLabel.text = UIDevice.current.name
        
        // Restore Defualts
        dataURL = "https://unl.box.com/shared/static/b53laudd6bjirftfff5u7c1vtzatnjys.csv"
        imageTimer = 10
        disableAirplayBoxMovement = false
        airplayViewTimer = 33
        dataCheckTimer = 180
        defaultBackground = "DefaultBackground"
        
        // Get Managed App Configuration passsed by MDM
        if keyPresentInUserDefaults(key: "edu.nebraska.ImageViewer.dataURL") {
            dataURL = ManagedAppConfig.shared.getConfigValue(forKey: "edu.nebraska.ImageViewer.dataURL") as! String
        }
        
        if keyPresentInUserDefaults(key: "edu.nebraska.ImageViewer.imageTimer") {
            imageTimer = ManagedAppConfig.shared.getConfigValue(forKey: "edu.nebraska.ImageViewer.imageTimer") as! Double
        }
        
        if keyPresentInUserDefaults(key: "edu.nebraska.ImageViewer.disableAirplayBoxMovement") {
            disableAirplayBoxMovement = ManagedAppConfig.shared.getConfigValue(forKey: "edu.nebraska.ImageViewer.disableAirplayBoxMovement") as! Bool
        }
        
        if keyPresentInUserDefaults(key: "edu.nebraska.ImageViewer.airplayViewTimer") {
            airplayViewTimer = ManagedAppConfig.shared.getConfigValue(forKey: "edu.nebraska.ImageViewer.airplayViewTimer") as! Double
        }
        
        if keyPresentInUserDefaults(key: "edu.nebraska.ImageViewer.dataCheckTimer") {
            dataCheckTimer = ManagedAppConfig.shared.getConfigValue(forKey: "edu.nebraska.ImageViewer.dataCheckTimer") as! Double
        }
        
        if keyPresentInUserDefaults(key: "edu.nebraska.ImageViewer.defaultBackground") {
            defaultBackground = ManagedAppConfig.shared.getConfigValue(forKey: "edu.nebraska.ImageViewer.defaultBackground") as! String
        }
        
        print(dataURL)
        print(imageTimer)
        print(disableAirplayBoxMovement)
        print(airplayViewTimer)
        print(dataCheckTimer)
        print(defaultBackground)
        
    }
    
    
    // ----------------------------------------
    // function: keyPresentInUserDefaults:
    //
    // Uses the provided string key value to check if a
    // configuration value was provided by MDM and returns
    // true or false.
    //
    // useage example: keyPresentInUserDefaults(key: "edu.nebraska.ImageViewer.dataURL")
    //
    // ----------------------------------------
    
    func keyPresentInUserDefaults(key: String) -> Bool {
        return ManagedAppConfig.shared.getConfigValue(forKey: key) != nil
    }
    
    
    // ----------------------------------------
    // function: loadInputRecognizer:
    //
    // Sets the remote control input functions.
    //
    // ----------------------------------------
    
    func loadInputRecognizer() {
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipedDown))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipedRight))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipedLeft))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
    }
    
    
    // ----------------------------------------
    // function: loadGUIConfig:
    //
    // Adjust aspects of the GUI configuration
    //
    // ----------------------------------------
    
    func loadGUIConfig() {
        
        deviceNameLabel.text = UIDevice.current.name
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.alpha = 0.85
        blurredEffectView.frame = airplayView.bounds
        
        airplayView.insertSubview(blurredEffectView, at: 0)
        airplayView.layer.cornerRadius = 15
        
        UIApplication.shared.isIdleTimerDisabled = true
        
    }
    
    
    // ----------------------------------------
    // function: loadImageSelection:
    //
    //
    //
    // ----------------------------------------
    
    @objc func loadImageSelection(){
        getManagedAppConfiguration()
        

        // Check loaded data URL file type and run appropriate function.
        if (dataURL != "") {
            let pathExtension = URL(string: dataURL)!.pathExtension
            
            if (pathExtension == "json") {
                FileImporter.shared.importJSON(jsonUrlString: dataURL)
            } else if (pathExtension == "csv"){
                FileImporter.shared.importCSV(csvUrlString: dataURL)
            }
        }
        
        
        var count = 0
        while playerData == nil {
            sleep(2)
            print("URL data is not yet loaded. Sleeping for 2 seconds")
            count += 1
            if (count == 6) {
                break
            }
        }

        if playerData != nil {
            imageUrlArray.removeAll()
            for index in playerData!.images {
                imageUrlArray.append(index.url)
            }


            preheatImages()
            imageHandler(imageIndex: imageCurrent)

            print("-----Image Selection Refreshed-----")

        } else {

            print("-----URL data not accessable, loading default image for now-----")

            imageView.image = UIImage(named: defaultBackground)

        }
    }
    
    
    func loadRepeatingFunctions() {
        
        if playerData != nil {
            setImageTimer(seconds: stringToSeconds(string: playerData?.images[imageCurrent].duration ?? String(imageTimer)))
        } else {
            setImageTimer(seconds: 10)
        }
        
        if disableAirplayBoxMovement != true {
        Timer.scheduledTimer(timeInterval: airplayViewTimer, target: self, selector: #selector(moveAirplayBox), userInfo: nil, repeats: true)
        }
        
        Timer.scheduledTimer(timeInterval: dataCheckTimer, target: self, selector: #selector(loadImageSelection), userInfo: nil, repeats: true)
        
    }
    
    
    func preheatImages() {
        
        for index in imageUrlArray {
            let imageURLString = index
            let url = URL(string: imageURLString)
            let request = ImageRequest(url: url!)
            
            
            ImagePipeline.shared.loadImage(
                with: request,
                progress: { _, completed, total in
//                    print("progress updated")
            },
                completion: { response, error in
//                    print("task completed")
            })

        }

    }
    
    func imageLoad(string: String){
        
        let url = URL(string: string)
        let request = ImageRequest(url: url!)
        
        Nuke.loadImage(
            with: request,
            options: ImageLoadingOptions(
                placeholder: UIImage(named: defaultBackground),
                transition: .fadeIn(duration: 1)
            ),
            into: imageView)
        
        imageView.contentMode = .scaleAspectFill
        
        let toImage = imageView.image

        UIView.transition(with: self.imageView,
                          duration: 1,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.imageView.image = toImage
        },
                          completion: nil)
        
    }
    
    func imageHandler(imageIndex: Int) {
        if playerData != nil {
            var loop = true
            var index = imageIndex
            
            while (loop == true){
                if index < 0 {
                    index = imageUrlArray.count - 1
                } else if index > imageUrlArray.count - 1 {
                    index = 0
                }
                
                if getStartOnDate(imageIndex: index) < Date() && Date() < getEndByDate(imageIndex: index) {
                    loop = false
                    let imageURL = imageUrlArray[index]
                    imageCurrent = index
                    imageLoad(string: imageURL)
                    print("image loaded")
                } else {
                    index = index + 1
                    print("image not loaded")
                    print(imageIndex)
                }
            }
        }
    }
    
    func getStartOnDate(imageIndex: Int) -> Date {
        return dateFormatter.date(from: playerData?.images[imageIndex].startOn ?? "1/1/18 0:00")!
    }
    func getEndByDate(imageIndex: Int) -> Date {
        return dateFormatter.date(from: playerData?.images[imageIndex].endBy ?? "1/1/99 23:59")!
    }
    
    func setImageTimer(seconds: Double) {
        Timer.scheduledTimer(timeInterval: seconds, target: self, selector: #selector(timedNextImage), userInfo: nil, repeats: false)
    }
    
    func stringToSeconds(string: String) -> Double {
        let components = string.components(separatedBy: ":")
        let hh = Double(components[0]) ?? 0
        let mm = Double(components[1]) ?? 0
        let ss = Double(components[2]) ?? 0
        
        let seconds = ((hh*3600) + (mm*60) + ss)
        
        return seconds
 
    }
    
    @objc func timedNextImage() {
        if (playerData != nil) {
            imageCurrent += 1
            imageHandler(imageIndex: imageCurrent)
            
            setImageTimer(seconds: stringToSeconds(string: playerData?.images[imageCurrent].duration ?? String(imageTimer)))

        } else {
            setImageTimer(seconds: 10)
        }
    }
    
    @objc func moveAirplayBox() {
        
        let parentViewWidth = Int(self.airplayView.superview!.frame.width)
        let parentViewHeight = Int(self.airplayView.superview!.frame.height)
        let viewWidth = Int(self.airplayView.frame.width)
        let viewHeight = Int(self.airplayView.frame.height)
        
        let xCoordinate = Int.random(in: 20 ..< (parentViewWidth - viewWidth - 20))
        let yCoordinate = Int.random(in: 20 ..< (parentViewHeight - viewHeight - 20))
        
        print("Moving AirPlay box to new coordinates: X:\(xCoordinate) Y:\(yCoordinate)")

        
        UIView.animate(withDuration: 5, delay: 1, animations: {
            
            self.airplayView.frame.origin.x = CGFloat(xCoordinate)
            self.airplayView.frame.origin.y = CGFloat(yCoordinate)
            
        }, completion: nil)
        
    }
    
    
    @objc func swipedDown(gestrure: UISwipeGestureRecognizer) {
        
        print("swiped down")
        
        if (topView.isHidden == true){
            topView.isHidden = false
        } else {
            topView.isHidden = true
        }
        
    }
    
    @objc func swipedRight(gestrure: UISwipeGestureRecognizer) {
        
        print("swiped right")
        imageCurrent += 1
        imageHandler(imageIndex: imageCurrent)
        
    }

    @objc func swipedLeft(gestrure: UISwipeGestureRecognizer) {
        
        print("swiped left")
        imageCurrent -= 1
        imageHandler(imageIndex: imageCurrent)
        
    }
    
}



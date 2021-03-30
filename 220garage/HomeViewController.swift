//
//  HomeViewController.swift
//  220GarageSpeed
//
//  Created by Doğuş  Kaynak on 19.03.2021.
//

import UIKit
//import MapKit
import CoreLocation

class HomeViewController: UIViewController , CLLocationManagerDelegate {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var openMap: UIButton!
    @IBOutlet weak var hudButton: UIButton!
    
    let locationManager = CLLocationManager()
    let locationDelegate = LocationDelegate()
    
//    let location1 = CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
//    let location2 = CLLocation(latitude: <#T##CLLocationDegrees#>, longitude: <#T##CLLocationDegrees#>)
//    let distance : CLLocationDistance = location1.distanceFromLocation(location2)
    
    var startLocation = true
    var hudView = true
    var speeds = [CLLocationSpeed]()
    var avgSpeed: CLLocationSpeed {
        return (speeds.reduce(0,+)/Double(speeds.count)) * 3.6
    }
    var topSpeed: CLLocationSpeed {
        return (speeds.max() ?? 0) * 3.6
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.isIdleTimerDisabled = true // screen always on
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        startButton.setImage(UIImage(named: "power")?.withRenderingMode(.alwaysOriginal), for: [])
        openMap.setImage(UIImage(named: "AppleMaps_logo")?.withRenderingMode(.alwaysOriginal), for: [])
        hudButton.setImage(UIImage(named: "flip")?.withRenderingMode(.alwaysOriginal), for: [])
    }
    
    @IBAction func openMap(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MySecondScreen") as! ViewController // MySecondSecreen the storyboard ID
        vc.startLocation = startLocation
        vc.modalPresentationStyle = .overFullScreen
        //self.present(vc, animated: true, completion: nil)
    } //Map button open map screen
    

    @IBAction func hudButton(_ sender: UIButton) {
        if hudView {
            hudView = false
            view.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        } else {
            hudView = true
            self.view.transform = CGAffineTransform.identity
        }
        
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        if startLocation {
            startLocation = false
            startButton.setImage(UIImage(named: "stop-button")?.withRenderingMode(.alwaysOriginal), for: [])
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        } else {
            startLocation = true
            startButton.setImage(UIImage(named: "power")?.withRenderingMode(.alwaysOriginal), for: [])
            statusLabel.text = "LETS RİDE!"
            locationManager.stopUpdatingLocation()
            statusLabel.font = statusLabel.font.withSize(54)
            
            let popOverVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopUpController") as! PopUpViewController
            popOverVc.averageSpeedValue = Int(avgSpeed)
            popOverVc.maxSpeedValue = Int(topSpeed)
            popOverVc.totalDistanceValue = Int()
            self.addChild(popOverVc)
            popOverVc.view.frame = self.view.frame
            self.view.addSubview(popOverVc.view)
            popOverVc.didMove(toParent: self)
            
            clearValues()
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
        let location = locations[0]
            
        print(location.speed)
            
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        statusLabel.font = statusLabel.font.withSize(120)
        
        speeds.append(contentsOf: locations.map{$0.speed})
        
        let mps = location.speed
        let km = mps * 3.6
        
        statusLabel.text = "\(Int(km.rounded()))"
        
    }
    
    func clearValues() {
        speeds = []
    }

}

//
//  HomeViewController.swift
//  220GarageSpeed
//
//  Created by Doğuş  Kaynak on 19.03.2021.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController , CLLocationManagerDelegate {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    
    let locationManager = CLLocationManager()
    let locationDelegate = LocationDelegate()
    var startLocation = true
    var hudView = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        startButton.setImage(UIImage(named: "power")?.withRenderingMode(.alwaysOriginal), for: [])
        
    }
    
    @IBAction func openMap(_ sender: UIButton) {
        self.dismiss(animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let vc = storyboard.instantiateViewController(withIdentifier: "MySecondScreen") ; // MySecondSecreen the storyboard ID
        self.present(vc, animated: true, completion: nil);
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
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
        let location = locations[0]
            
        print(location.speed)
            
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        statusLabel.font = statusLabel.font.withSize(120)
        
        let mps = location.speed
        let km = mps * 3.6
        
        statusLabel.text = "\(Int(km.rounded()))"
        
    }
    
}

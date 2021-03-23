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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        startButton.setTitleColor(UIColor.green, for: .normal)
        
    }
    
    @IBAction func openMap(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let vc = storyboard.instantiateViewController(withIdentifier: "MySecondScreen") ; // MySecondSecreen the storyboard ID
        self.present(vc, animated: true, completion: nil);
    } //Map button open map screen
    
    
    @IBAction func startButton(_ sender: UIButton) {
        if startLocation {
            startLocation = false
            startButton.setTitle("STOP", for: .normal)
            startButton.setTitleColor(UIColor.red, for: .normal)
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        } else {
            startLocation = true
            startButton.setTitle("START", for: .normal)
            startButton.setTitleColor(UIColor.green, for: .normal)
            statusLabel.text = "LETS RİDE!"
            locationManager.stopUpdatingLocation()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
        let location = locations[0]
            
        print(location.speed)
            
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
            
        statusLabel.text = "\(location.speed)"
    }
    
}

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
    }
    
    @IBAction func openMap(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let vc = storyboard.instantiateViewController(withIdentifier: "MySecondScreen") ; // MySecondSecreen the storyboard ID
        self.present(vc, animated: true, completion: nil);
    } //Map button open map screen
    
    
    @IBAction func startButton(_ sender: UIButton) {
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
        let location = locations[0]
            
        print(location.speed)
            
        locationManager.delegate = locationDelegate
        locationManager.startUpdatingLocation()
            
        statusLabel.text = "\(location.speed)"
    }
    
}

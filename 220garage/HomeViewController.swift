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
    
    
    @IBAction func openMap(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let vc = storyboard.instantiateViewController(withIdentifier: "MySecondScreen") ; // MySecondSecreen the storyboard ID
        self.present(vc, animated: true, completion: nil);
    } //Map button open map screen
    
    
    @IBAction func startButton(_ sender: UIButton) {
        
        let start = sender.currentTitle!
        
        switch start {
        case "Start":
            print(statusLabel.text!)
        default:
            print("ERROR!")
        }
    }
    
    let manager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
        let location = locations[0]
            
        let myLocation = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
            
        print(location.speed)
            
        let del = locationDelegate()
        let lm = CLLocationManager();
        lm.delegate = del
        lm.startUpdatingLocation()
            
        statusLabel.text = "\(location.speed)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }


}

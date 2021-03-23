//
//  ViewController.swift
//  220GarageSpeed
//
//  Created by Doğuş  Kaynak on 18.03.2021.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController , CLLocationManagerDelegate {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    let manager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0]
        
        let span = MKCoordinateSpan(latitudeDelta: 0.03 , longitudeDelta: 0.03)
        let myLocation = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        let region = MKCoordinateRegion(center: myLocation, span: span)
        
        mapView.setRegion(region, animated: true)
        
        self.mapView.showsUserLocation = true
        
        statusLabel.text = "\(location.speed)" //Optional
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }


}


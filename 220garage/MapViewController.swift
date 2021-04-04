//
//  ViewController.swift
//  220GarageSpeed
//
//  Created by Doğuş  Kaynak on 18.03.2021.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController , CLLocationManagerDelegate {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!

    
    let manager = CLLocationManager()
    var startLocation = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBarColor()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }
        
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0]
        
        let span = MKCoordinateSpan(latitudeDelta: 0.005 , longitudeDelta: 0.005)
        let myLocation = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        let region = MKCoordinateRegion(center: myLocation, span: span)
        
        mapView.setRegion(region, animated: true)
        
        self.mapView.showsUserLocation = true
        
        if !startLocation {
            let mps = location.speed
            let km = mps * 3.6
            statusLabel.text = "\(Int(km.rounded()))" //Optional
        }
        
    }
    
    func navigationBarColor() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
}

//
//  NilSpeed.swift
//  220GarageSpeed
//
//  Created by Doğuş  Kaynak on 19.03.2021.
//

import UIKit
import CoreLocation

class LocationDelegate: NSObject, CLLocationManagerDelegate {
    var last:CLLocation?
    override init() {
      super.init()
    }
    func processLocation(_ current:CLLocation) {
        guard last != nil else {
            last = current
            return
        }
        var speed = current.speed
        if (speed > 0) {
            print(speed) // or whatever
        } else {
            speed = last!.distance(from: current) / (current.timestamp.timeIntervalSince(last!.timestamp))
            print(speed)
        }
        last = current
    }
    func locationManager(_ manager: CLLocationManager,
                 didUpdateLocations locations: [CLLocation]) {
        for location in locations {
            processLocation(location)
        }
    }
}



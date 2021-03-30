//
//  PopUpViewController.swift
//  220garage
//
//  Created by Doğuş  Kaynak on 29.03.2021.
//

import UIKit

class PopUpViewController: UIViewController {

    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var maxSpeed: UILabel!
    @IBOutlet weak var averageSpeed: UILabel!
    @IBOutlet weak var totalDistance: UILabel!
    
    var maxSpeedValue = 0
    var averageSpeedValue = 0
    var totalDistanceValue = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        maxSpeed.text = "\(maxSpeedValue)"
        averageSpeed.text = "\(averageSpeedValue)"
        //totalDistance.text =
        
        popUpView.layer.cornerRadius = 16
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        moveIn()
    }
    
    @IBAction func closePopUp(_ sender: UIButton) {
        moveOut()
    }
    
    func moveIn() {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0

        UIView.animate(withDuration: 0.25) {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }

    func moveOut() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }) { _ in
            self.view.removeFromSuperview()
            }
    }
}

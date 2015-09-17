//
//  ViewController.swift
//  Where Am I?
//
//  Created by Rosario Tarabocchia on 9/17/15.
//  Copyright © 2015 RLDT. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var manager:CLLocationManager!

    
    @IBOutlet var latitudeLabel: UILabel!
    
    @IBOutlet var longitudeLabel: UILabel!
    
    @IBOutlet var courseLabel: UILabel!
    
    @IBOutlet var speedLabel: UILabel!
    
    @IBOutlet var altitudeLabel: UILabel!
    
    @IBOutlet var addressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
}
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        
        var userLocation:CLLocation = locations[0] as! CLLocation
        
        self.latitudeLabel.text = "\(userLocation.coordinate.latitude)"
        
        self.longitudeLabel.text = "\(userLocation.coordinate.longitude)"
        
        self.courseLabel.text = "\(userLocation.course)"
        
        self.speedLabel.text = "\(userLocation.speed)"
        
        self.altitudeLabel.text = "\(userLocation.altitude)"
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) -> Void in
            
            if (error != nil){
                print(error)
            }else{
                let p = CLPlacemark(placemark: placemarks![0] as CLPlacemark)
                
                var subThoroughfare:String = ""
                var thoroughfare:String = ""
                var subLocality:String = ""
                
                if (p.subThoroughfare != nil){
                    subThoroughfare = p.subThoroughfare!
                }
                
                if (p.thoroughfare != nil){
                    thoroughfare = p.thoroughfare!
                }
                
                if (p.subLocality != nil){
                    thoroughfare = p.subLocality!
                }
                
                
                self.addressLabel.text = "\(subThoroughfare) \(thoroughfare) \n \(subLocality) \n \(p.administrativeArea!) \n \(p.postalCode!) \n \(p.country!)"
                
                
            }
            
        }
        


}
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


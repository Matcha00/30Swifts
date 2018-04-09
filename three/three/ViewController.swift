//
//  ViewController.swift
//  three
//
//  Created by 陈欢 on 2017/11/18.
//  Copyright © 2017年 陈欢. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    
    let locationManager = CLLocationManager()
    
    let geocoder = CLGeocoder()
    
    let locationLable = UILabel()
    
    let locationStrLable = UILabel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bgImageView = UIImageView(frame: self.view.bounds)
        bgImageView.image = #imageLiteral(resourceName: "phoneBg")
        self.view.addSubview(bgImageView)
        
        let blurEffect: UIBlurEffect = UIBlurEffect(style: .light)
        let BlurView: UIVisualEffectView = UIVisualEffectView(effect: blurEffect)
        BlurView.frame = self.view.bounds
        self.view.addSubview(BlurView)
        
        
        locationManager.delegate = self
        
        locationLable.frame = CGRect(x: 0, y: 50, width: self.view.bounds.width, height: 100)
        
        locationLable.textAlignment = .center
        
        locationLable.textColor = UIColor.white
        
        self.view.addSubview(locationLable)
        
        locationStrLable.frame = CGRect(x: 0, y: 100, width: self.view.bounds.width, height: 50)
        locationStrLable.textAlignment = .center
        locationStrLable.textColor = UIColor.white
        self.view.addSubview(locationStrLable)
        
        
        let findMyLoc = UIButton(type: .custom)
        findMyLoc.frame = CGRect(x: 50, y: self.view.bounds.height - 80, width: self.view.bounds.width - 100, height: 50)
        findMyLoc.setTitle("Find My Location", for: UIControlState.normal)
        findMyLoc.setTitleColor(UIColor.white, for: UIControlState.normal)
        findMyLoc.addTarget(self, action: #selector(findMyLocation), for: UIControlEvents.touchUpInside)
        self.view.addSubview(findMyLoc)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func findMyLocation() {
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locations :NSArray = locations as NSArray
        let currentLocation = locations.lastObject as! CLLocation
        let locationStr = "lat: \(currentLocation.coordinate.latitude) lang:\(currentLocation.coordinate.longitude)"
        
        locationLable.text = locationStr
        
        //print(locationStr)
        
        reverseGeocode(loatioc: currentLocation)
        
        locationManager.stopUpdatingLocation()
        
        
        
    }
    
    func reverseGeocode(loatioc:CLLocation) {
        geocoder.reverseGeocodeLocation(loatioc) { (placeMark, error) in
            if (error == nil) {
                let tempArray = placeMark! as NSArray
                let mark = tempArray.firstObject as! CLPlacemark
                let addressDictionary = mark.addressDictionary! as NSDictionary
                let country = addressDictionary.object(forKey: "Country")
                let city = addressDictionary.object(forKey: "City")
                let street = addressDictionary.object(forKey: "Street")
                
                let finalAddress = "\(street),\(city),\(country)"
                //print(finalAddress)
                self.locationStrLable.text = finalAddress
            }
        }
    }


}


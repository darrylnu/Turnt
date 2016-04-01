//
//  MapViewController.swift
//  Turnt
//
//  Created by Darryl Nunn on 3/31/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet var map: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //gets access to users location
        locationManager.delegate = self
        if #available(iOS 8.0, *) {
            locationManager.requestWhenInUseAuthorization()
        } else {
            // Fallback on earlier versions
        }
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        let query = PFQuery(className: "Events")
        query.whereKeyExists("address")
        query.findObjectsInBackgroundWithBlock { (object, error) in
            if error != nil {
                print(error)
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                   
                
                if let event = object {
                    for events in event {
                        var geocoder = CLGeocoder()

                        
                        let address = events["address"] as! String
                        let date = events["date"] as! String
                        let time = events["time"] as! String
                        let name = events["name"] as! String
                        let music = events["music"] as! String
                        let ages = events["ages"] as! String
                        geocoder.geocodeAddressString(address) { (placemarks, error) in
                            if let placemark = placemarks![0] as? CLPlacemark {
                                var annotation = MKPointAnnotation()
                                annotation.title = "\(name) @ \(time) on \(date)"
                                annotation.subtitle = "Playing \(music) for \(ages) year olds"
                                annotation.coordinate = (placemark.location?.coordinate)!
                                self.map.addAnnotation(annotation)
                            }
                        }

                        
                    }
                    
                    
                }
            }
            }
        }
        

        // Do any additional setup after loading the view.
   
    }
    
    //called everytime a new location is registered by device
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        var userLocation:CLLocation = locations[0]
        
        var latitude: CLLocationDegrees = userLocation.coordinate.latitude
        var longitude: CLLocationDegrees = userLocation.coordinate.longitude
        var latDelta: CLLocationDegrees = 0.5
        var lonDelta: CLLocationDegrees = 0.5
        var span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        var region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        map.setRegion(region, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

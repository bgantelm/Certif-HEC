//
//  ViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit
import MapKit
import CoreLocation
import CoreGraphics

class MainViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    
    @IBOutlet weak var MyMAp: MKMapView!
    let locationManager = CLLocationManager()
    var ecoleLocation : CLLocationCoordinate2D?
    override func viewDidLoad() {
        super.viewDidLoad()
        
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            self.MyMAp.showsUserLocation = true

        
        
        
        
        let menuItemImage = UIImage(named: "bg-menuitem")!
        let menuItemHighlitedImage = UIImage(named: "bg-menuitem-highlighted")!
        
        let starImage = UIImage(named: "icon-star")!
        
        let starMenuItem1 = PathMenuItem(image: menuItemImage, highlightedImage: menuItemHighlitedImage, contentImage: starImage)
        
        let starMenuItem2 = PathMenuItem(image: menuItemImage, highlightedImage: menuItemHighlitedImage, contentImage: starImage)
        
        let starMenuItem3 = PathMenuItem(image: menuItemImage, highlightedImage: menuItemHighlitedImage, contentImage: starImage)
        
        let starMenuItem4 = PathMenuItem(image: menuItemImage, highlightedImage: menuItemHighlitedImage, contentImage: starImage)
        
        let starMenuItem5 = PathMenuItem(image: menuItemImage, highlightedImage: menuItemHighlitedImage, contentImage: starImage)
        
        let items = [starMenuItem1, starMenuItem2, starMenuItem3, starMenuItem4, starMenuItem5]
        
        let startItem = PathMenuItem(image: UIImage(named: "bg-addbutton")!,
                                     highlightedImage: UIImage(named: "bg-addbutton-highlighted"),
                                     contentImage: UIImage(named: "icon-plus"),
                                     highlightedContentImage: UIImage(named: "icon-plus-highlighted"))
        
        let menu = PathMenu(frame: view.bounds, startItem: startItem, items: items)
        menu.delegate = self
        menu.startPoint     = CGPointMake(UIScreen.mainScreen().bounds.width/2, view.frame.size.height - 30.0)
        menu.menuWholeAngle = CGFloat(M_PI) - CGFloat(M_PI/5)
        menu.rotateAngle    = -CGFloat(M_PI_2) + CGFloat(M_PI/5) * 1/2
        menu.timeOffset     = 0.0
        menu.farRadius      = 110.0
        menu.nearRadius     = 90.0
        menu.endRadius      = 100.0
        menu.animationDuration = 0.5
        
        view.addSubview(menu)
        view.backgroundColor = UIColor(red:0.96, green:0.94, blue:0.92, alpha:1)
    }


//        self.ecoleLocation = CLLocationCoordinate2DMake(48.896466, 2.318488)
//           let mapCamera = MKMapCamera(lookingAtCenterCoordinate: ecoleLocation!, fromEyeCoordinate: self.ecoleLocation!, eyeAltitude: 1000)
//            MyMAp.setCamera(mapCamera, animated: true)
    
    
    @IBAction func Local(sender: AnyObject) {
        let location = self.locationManager.location
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let mapCamera = MKMapCamera(lookingAtCenterCoordinate: center, fromEyeCoordinate: center, eyeAltitude: 1000)
        MyMAp.setCamera(mapCamera, animated: true)
        self.locationManager.stopUpdatingHeading()
        
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension MainViewController : SlideMenuControllerDelegate {
    
    func leftWillOpen() {
        print("SlideMenuControllerDelegate: leftWillOpen")
    }
    
    func leftDidOpen() {
        print("SlideMenuControllerDelegate: leftDidOpen")
    }
    
    func leftWillClose() {
        print("SlideMenuControllerDelegate: leftWillClose")
    }
    
    func leftDidClose() {
        print("SlideMenuControllerDelegate: leftDidClose")
    }
    
    func rightWillOpen() {
        print("SlideMenuControllerDelegate: rightWillOpen")
    }
    
    func rightDidOpen() {
        print("SlideMenuControllerDelegate: rightDidOpen")
    }
    
    func rightWillClose() {
        print("SlideMenuControllerDelegate: rightWillClose")
    }
    
    func rightDidClose() {
        print("SlideMenuControllerDelegate: rightDidClose")
    }
}

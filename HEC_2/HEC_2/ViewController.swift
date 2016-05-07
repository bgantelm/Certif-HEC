//
//  ViewController.swift
//  HEC_2
//
//  Created by Bruno GANTELMI on 5/7/16.
//  Copyright © 2016 Bruno GANTELMI. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import PathMenu

class ViewController: UIViewController, UITabBarDelegate, MKMapViewDelegate, CLLocationManagerDelegate
{

    @IBOutlet weak var Mymap: MKMapView!
    let locationManager = CLLocationManager()
    
        let items = ["Ray Wenderlich", "NSHipster", "iOS Developer Tips", "Jameson Quave", "Natasha The Robot", "Coding Explorer", "That Thing In Swift", "Andrew Bancroft", "iAchieved.it", "Airspeed Velocity", "Ray Wenderlich", "NSHipster", "iOS Developer Tips", "Jameson Quave", "Natasha The Robot", "Coding Explorer", "That Thing In Swift", "Andrew Bancroft", "iAchieved.it", "Airspeed Velocity"]
   // var ecoleLocation : CLLocationCoordinate2D?
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        self.Mymap.showsUserLocation = true
        
        let navigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.size.width, 60)) // Offset by 20 pixels vertically to take the status bar into account
        
        navigationBar.backgroundColor = UIColor.whiteColor()
//        navigationBar.delegate = self;
        
        // Create a navigation item with a title
        let navigationItem = UINavigationItem()
        navigationItem.title = ""
        
        // Create left and right button for navigation item
        let leftButton =  UIBarButtonItem(title: "Menu", style:   UIBarButtonItemStyle.Plain, target: self,  action: #selector(menuLeft))
        let rightButton = UIBarButtonItem(title: "Filters", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(menuRight))
        
        // Create two buttons for the navigation item
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
        
        // Assign the navigation item to the navigation bar
        navigationBar.items = [navigationItem]
        
        // Make the navigation bar a subview of the current view controller
        self.view.addSubview(navigationBar)

        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func Local(sender: AnyObject) {
        let location = self.locationManager.location
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let mapCamera = MKMapCamera(lookingAtCenterCoordinate: center, fromEyeCoordinate: center, eyeAltitude: 1000)
        Mymap.setCamera(mapCamera, animated: true)
        self.locationManager.stopUpdatingHeading()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func menuLeft()
    {
        performSegueWithIdentifier("menuLeftSegue", sender: nil)
    }
    
    func menuRight()
    {
        performSegueWithIdentifier("menuRightSegue", sender: nil)
    }


}

extension ViewController: PathMenuDelegate {
    func pathMenu(menu: PathMenu, didSelectIndex idx: Int) {
        print("Select the index : \(idx)")
    }
    
    func pathMenuWillAnimateOpen(menu: PathMenu) {
        print("Menu will open!")
    }
    
    func pathMenuWillAnimateClose(menu: PathMenu) {
        print("Menu will close!")
    }
    
    func pathMenuDidFinishAnimationOpen(menu: PathMenu) {
        print("Menu was open!")
    }
    
    func pathMenuDidFinishAnimationClose(menu: PathMenu) {
        print("Menu was closed!")
    }
}

extension ViewController: UITableViewDelegate {
}

extension ViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
}



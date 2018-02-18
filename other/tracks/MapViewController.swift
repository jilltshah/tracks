//
//  MapViewController.swift
//  tracks
//
//  Created by Jill Shah on 2/17/18.
//  Copyright © 2018 Jill Shah. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func loadView() {
        
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: 40.7305, longitude: -73.9091, zoom: 11.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 40.7553, longitude: -73.9869)
        marker.title = "TIMES SQUARE"
        marker.snippet = "station"
        marker.map = mapView
        
        let path = Bundle.main.path(forResource: "SubwayLines", ofType: "geojson")
        let url = URL(fileURLWithPath: path!)
        
        let geoJsonParser = GMUGeoJSONParser(url: url)
        geoJsonParser.parse()
        
        let renderer = GMUGeometryRenderer(map: mapView, geometries: geoJsonParser.features)
        
        
        //print (geoJsonParser.value())
        geoJsonParser.features.forEach { feature in
            print(feature.geometry.type)
        }
        
        renderer.render()
        
        let path2 = Bundle.main.path(forResource: "SubwayStations", ofType: "geojson")
        let url2 = URL(fileURLWithPath: path2!)
        let geoJsonParser2 = GMUGeoJSONParser(url: url2)
        geoJsonParser2.parse()
        
        let renderer2 = GMUGeometryRenderer(map: mapView, geometries: geoJsonParser2.features)
        
        renderer2.render()
        
        do {
            // Set the map style by passing the URL of the local file.
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        
        self.view = mapView
        
        
    }


}

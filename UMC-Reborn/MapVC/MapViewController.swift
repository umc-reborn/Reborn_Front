//
//  MapViewController.swift
//  UMC-Reborn
//
//  Created by nayeon  on 2023/02/07.
//

import UIKit

class MapViewController: UIViewController, MTMapViewDelegate {
    let mapView: MTMapView = {
        let mapView = MTMapView()
        mapView.setMapCenter(MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.548019859140304, longitude: 126.95334608482867)), animated: true)
        return mapView
    }()
    
    let po1: MTMapPOIItem = {
        let po1 = MTMapPOIItem()
        po1.markerType = .customImage
        po1.mapPoint = .init(geoCoord: .init(latitude: 37.544451322964775, longitude: 126.9518999026588))
        po1.showAnimationType = .noAnimation
        po1.tag = 1
        po1.customImageName = "etc.png"
        return po1
    }()
    
    let po2: MTMapPOIItem = {
        let po2 = MTMapPOIItem()
        po2.markerType = .customImage
        po2.mapPoint = .init(geoCoord: .init(latitude: 37.54569914875688, longitude: 126.95175765265803))
        po2.showAnimationType = .noAnimation
        po2.customImageName = "fashion.png"
        po2.tag = 2
        return po2
        
    }()
    
    let po3: MTMapPOIItem = {
        let po3 = MTMapPOIItem()
        po3.markerType = .customImage
        po3.customImageName = "sidedish.png"
        po3.mapPoint = .init(geoCoord: .init(latitude: 37.54494756938316, longitude: 126.95364220892691))
        po3.showAnimationType = .noAnimation
        po3.tag = 3
        return po3
        
    }()
    
    let po4: MTMapPOIItem = {
        let po4 = MTMapPOIItem()
        po4.markerType = .customImage
        po4.customImageName = "cafe.png"
        po4.mapPoint = .init(geoCoord: .init(latitude: 37.546429854087464, longitude: 126.95400340211167))
//        po4.showAnimationType = .noAnimation
        po4.tag = 4
        return po4
        
    }()
    
    let po5: MTMapPOIItem = {
        let po5 = MTMapPOIItem()
        po5.markerType = .customImage
        po5.customImageName = "cafe.png"
        po5.mapPoint = .init(geoCoord: .init(latitude: 37.546708387181816, longitude: 126.95205121862327))
        po5.showAnimationType = .noAnimation
        po5.tag = 5
        return po5
        
    }()

    override func viewDidLoad() {
            super.viewDidLoad()
            
            self.view.addSubview(mapView)
                    
            mapView.delegate = self
            mapView.baseMapType = .standard
            mapView.translatesAutoresizingMaskIntoConstraints = false
            
        NSLayoutConstraint.activate([
                mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                mapView.topAnchor.constraint(equalTo: self.view.topAnchor),
                mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
            
            mapView.addPOIItems([po1, po2, po3, po4, po5])
            mapView.fitAreaToShowAllPOIItems()
        }


    }

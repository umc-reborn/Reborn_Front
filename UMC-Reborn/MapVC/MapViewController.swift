//
//  MapViewController.swift
//  UMC-Reborn
//
//  Created by nayeon  on 2023/02/07.
//

import UIKit

class MapViewController: UIViewController, MTMapViewDelegate {

//    let mapView = MTMapView().then {
//            $0.setMapCenter(.init(geoCoord: .init(latitude: 37.537229, longitude: 127.005515)), animated: true)
//        }
    let mapView: MTMapView = {
        let mapView = MTMapView()
        mapView.setMapCenter(MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.548239525193, longitude: 126.95315808838)), zoomLevel: 1, animated: true)
        return mapView
    }()
    

//        let po1 = MTMapPOIItem().then{
//            $0.markerType = .redPin
//            $0.mapPoint = .init(geoCoord: .init(latitude: 37.517229, longitude: 127.005525))
//            $0.showAnimationType = .noAnimation
//            $0.tag = 1
//            $0.customImageName = "map_pin"
//        }
    let po1: MTMapPOIItem = {
        let po1 = MTMapPOIItem()
        po1.markerType = .customImage
        po1.mapPoint = .init(geoCoord: .init(latitude: 37.548239525193, longitude: 126.95315808838))
        po1.showAnimationType = .noAnimation
        po1.tag = 1
        po1.customImageName = "etc.png"
        return po1
    }()
    
    let po2: MTMapPOIItem = {
        let po2 = MTMapPOIItem()
        po2.markerType = .customImage
        po2.mapPoint = .init(geoCoord: .init(latitude: 37.548239525193, longitude: 126.9531580883803))
        po2.showAnimationType = .noAnimation
        po2.customImageName = "etc.png"
        po2.tag = 2
        return po2
        
    }()
    
    let po3: MTMapPOIItem = {
        let po3 = MTMapPOIItem()
        po3.markerType = .customImage
        po3.customImageName = "etc.png"
        po3.mapPoint = .init(geoCoord: .init(latitude: 37.54823952519302, longitude: 126.9531580883806))
        po3.showAnimationType = .noAnimation
        po3.tag = 3
        return po3
        
    }()
    
    let po4: MTMapPOIItem = {
        let po4 = MTMapPOIItem()
        po4.markerType = .customImage
        po4.customImageName = "etc.png"
        po4.mapPoint = .init(geoCoord: .init(latitude: 37.54823952519305, longitude: 126.95315808838))
//        po4.showAnimationType = .noAnimation
        po4.tag = 4
        return po4
        
    }()
    
    let po5: MTMapPOIItem = {
        let po5 = MTMapPOIItem()
        po5.markerType = .customImage
        po5.customImageName = "etc.png"
        po5.mapPoint = .init(geoCoord: .init(latitude: 37.54823952519301, longitude: 126.95315808838))
        po5.showAnimationType = .noAnimation
        po5.tag = 5
        return po5
        
    }()
    
    override func viewWillAppear(_ animated: Bool) {
//            super.viewDidLoad()
            
            view.addSubview(mapView)
                    
            mapView.delegate = self
            mapView.baseMapType = .standard
//            mapView.snp.makeConstraints { (make) in
//                make.top.equalToSuperview()
//                make.leading.equalToSuperview()
//                make.trailing.equalToSuperview()
//                make.bottom.equalToSuperview()
//            }
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

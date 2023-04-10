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
        po1.mapPoint = .init(geoCoord: .init(latitude: 37.54892084, longitude: 126.9521635))
        po1.showAnimationType = .noAnimation
        po1.tag = 1
        po1.customImageName = "life.png"
        return po1
    }()
    
    let po2: MTMapPOIItem = {
        let po2 = MTMapPOIItem()
        po2.markerType = .customImage
        po2.mapPoint = .init(geoCoord: .init(latitude: 37.54483468, longitude: 126.954126))
        po2.showAnimationType = .noAnimation
        po2.customImageName = "life.png"
        po2.tag = 2
        return po2
        
    }()
    
    let po3: MTMapPOIItem = {
        let po3 = MTMapPOIItem()
        po3.markerType = .customImage
        po3.customImageName = "sidedish.png"
        po3.mapPoint = .init(geoCoord: .init(latitude: 37.54700413, longitude: 126.9537173))
        po3.showAnimationType = .noAnimation
        po3.tag = 3
        return po3
        
    }()
    
    let po4: MTMapPOIItem = {
        let po4 = MTMapPOIItem()
        po4.markerType = .customImage
        po4.customImageName = "cafe.png"
        po4.mapPoint = .init(geoCoord: .init(latitude: 37.54367359, longitude: 126.9525969))
//        po4.showAnimationType = .noAnimation
        po4.tag = 4
        return po4
        
    }()
    
    let po5: MTMapPOIItem = {
        let po5 = MTMapPOIItem()
        po5.markerType = .customImage
        po5.customImageName = "etc.png"
        po5.mapPoint = .init(geoCoord: .init(latitude: 37.54878789, longitude: 126.953173))
        po5.showAnimationType = .noAnimation
        po5.tag = 5
        return po5
        
    }()
    
    let po6: MTMapPOIItem = {
        let po6 = MTMapPOIItem()
        po6.markerType = .customImage
        po6.customImageName = "life.png"
        po6.mapPoint = .init(geoCoord: .init(latitude: 37.54388518, longitude: 126.950062))
        po6.showAnimationType = .noAnimation
        po6.tag = 6
        return po6
    }()
    
    let po7: MTMapPOIItem = {
        let po7 = MTMapPOIItem()
        po7.markerType = .customImage
        po7.customImageName = "cafe.png"
        po7.mapPoint = .init(geoCoord: .init(latitude: 37.54539269, longitude: 126.9525867))
        po7.showAnimationType = .noAnimation
        po7.tag = 7
        return po7
    }()
    
    let po8: MTMapPOIItem = {
        let po8 = MTMapPOIItem()
        po8.markerType = .customImage
        po8.customImageName = "fashion.png"
        po8.mapPoint = .init(geoCoord: .init(latitude: 37.54622865, longitude: 126.9521653))
        po8.showAnimationType = .noAnimation
        po8.tag = 8
        return po8
    }()
    
    let po9: MTMapPOIItem = {
        let po9 = MTMapPOIItem()
        po9.markerType = .customImage
        po9.customImageName = "cafe.png"
        po9.mapPoint = .init(geoCoord: .init(latitude: 37.54705758, longitude: 126.9521874))
        po9.showAnimationType = .noAnimation
        po9.tag = 9
        return po9
    }()
    
    let po10: MTMapPOIItem = {
        let po10 = MTMapPOIItem()
        po10.markerType = .customImage
        po10.customImageName = "life.png"
        po10.mapPoint = .init(geoCoord: .init(latitude: 37.54552858, longitude: 126.9500066))
        po10.showAnimationType = .noAnimation
        po10.tag = 10
        return po10
    }()
    
    let po11: MTMapPOIItem = {
        let po11 = MTMapPOIItem()
        po11.markerType = .customImage
        po11.customImageName = "cafe.png"
        po11.mapPoint = .init(geoCoord: .init(latitude: 37.54835559, longitude: 126.953635))
        po11.showAnimationType = .noAnimation
        po11.tag = 11
        return po11
    }()
    
    let po12: MTMapPOIItem = {
        let po12 = MTMapPOIItem()
        po12.markerType = .customImage
        po12.customImageName = "fashion.png"
        po12.mapPoint = .init(geoCoord: .init(latitude: 37.5463088, longitude: 126.9543288))
        po12.showAnimationType = .noAnimation
        po12.tag = 12
        return po12
    }()
    
    let po13: MTMapPOIItem = {
        let po13 = MTMapPOIItem()
        po13.markerType = .customImage
        po13.customImageName = "sidedish.png"
        po13.mapPoint = .init(geoCoord: .init(latitude: 37.54650527, longitude: 126.9500286))
        po13.showAnimationType = .noAnimation
        po13.tag = 13
        return po13
    }()
    
    let po14: MTMapPOIItem = {
        let po14 = MTMapPOIItem()
        po14.markerType = .customImage
        po14.customImageName = "life.png"
        po14.mapPoint = .init(geoCoord: .init(latitude: 37.54295801, longitude: 126.9478675))
        po14.showAnimationType = .noAnimation
        po14.tag = 14
        return po14
    }()
    
    let po15: MTMapPOIItem = {
        let po15 = MTMapPOIItem()
        po15.markerType = .customImage
        po15.customImageName = "cafe.png"
        po15.mapPoint = .init(geoCoord: .init(latitude: 37.54654738, longitude: 126.9562298))
        po15.showAnimationType = .noAnimation
        po15.tag = 15
        return po15
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
            
            mapView.addPOIItems([po1, po2, po3, po4, po5, po6, po7, po8, po9, po10, po11, po12, po13, po14, po15])
            mapView.fitAreaToShowAllPOIItems()
        }


    }

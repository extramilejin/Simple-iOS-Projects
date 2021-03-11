//
//  EVStationDetailViewController.swift
//  EVMap
//
//  Created by 진형진 on 2021/03/11.
//

import UIKit
class EVStationDetailViewController: UIViewController, MTMapViewDelegate {
    
    var param: EVStation?
    var mapView: MTMapView?
    var EVMapPoint: MTMapPoint?
    var poiEVStaion: MTMapPOIItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = param?.statNm!
        // 지도 불러오기
        mapView = MTMapView(frame: self.view.bounds)
        
        if let mapView = mapView {
            mapView.delegate = self
            mapView.baseMapType = .standard
            mapView.showCurrentLocationMarker = true
            
            var sample = MTMapCircle()
            
            let curLat = param!.lat!
            let curLng = param!.lng!
            sample.circleCenterPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: curLat, longitude: curLng))
            sample.circleLineColor = .blue
            sample.circleFillColor = .clear
            sample.circleRadius = 50
            // 지도 중심점 설정
            mapView.setMapCenter(MTMapPoint(geoCoord: MTMapPointGeo(latitude: curLat, longitude: curLng)),zoomLevel: 2, animated: true)
            poiEVStaion = MTMapPOIItem()
            EVMapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: curLat, longitude: curLng))
            poiEVStaion?.mapPoint = EVMapPoint
            poiEVStaion?.itemName = param?.statNm!
            poiEVStaion?.markerType = .bluePin
            poiEVStaion?.showAnimationType = .dropFromHeaven
            poiEVStaion?.markerSelectedType = .redPin
            mapView.addCircle(sample)
            mapView.add(poiEVStaion!)
//            mapView.fitAreaToShowAllPOIItems()
//            mapView.select(poiEVStaion!, animated: false)
            self.view.addSubview(mapView)
        }
    }

}



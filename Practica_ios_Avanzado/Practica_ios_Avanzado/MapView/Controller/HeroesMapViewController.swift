//
//  HeroesMapViewController.swift
//  Practica_ios_Avanzado
//
//  Created by Enrique Poyato Ortiz on 14/2/23.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

class HeroesMapViewController: UIViewController{
    
    private var heroesMapViewModel = HeroesMapViewModel()

    var location: [Hero] = []
    var mainView: HeroesMapView {self.view as! HeroesMapView}
    var locationManager =  CLLocationManager()
    var annotations = [MKAnnotation]() // []

    
    override func loadView() {
        view = HeroesMapView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
        
        mainView.mapView.delegate = self
        mainView.mapView.showsUserLocation = true
        mainView.mapView.mapType = .standard
        
        getData()
        
        
    }
    
    

    
    private func getData() {

        
        self.location = getHeroesCoreData()
        self.createAnotation(location)
    }

    
    func createAnotation(_ location: [Hero]){
        mainView.mapView.register(AnnotationView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)

        let annotations = location.map { Annotation(place: $0) }
        mainView.mapView.showAnnotations(annotations, animated: true)
    }
    
}

extension HeroesMapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let id = MKMapViewDefaultAnnotationViewReuseIdentifier
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: id)
        
        
        if let annotation = annotation as? Annotation {
            

            
            
            annotationView?.canShowCallout = true
            annotationView?.detailCalloutAccessoryView = Callout(annotation: annotation)
            
            return annotationView
        }
        return nil
    }
   
    
}


// MARK: Extensions
extension HeroesMapViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        if #available(iOS 14.0, *) {
            switch manager.authorizationStatus {
            case .notDetermined:
                debugPrint("Not determined")
            case .restricted:
                debugPrint("restricted")
            case .denied:
                debugPrint("denied")
            case .authorizedAlways:
                debugPrint("authorized always")
            case .authorizedWhenInUse:
                debugPrint("authorized when in use")
            @unknown default:
                debugPrint("Unknow status")
            }
        }
        
    }
    
    // iOS 13 y anteriores
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch manager.authorizationStatus {
        case .notDetermined:
            debugPrint("Not determined")
        case .restricted:
            debugPrint("restricted")
        case .denied:
            debugPrint("denied")
        case .authorizedAlways:
            debugPrint("authorized always")
        case .authorizedWhenInUse:
            debugPrint("authorized when in use")
        @unknown default:
            debugPrint("Unknow status")
        }
        
    }
}


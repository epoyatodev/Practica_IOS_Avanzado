//
//  AnnotationView.swift
//  Practica_ios_Avanzado
//
//  Created by Enrique Poyato Ortiz on 14/2/23.
//
import MapKit

class AnnotationView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let value = newValue as? Annotation else { return }
            detailCalloutAccessoryView = Callout(annotation: value)
            
        }
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
    }
}

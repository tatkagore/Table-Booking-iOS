//
//  MapKitView.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 13/05/2024.
//

import MapKit
import Foundation

extension HomeViewController {
    
    func centerMapOnLocation(address: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { [weak self] (placemarks, error) in
            if let placemarks = placemarks, let location = placemarks.first?.location {
                let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters:  48.85545967340648, longitudinalMeters: 2.3052770889790137)
                self?.mapView.setRegion(region, animated: true)

                // Add a pin to the map
                let annotation = MKPointAnnotation()
                annotation.coordinate = location.coordinate
                annotation.title = "Restaurant Location"
                self?.mapView.addAnnotation(annotation)
            }
        }
    }

    @objc func toggleMapSize() {
        if isMapFullScreen {
            minimizeMap()
        } else {
            expandMap()
        }
        isMapFullScreen.toggle()
    }

    func expandMap() {
        UIView.animate(withDuration: 0.3) {
            // Remove any existing constraints on mapView
            self.mapView.translatesAutoresizingMaskIntoConstraints = true
            self.mapView.frame = self.view.bounds
            self.view.bringSubviewToFront(self.mapView)
        }
    }

    func minimizeMap() {
        UIView.animate(withDuration: 0.3) {
            // Re-enable auto layout
            self.mapView.translatesAutoresizingMaskIntoConstraints = false

            // Reapply the original constraints
            NSLayoutConstraint.activate([
                self.mapView.topAnchor.constraint(equalTo: self.restaurantCardView.bottomAnchor, constant: 20),
                self.mapView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
                self.mapView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
                self.mapView.heightAnchor.constraint(equalTo: self.restaurantCardView.heightAnchor)
            ])
            self.view.layoutIfNeeded()
        }
    }
}

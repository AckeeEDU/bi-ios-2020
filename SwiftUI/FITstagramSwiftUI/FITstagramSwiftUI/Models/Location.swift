//
//  Location.swift
//  FITstagramSwiftUI
//
//  Created by Jan Kaltoun on 12.12.2020.
//

import MapKit

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}


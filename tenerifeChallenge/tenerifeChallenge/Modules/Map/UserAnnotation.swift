//
//  UserAnnotation.swift
//  tenerifeChallenge
//
//  Created by Markel Juaristi on 14/10/24.
//


import Foundation
import CoreLocation

struct UserAnnotation: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D?
}

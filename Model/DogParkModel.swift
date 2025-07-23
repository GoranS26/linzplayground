//
//  DogParkModel.swift
//  DogPlaygrounds
//
//  Created by Goran Saric on 25.05.25.
//

import Foundation
import CoreLocation

// Helper struct to decode JSON
struct DogParkData: Decodable {
    let name: String
    let address: String
    let description: String
    let latitude: Double
    let longitude: Double
}

// Dog Park Model
struct DogPark: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let address: String
    var description: String
    let coordinate: CLLocationCoordinate2D
    
    static func == (lhs: DogPark, rhs: DogPark) -> Bool {
        return lhs.id == rhs.id
    }
}



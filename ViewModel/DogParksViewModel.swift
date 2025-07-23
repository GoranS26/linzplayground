//
//  DogParksViewModel.swift
//  DogPlaygrounds
//
//  Created by Goran Saric on 03.06.25.
//

import Foundation
import CoreLocation

// ViewModel to load JSON and convert

class DogParksViewModel: ObservableObject {
    
    @Published var dogParks: [DogPark] = []
    
    
    init() {
        loadDogParks()
    }
    
    func loadDogParks() {
        if let url = Bundle.main.url(forResource: "dog_zones_upper_austria", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let parksData = try decoder.decode([DogParkData].self, from: data)
                DispatchQueue.main.async {
                    self.dogParks = parksData.map {
                        DogPark(name: $0.name,
                                address: $0.address, description: $0.description,
                                coordinate: CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude))
                    }
                }
            } catch {
                print("JSON decode error: \(error)")
            }
        } else {
            print("JSON file not found")
        }
    }
}

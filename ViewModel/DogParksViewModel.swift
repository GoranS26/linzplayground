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
                    self.dogParks = parksData.map { data in
                        DogPark(
                            id: data.id,   // <- use the hardcoded/stable UUID string from JSON
                            name: data.name,
                            address: data.address,
                            description: data.description,
                            coordinate: CLLocationCoordinate2D(latitude: data.latitude, longitude: data.longitude)
                        )
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

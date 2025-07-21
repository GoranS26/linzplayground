//
//  DogParkDetailSheet.swift
//  DogPlaygrounds
//
//  Created by Goran Saric on 03.06.25.
//

import SwiftUI
import CoreLocation

struct DogParkDetailSheet: View {
    let park: DogPark

    var body: some View {
        VStack(spacing: 16) {
            Text(park.name)
                .font(.title)
                .bold()

            Text(park.address)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text(park.description)
                .font(.title3)
                .foregroundStyle(.black)
                .fontDesign(.rounded)
            
            .padding(.top)

            Spacer()
        }
        .padding()
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    DogParkDetailSheet(park: DogPark(name: "Hundezone Donaulände", address: "Untere Donaulände, 4020 Linz", description: "A spacious riverside dog park offering scenic views of the Danube and plenty of room for active dogs to run and socialize.", coordinate: CLLocationCoordinate2D(latitude: 48.3118, longitude: 14.2875)))
}



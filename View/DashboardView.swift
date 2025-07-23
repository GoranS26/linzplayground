//
//  DashboardView.swift
//  DogPlaygrounds
//
//  Created by Goran Saric on 25.05.25.
//

import SwiftUI
import MapKit
import CoreLocation

struct DashboardView: View {
    
    @StateObject private var viewModel = DogParksViewModel()
    
    @State private var selectedPark: DogPark?
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 48.30694, longitude: 14.28583), // Linz center
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    @State var searchText: String = ""
    
    @FocusState var isFocused: Bool
    
    // Filter dog parks based on search text
    var filteredParks: [DogPark] {
        if searchText.isEmpty {
            return viewModel.dogParks
        } else {
            return viewModel.dogParks.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.address.localizedCaseInsensitiveContains(searchText) ||
                $0.description.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [Color.indigo, Color.purple], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                // Custom positioned background circles
                ZStack {
                    Image(systemName: "dog.fill")
                        .resizable()
                        .scaledToFill()
                        .foregroundStyle(Color.white.opacity(0.08))
                        .frame(width: 100, height: 100)
                        .offset(x: -150, y: -250)
                        .blur(radius: 1)
                    
                    Image(systemName: "dog.fill")
                        .resizable()
                        .scaledToFill()
                        .foregroundStyle(Color.white.opacity(0.08))
                        .frame(width: 100, height: 100)
                        .offset(x: 20, y: -200)
                        .blur(radius: 1)

                    Image(systemName: "dog.fill")
                        .resizable()
                        .scaledToFill()
                        .foregroundStyle(Color.white.opacity(0.08))
                        .frame(width: 100, height: 100)
                        .offset(x: -160, y: 100)

                    Image(systemName: "dog.fill")
                        .resizable()
                        .scaledToFill()
                        .foregroundStyle(Color.white.opacity(0.08))
                        .frame(width: 100, height: 100)
                        .offset(x: 130, y: 370)

                    Image(systemName: "dog.fill")
                        .resizable()
                        .scaledToFill()
                        .foregroundStyle(Color.white.opacity(0.08))
                        .frame(width: 100, height: 100)
                        .offset(x: 140, y: 60)

                    Image(systemName: "dog.fill")
                        .resizable()
                        .scaledToFill()
                        .foregroundStyle(Color.white.opacity(0.08))
                        .frame(width: 100, height: 100)
                        .offset(x: 100, y: -350)

                    Image(systemName: "dog.fill")
                        .resizable()
                        .scaledToFill()
                        .foregroundStyle(Color.white.opacity(0.08))
                        .frame(width: 100, height: 100)
                        .offset(x: -90, y: 300)

                    Image(systemName: "dog.fill")
                        .resizable()
                        .scaledToFill()
                        .foregroundStyle(Color.white.opacity(0.08))
                        .frame(width: 100, height: 100)
                        .offset(x: 100, y: -100)
                }
                .ignoresSafeArea()
                
                VStack(spacing: 16) {
                    HStack {
                        TextField("", text: $searchText, prompt:
                                    Text("Search for zones...")
                            .foregroundStyle(.white.opacity(0.4))
                            .fontDesign(.rounded)
                            .fontWeight(.bold)
                                  
                        )
                        .autocapitalization(.none)
                        .bold()
                        .foregroundStyle(.white)
                        .textContentType(.emailAddress)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .clipShape(Capsule())
                        .padding(.horizontal)
                        .overlay(Capsule().stroke(Color.white, lineWidth: 2))
                    }
                    .padding(.horizontal)
                    
            
                    // Map with pins
                    Map(coordinateRegion: $region, annotationItems: filteredParks) { park in
                        MapAnnotation(coordinate: park.coordinate) {
                            VStack(spacing: 2) {
                                Image(systemName: "pawprint.fill")
                                    .foregroundColor(park == selectedPark ? .indigo : Color.indigo.opacity(0.4))
                                    .font(.title2)
                                
                                // Show name only if selected
                                if park == selectedPark {
                                    Text(park.name)
                                        .font(.caption2)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                        .padding(4)
                                        .background(Color.black.opacity(0.6))
                                        .cornerRadius(6)
                                        .fixedSize()
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 420)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
                    .padding(.horizontal)
                    
                    // List of dog parks
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(filteredParks) { park in
                                Button(action: {
                                    withAnimation {
                                        selectedPark = park
                                        region = MKCoordinateRegion(
                                            center: park.coordinate,
                                            span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
                                        )
                                    }
                                }) {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(park.name)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        Text(park.address)
                                            .font(.subheadline)
                                            .foregroundColor(.white)
                                        Text(park.description)
                                                .font(.caption)
                                                .foregroundColor(.white.opacity(0.6))
                                                .lineLimit(2)
                                                .multilineTextAlignment(.leading)
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color.white.opacity(0.1))
                                    .shadow(color: Color.black.opacity(0.15), radius: 4, x: 0, y: 2)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .padding(.horizontal)
                                }
                            }
                        }
                        .padding(.bottom)
                    }
                    .scrollIndicators(.hidden)
                }
                
            }
            .sheet(item: $selectedPark) { park in
                            DogParkDetailSheet(park: park)
                        }
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarTitleDisplayMode(.inline)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    DashboardView()
}

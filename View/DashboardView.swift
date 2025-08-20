//
//  DashboardView.swift
//  DogPlaygrounds
//
//  Created by Goran Saric on 25.05.25.
//

import SwiftUI
import MapKit

struct DashboardView: View {
    
    @StateObject private var viewModel = DogParksViewModel()
    
    @State private var selectedPark: DogPark?
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 48.30694, longitude: 14.28583),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    @State private var bounce = false
    @State private var sheetHeight: CGFloat = 0
    @State private var showButton = true
    @State private var searchText: String = ""
    @State private var filterSheetPresented: Bool = false
    @State private var detailPark: DogPark? = nil
    @State private var showDetailSheet = false

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
                Map(coordinateRegion: $region, annotationItems: filteredParks) { park in
                    MapAnnotation(coordinate: park.coordinate) {
                        VStack(spacing: 4) {
                            if selectedPark == park {
                               
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(park.name)
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                    
                                    Button(action: {
                                        withAnimation(.spring()) {
                                            detailPark = park
//                                            showDetailSheet = true
                                        }
                                    }) {
                                        Text("More…")
                                            .font(.caption2)
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 4)
                                            .background(Color.white.opacity(0.2))
                                            .cornerRadius(8)
                                    }
                                }
                                .padding(8)
                                .background(Color.indigo)
                                .cornerRadius(12)
                                .shadow(radius: 4)
                                .transition(.move(edge: .bottom).combined(with: .opacity))
                                .animation(.spring(response: 0.4, dampingFraction: 0.8), value: selectedPark)
                            }
                            
                            // Paw icon
                            Image(systemName: "pawprint.fill")
                                .foregroundColor(selectedPark == park ? .indigo : Color.indigo.opacity(0.4))
                                .font(.title2)
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                        selectedPark = park
                                    }
                                }
                        }
                    }
                }
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                        sheetHeight = 0
                        showButton = true
                        selectedPark = nil
                    }
                }
                
                VStack(spacing: 12) {
                    HStack(spacing: 12) {
                        TextField("Search for zones...", text: $searchText)
                            .padding(12)
                            .background(Color.white.opacity(0.8))
                            .foregroundStyle(.black)
                            .cornerRadius(16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.white.opacity(0.4), lineWidth: 1)
                            )
                        
                        Button(action: {
                            filterSheetPresented = true
                        }) {
                            Image(systemName: "line.horizontal.3.decrease.circle")
                                .font(.title2)
                                .foregroundStyle(.indigo)
                                .padding(8)
                                .background(Color.white.opacity(0.8))
                                .clipShape(Circle())
                        }
                        .sheet(isPresented: $filterSheetPresented) {
                            FilterSheetPlaceholder()
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)

                    Spacer()
                }

                // Bottom Sheet with list of parks
                BottomSheetView(height: 0...UIScreen.main.bounds.height * 0.5, currentHeight: $sheetHeight) {
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(filteredParks) { park in
                                Button {
                                    withAnimation {
                                        selectedPark = park
                                        region.center = CLLocationCoordinate2D(
                                            latitude: park.coordinate.latitude + 0.0050,
                                            longitude: park.coordinate.longitude
                                        )
                                        sheetHeight = 0
                                        showButton = true
                                    }
                                } label: {
                                    ParkListView(park: park)
                                }
                            }
                        }
                        .padding(.vertical)
                    }
                }

                if showButton {
                    Button(action: {
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                            sheetHeight = UIScreen.main.bounds.height / 2
                            showButton = false
                        }
                    }) {
                        Image(systemName: "chevron.compact.up")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white.opacity(0.8))
                            .frame(width: 56, height: 56)
                            .background(Color.indigo.opacity(0.85))
                            .clipShape(Circle())
                            .shadow(radius: 8)
                            .offset(y: bounce ? -6 : 0)  // Bounce offset
                            .animation(
                                Animation.easeInOut(duration: 1.4)
                                    .repeatForever(autoreverses: true),
                                value: bounce
                            )
                    }
                    .padding(.bottom, 150)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .animation(.easeInOut, value: showButton)
                    .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 40)
                    .onAppear {
                        bounce = true
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .sheet(item: $detailPark) { park in
                DogParkDetailSheet(park: park)
            }

        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    DashboardView()
}

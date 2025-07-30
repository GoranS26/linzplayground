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
                        Image(systemName: "pawprint.fill")
                            .foregroundColor(park == selectedPark ? .indigo : Color.indigo.opacity(0.4))
                            .font(.title2)
                    }
                }
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                        sheetHeight = 0
                        showButton = true
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
                BottomSheetView(height: 0...UIScreen.main.bounds.height / 2, currentHeight: $sheetHeight) {
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(filteredParks) { park in
                                Button {
                                    withAnimation {
                                        selectedPark = park
                                        region.center = park.coordinate
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
            .sheet(item: $selectedPark) { park in
                DogParkDetailSheet(park: park)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationBarBackButtonHidden(true)
    }
}




#Preview {
    DashboardView()
}

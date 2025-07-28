//
//  ParkListView.swift
//  DogPlaygrounds
//
//  Created by Goran Saric on 28.07.25.
//

import SwiftUI

struct ParkListView: View {
    
    @State var park: DogPark
    
    var body: some View {
        
        ZStack{
            VStack(alignment: .leading, spacing: 4) {
                Text(park.name)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(park.address)
                    .font(.subheadline)
                    .foregroundColor(.white)
                Text(park.description)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
            }
            .shadow(color: .black, radius: 10)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            .background(Color.white.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 1))
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.white.opacity(0.6), lineWidth: 2)
            )
            .padding(.horizontal)
        }
        
        
    }
}



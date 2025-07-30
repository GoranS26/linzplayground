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
                    .foregroundColor(.black)
                Text(park.address)
                    .font(.subheadline)
                    .foregroundColor(.black)
                Text(park.description)
                        .font(.caption)
                        .foregroundColor(.black.opacity(0.7))
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            .background(Color.white.opacity(0.4))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.white.opacity(0.2), lineWidth: 2)
            )
            .padding(.horizontal)
        }
        
        
    }
}



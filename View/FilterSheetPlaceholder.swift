//
//  FilterSheetPlaceholder.swift
//  DogPlaygrounds
//
//  Created by Goran Saric on 30.07.25.
//

import SwiftUI

struct FilterSheetPlaceholder: View {
    
    let filterPoints = [
        "Surface type",
        "Fenced / Unfenced",
        "Water access",
        "Shaded areas",
        "Size of the park"
    ]
    
    var body: some View {
        
        VStack( spacing: 16) {
            Text("Filter Options")
                .font(.title2.bold())
                .padding(.top)

            Text("Coming soon:")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
            
            VStack(spacing: 8) {
                ForEach(filterPoints, id: \.self) { point in
                    HStack(alignment: .top, spacing: 8) {
                        Text("•")
                            .font(.system(size: 18, weight: .bold))
                        Text(point)
                            .font(.body)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 20)

            Spacer()
        }
        .presentationDetents([.medium])
    }
}

#Preview {
    FilterSheetPlaceholder()
}


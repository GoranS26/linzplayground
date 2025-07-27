//
//  DogLogoView.swift
//  DogPlaygrounds
//
//  Created by Goran Saric on 27.07.25.
//

import SwiftUI

struct DogLogoView: View {
    
     let imageName: String = "dog.fill"
     let backgroundColor: Color = Color.white.opacity(0.1)
     let width: CGFloat = 100
     let height: CGFloat = 100
     let offsetX: CGFloat
     let offsetY: CGFloat

    
    var body: some View {
        
        Image(systemName: imageName)
            .resizable()
            .scaledToFill()
            .foregroundStyle(backgroundColor)
            .frame(width: width, height: height)
            .offset(x: offsetX, y: offsetY)
            .blur(radius: 1)
    }
}

#Preview {
    DogLogoView(offsetX: -150, offsetY: 200)
}


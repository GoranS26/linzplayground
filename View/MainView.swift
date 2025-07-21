//
//  ContentView.swift
//  DogPlaygrounds
//
//  Created by Goran Saric on 24.05.25.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.blue.ignoresSafeArea()
                
                // Custom positioned background circles
                ZStack {
                    // Top-left big circle
                    Circle()
                        .fill(Color.indigo.opacity(0.4))
                        .frame(width: 300, height: 300)
                        .offset(x: -150, y: -250)

                    // Mid-left small circle
                    Circle()
                        .fill(Color.indigo.opacity(0.5))
                        .frame(width: 80, height: 80)
                        .offset(x: -160, y: 100)
                    
                    // Mid-right big circle
                    Circle()
                        .fill(Color.indigo.opacity(0.4))
                        .frame(width: 250, height: 250)
                        .offset(x: 130, y: 370)
                    
                    // Top-right small cluster
                    Circle()
                        .fill(Color.indigo.opacity(0.3))
                        .frame(width: 60, height: 60)
                        .offset(x: 140, y: 60)
                    
                    Circle()
                        .fill(Color.indigo.opacity(0.35))
                        .frame(width: 150, height: 150)
                        .offset(x: 100, y: -350)
                    
                    // Center scatter
                    Circle()
                        .fill(Color.indigo.opacity(0.25))
                        .frame(width: 200, height: 200)
                        .offset(x: -170, y: 270)
                    
                    Circle()
                        .fill(Color.indigo.opacity(0.3))
                        .frame(width: 30, height: 30)
                        .offset(x: 190, y: -50)
                }
                .ignoresSafeArea()
                
                // Main content
                VStack {
                    Text("OFF LEASH")
                        .font(.system(size: 38, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.top, 50)
                        .fontDesign(.monospaced)
                        .multilineTextAlignment(.center)
                    Text("LINZ")
                        .font(.system(size: 38, weight: .bold))
                        .foregroundStyle(.white)
                        
                        .fontDesign(.monospaced)
                        .multilineTextAlignment(.center)
                    Spacer()

                    Image("doglocation")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .foregroundStyle(.white)
                        .clipShape(Circle())

                    Spacer()

                    Text("Find off leash dog playgrounds in your area")
                        .font(.system(size: 30, weight: .semibold, design: .monospaced))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)

                    NavigationLink(destination: DashboardView()) {
                        Text("GET STARTED")
                            .font(.system(size: 20, weight: .bold, design: .monospaced))
                            .frame(width: 200, height: 35)
                            .foregroundStyle(.indigo)
                            .background(Color.white.gradient)
                            .clipShape(Capsule())
                            .padding(.top, 100)
                    }

                    Spacer()
                }
            }
        }
    }
}

#Preview {
    MainView()
}



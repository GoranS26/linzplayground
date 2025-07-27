//
//  TabBarView.swift
//  DogPlaygrounds
//
//  Created by Goran Saric on 23.07.25.
//

import SwiftUI

struct TabBarView: View {
    
    init() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithTransparentBackground()
        tabBarAppearance.backgroundColor = .clear
        tabBarAppearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)

        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        UITabBar.appearance().isTranslucent = true
    }

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.indigo, Color.purple],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            TabView {
                DashboardView()
                    .tabItem {
                        VStack(spacing: 10){
                            Image(systemName: "pawprint.fill")
                                
                            Text("Parks")
                        }
                    }
                FavoriteParkView()
                    .tabItem {
                        Label("Favorites", systemImage: "heart.fill")
                    }

                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gearshape.fill")
                    }
            }
        }
        .tint(Color.indigo)
    }
}


#Preview {
    TabBarView()
}

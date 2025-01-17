//
//  CustomTabBar.swift
//  tenerifeChallenge
//
//  Created by Markel Juaristi on 14/10/24.
//


import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: AppState.AppView

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    selectedTab = .challengeList
                }) {
                    VStack {
                        Image(systemName: "list.bullet")
                        Text("Desafíos")
                    }
                }
                .frame(maxWidth: .infinity)

                Button(action: {
                    selectedTab = .mapContainer
                }) {
                    VStack {
                        Image(systemName: "map")
                        Text("Mapa")
                    }
                }
                .frame(maxWidth: .infinity)

                Button(action: {
                    selectedTab = .settings
                }) {
                    VStack {
                        Image(systemName: "gearshape")
                        Text("Ajustes")
                    }
                }
                .frame(maxWidth: .infinity)

                Button(action: {
                    selectedTab = .bic
                }) {
                    VStack {
                        Image(systemName: "calendar")
                        Text("BIC")
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .frame(height: 80)
            .padding(.horizontal, 16)
            .background(Color.mateGold.opacity(0.8))
            
            .shadow(radius: 5)
            .edgesIgnoringSafeArea(.bottom)

        }
        
    }
}

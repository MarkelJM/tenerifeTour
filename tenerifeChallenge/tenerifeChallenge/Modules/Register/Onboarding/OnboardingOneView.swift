//
//  OnboardingOneView.swift
//  tenerifeChallenge
//
//  Created by Markel Juaristi on 14/10/24.
//

import SwiftUI

struct OnboardingOneView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            Fondo()

            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Button(action: {
                                appState.currentView = .login
                            }) {
                                Image(systemName: "chevron.left")
                                    .font(.headline)
                                    .padding()
                                    .background(Color.mateGold)
                                    .foregroundColor(.black)
                                    .cornerRadius(10)
                                    .padding(.top, 50)
                            }
                            Spacer()
                        }
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Bienvenido a nuestra historia")
                                .font(.title)
                                .foregroundColor(.mateGold)
                                .padding(.top, 40)
                            
                            Text("""
                                Hola, soy Gallotia, una especie en peligro de extinción. Mi familia es originaria de esta isla, pero hace mucho que no les veo. ¿Me ayudarías a reencontrarme con mi familia?

                                """)
                                .font(.body)
                                .foregroundColor(.mateWhite)
                        }
                        .padding()
                    }
                }
                
                Spacer()
                
                Button(action: {
                    appState.currentView = .onboardingTwo
                }) {
                    Text("Continuar")
                        .padding()
                        .background(Color.mateBlueMedium)
                        .foregroundColor(.mateWhite)
                        .cornerRadius(10)
                        .padding(.bottom, 40)
                }
                Spacer()
            }
            .padding()
            .background(Color.black.opacity(0.6)) // Fondo con opacidad
            .cornerRadius(20)
            .padding()
        }
    }
}

//
//  OnboardingTwoView.swift
//  tenerifeChallenge
//
//  Created by Markel Juaristi on 14/10/24.
//

import SwiftUI

struct OnboardingTwoView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            // Fondo de pantalla
            Fondo()

            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Button(action: {
                                appState.currentView = .onboardingOne
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
                        
                        Text("Continuación de la historia")
                            .font(.title)
                            .foregroundColor(.mateGold)
                            .padding(.top, 40)
                        
                        Text("""
                            Escoge uno de los retos, y realiza las tareas propuestas. ¡Una vez superadas todas las tareas encontraremos a mi familia!
                            """)
                            .font(.body)
                            .foregroundColor(.mateWhite)
                    }
                    .padding()
                }
                
                Spacer()
                
                Button(action: {
                    appState.currentView = .registerEmail
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
            .background(Color.black.opacity(0.6))
            .cornerRadius(20)
            .padding()
        }
    }
}

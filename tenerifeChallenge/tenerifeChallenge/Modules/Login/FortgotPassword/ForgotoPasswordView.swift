//
//  ForgotoPasswordView.swift
//  tenerifeChallenge
//
//  Created by Markel Juaristi on 14/10/24.
//


import SwiftUI

struct ForgotPasswordView: View {
    @State private var email: String = ""
    @ObservedObject var viewModel: ForgotPasswordViewModel
    @EnvironmentObject var appState: AppState

    var body: some View {
        ZStack {
            // Fondo con gradiente suave
            Fondo()
            
            VStack(spacing: 20) {
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
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 5)
                
                Text("Restablecer Contraseña")
                    .font(.largeTitle)
                    .foregroundColor(.mateGold)
                    .padding(.top, 40)

                TextField("Introduce tu Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(Color.mateWhite.opacity(0.8))
                    .cornerRadius(10)

                // Botón para enviar enlace de restablecimiento usando los colores de la extensión
                Button(action: {
                    viewModel.resetPassword(email: email)
                }) {
                    Text("Enviar Enlace de Restablecimiento")
                        .foregroundColor(.mateWhite)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.mateWhite)
                        .cornerRadius(10)
                }
                .padding(.horizontal)

                if viewModel.showError {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else if viewModel.showSuccessMessage {
                    Text("Se ha enviado un enlace de restablecimiento a tu correo electrónico.")
                        .foregroundColor(.green)
                        .padding()
                }
            }
            .padding()
            .background(Color.black.opacity(0.7))
            .cornerRadius(20)
            .padding()
        }
    }
}

#Preview {
    ForgotPasswordView(viewModel: ForgotPasswordViewModel())
        .environmentObject(AppState())
}


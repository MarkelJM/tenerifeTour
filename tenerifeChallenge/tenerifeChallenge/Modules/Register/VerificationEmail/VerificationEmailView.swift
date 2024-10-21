//
//  VerificationEmailView.swift
//  tenerifeChallenge
//
//  Created by Markel Juaristi on 14/10/24.
//

import SwiftUI

struct VerificationEmailView: View {
    @ObservedObject var viewModel: RegisterViewModel

    var body: some View {
        ZStack {
            Fondo()

            VStack(spacing: 20) {
                Text("¿Has verificado tu correo electrónico?")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.mateGold)
                    .padding(.top, 50)

                // Botón para verificar correo
                Button(action: {
                    viewModel.checkEmailVerification()
                }) {
                    Text("OK")
                        .foregroundColor(.mateWhite)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.mateGold)
                        .cornerRadius(10)
                }
                .padding(.bottom, 50)

                if viewModel.showError {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .background(Color.black.opacity(0.5))
            .cornerRadius(20)
            .padding()
        }
        .alert(isPresented: $viewModel.showError) {
            Alert(title: Text("Error"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    VerificationEmailView(viewModel: RegisterViewModel())
}


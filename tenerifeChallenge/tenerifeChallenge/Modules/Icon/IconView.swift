//
//  IconView.swift
//  tenerifeChallenge
//
//  Created by Markel Juaristi on 14/10/24.
//


import SwiftUI

struct IconView: View {
    @State private var showEsloganEUS = false
    @State private var showEsloganES = false
    @EnvironmentObject var appState: AppState
    let soundManager = SoundManager.shared
    @State private var progress: CGFloat = 0.0


    var body: some View {
        ZStack {
            Fondo()
                .edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()

                VStack {
                    Text("Bienvenido a Tenerife Challenge")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.mateGold)
                        .padding(.top, 20)
                    
                    Text("¡Logra todos tus retos!")
                        .font(.title2)
                        .foregroundColor(.mateGold)
                        .padding(.bottom, 20)
                }
                .padding(30)
                .background(Color.black.opacity(0.5))
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.mateGold, lineWidth: 2)
                )
                .padding(.horizontal, 40)

                Image("iconLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: .black.opacity(0.7), radius: 10, x: 0, y: 10)
                    .padding()

                Spacer()

                ProgressView(value: progress)
                    .progressViewStyle(LinearProgressViewStyle(tint: .mateGold))
                    .frame(width: 200)
                    .padding(.bottom, 40)
            }
        }
        .onAppear {
            startProgress()
            soundManager.playInitialSound()
        }
    }

    private func startProgress() {
        withAnimation(.easeInOut(duration: 2.0)) {
            progress = 1.0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if let _ = KeychainManager.shared.read(key: "userUID") {
                appState.currentView = .challengeList
            } else {
                appState.currentView = .login
            }
        }
    }
}

struct IconView_Previews: PreviewProvider {
    static var previews: some View {
        IconView()
            .environmentObject(AppState())
    }
}

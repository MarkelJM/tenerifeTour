//
//  ChallengeSelectionView.swift
//  tenerifeChallenge
//
//  Created by Markel Juaristi on 14/10/24.
//

import SwiftUI

struct ChallengeSelectionView: View {
    @ObservedObject var viewModel: Map2DViewModel

    var body: some View {
        VStack {
            Text("Selecciona un reto")
                .font(.title)
                .padding()

            List(viewModel.challenges, id: \.id) { challenge in
                HStack {
                    Text(challenge.challengeTitle)
                        .font(.headline)
                        .padding()
                        .foregroundColor(.mateWhite)
                    
                    Spacer()
                }
                .background(Color.mateBlueMedium) 
                .cornerRadius(10)
                .padding(.vertical, 5)
                .onTapGesture {
                    viewModel.selectChallenge(challenge)
                }
            }
        }
        .padding()
        .background(Color.black.opacity(0.8))
        .cornerRadius(20)
        .padding()
    }
}

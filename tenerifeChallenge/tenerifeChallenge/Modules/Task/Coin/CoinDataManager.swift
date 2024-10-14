//
//  CoinDataManager.swift
//  tenerifeChallenge
//
//  Created by Markel Juaristi on 14/10/24.
//


import Combine
import FirebaseFirestore


class CoinDataManager {
    private let firestoreManager = CoinFirestoreManager()
    
    func fetchCoinById(_ id: String) -> AnyPublisher<Coin, Error> {
        return firestoreManager.fetchCoinById(id)
    }
    

}

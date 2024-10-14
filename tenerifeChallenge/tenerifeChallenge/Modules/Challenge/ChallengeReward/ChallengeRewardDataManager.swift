//
//  ChallengeRewardDataManager.swift
//  tenerifeChallenge
//
//  Created by Markel Juaristi on 14/10/24.
//


import Combine
import FirebaseFirestore

class ChallengeRewardDataManager {
    private let firestoreManager = ChallengeRewardFirestoreManager()
    
    func fetchChallengeRewardById(_ id: String) -> AnyPublisher<ChallengeReward, Error> {
        return firestoreManager.fetchChallengeRewardById(id)
    }
}

//
//  ChallengeListDataManager.swift
//  tenerifeChallenge
//
//  Created by Markel Juaristi on 14/10/24.
//


import Combine

class ChallengeListDataManager {
    private let firestoreManager = ChallengeListFirestoreManager()

    func fetchChallenges() -> AnyPublisher<[Challenge], Error> {
        return firestoreManager.fetchChallenges()
    }
}

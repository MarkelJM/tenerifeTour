//
//  profileDataManager.swift
//  tenerifeChallenge
//
//  Created by Markel Juaristi on 14/10/24.
//


import Foundation
import Combine

class ProfileDataManager {
    private let firestoreManager = FirestoreManager()
    
    func createUserProfile(user: User) -> AnyPublisher<Void, Error> {
        firestoreManager.createUserProfile(user: user)
    }
    
    func fetchUserProfile() -> AnyPublisher<User, Error> {
        firestoreManager.fetchUserProfile()
    }
}
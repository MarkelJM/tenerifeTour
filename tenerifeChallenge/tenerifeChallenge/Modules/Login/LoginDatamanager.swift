//
//  LoginDatamanager.swift
//  tenerifeChallenge
//
//  Created by Markel Juaristi on 14/10/24.
//

import Foundation
import Combine

class LoginDataManager {
    private let firestoreManager = FirestoreManager()
    
    func loginUser(email: String, password: String) -> AnyPublisher<Void, Error> {
        firestoreManager.loginUser(email: email, password: password)
    }
    
    
    func fetchUserProfile() -> AnyPublisher<User, Error> {
        firestoreManager.fetchUserProfile()
    }

    func createUserProfile(user: User) -> AnyPublisher<Void, Error> {
        firestoreManager.createUserProfile(user: user)
    }

}

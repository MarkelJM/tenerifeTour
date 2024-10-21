//
//  DatesOrderDataManager.swift
//  tenerifeChallenge
//
//  Created by Markel Juaristi on 14/10/24.
//


import Foundation
import Combine

class DatesOrderDataManager {
    private let firestoreManager = DatesOrderFirestoreManager()
    
    func fetchDateEventById(_ id: String) -> AnyPublisher<DateEvent, Error> {
        return firestoreManager.fetchDateEventById(id)
    }
}

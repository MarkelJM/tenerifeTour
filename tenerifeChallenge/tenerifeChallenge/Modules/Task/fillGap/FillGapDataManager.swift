//
//  FillGapDataManager.swift
//  tenerifeChallenge
//
//  Created by Markel Juaristi on 16/10/24.
//


import Foundation
import Combine

class FillGapDataManager {
    private let firestoreManager = FillGapFirestoreManager()
    
    func fetchFillGapById(_ id: String) -> AnyPublisher<FillGap, Error> {
        return firestoreManager.fetchFillGapById(id)
    }
}

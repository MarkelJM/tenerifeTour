//
//  BICFirestoreManager.swift
//  tenerifeChallenge
//
//  Created by Markel Juaristi on 14/10/24.
//


import FirebaseFirestore
import Combine

class BICFirestoreManager {
    private let db = Firestore.firestore()
    
    func fetchBICs() -> AnyPublisher<[BIC], Error> {
        Future { promise in
            self.db.collection("agenda").getDocuments { snapshot, error in
                if let error = error {
                    promise(.failure(error))
                } else if let documents = snapshot?.documents {
                    let bics = documents.compactMap { doc -> BIC? in
                        let data = doc.data()
                        return BIC(from: data)
                    }
                    promise(.success(bics))
                }
            }
        }.eraseToAnyPublisher()
    }
}

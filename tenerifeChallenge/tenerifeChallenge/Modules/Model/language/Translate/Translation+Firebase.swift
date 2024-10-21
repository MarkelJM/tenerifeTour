//
//  Translation+Firebase.swift
//  tenerifeChallenge
//
//  Created by Markel Juaristi on 14/10/24.
//


import Foundation
import FirebaseFirestore

extension Translation {
    init?(from firestoreData: [String: Any]) {
        guard let text = firestoreData["text"] as? String else {
            return nil
        }
        self.text = text
        self.url = firestoreData["url"] as? String
    }
}

//
//  QuestionAnswerDatamanager.swift
//  tenerifeChallenge
//
//  Created by Markel Juaristi on 14/10/24.
//


import Foundation
import Combine

class QuestionAnswerDataManager {
    private let firestoreManager = QuestionAnswerFirestoreManager()
    
    func fetchQuestionAnswerById(_ id: String) -> AnyPublisher<QuestionAnswer, Error> {
        return firestoreManager.fetchQuestionAnswerById(id)
    }
}

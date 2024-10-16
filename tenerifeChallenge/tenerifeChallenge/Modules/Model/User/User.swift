//
//  User.swift
//  tenerifeChallenge
//
//  Created by Markel Juaristi on 14/10/24.
//


import Foundation

enum Avatar: String, Codable, CaseIterable, Identifiable {
    case boy = "lizard1"
    case girl = "lizard2"

    var id: String { self.rawValue }
}

enum Province: String, Codable, CaseIterable, Identifiable {
    case guipuzcoa = "Guipúzcoa"
    case vizcaya = "Vizcaya"
    case alava = "Álava"
    case other = "Other"
    
    var id: String { self.rawValue }
}

struct User: Identifiable, Codable {
    var id: String
    var email: String
    var firstName: String
    var lastName: String
    var birthDate: Date
    var postalCode: String
    var city: String
    var province: Province
    var avatar: Avatar
    var spotIDs: [String]
    var specialRewards: [String: String]
    var challenges: [String: [String]]
}



//
//  BIC.swift
//  tenerifeChallenge
//
//  Created by Markel Juaristi on 14/10/24.
//

import Foundation

struct BIC: Identifiable, Codable {
    var id: String
    var bicNombre: String
    var bicCategoria: String
    var municipioNombre: String
    var bicDescripcion: String
    var boletin1URL: String
    var latitude: Double
    var longitude: Double
}

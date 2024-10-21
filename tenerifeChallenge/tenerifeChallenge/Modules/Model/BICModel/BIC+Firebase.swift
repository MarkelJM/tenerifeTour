//
//  BIC+Firebase.swift
//  tenerifeChallenge
//
//  Created by Markel Juaristi on 14/10/24.
//

import FirebaseFirestore

extension BIC {
    init?(from firestoreData: [String: Any]) {
        guard let bicNombre = firestoreData["bicNombre"] as? String,
              let bicCategoria = firestoreData["bicCategoria"] as? String,
              let municipioNombre = firestoreData["municipioNombre"] as? String,
              let bicDescripcion = firestoreData["bicDescripcion"] as? String,
              let boletin1URL = firestoreData["boletin1URL"] as? String,
              let latitude = firestoreData["latitude"] as? Double,
              let longitude = firestoreData["longitude"] as? Double else {
            return nil
        }

        self.id = firestoreData["id"] as? String ?? UUID().uuidString
        self.bicNombre = bicNombre
        self.bicCategoria = bicCategoria
        self.municipioNombre = municipioNombre
        self.bicDescripcion = bicDescripcion
        self.boletin1URL = boletin1URL
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func toFirestoreData() -> [String: Any] {
        return [
            "bicNombre": bicNombre,
            "bicCategoria": bicCategoria,
            "municipioNombre": municipioNombre,
            "bicDescripcion": bicDescripcion,
            "boletin1URL": boletin1URL,
            "latitude": latitude,
            "longitude": longitude
        ]
    }
}

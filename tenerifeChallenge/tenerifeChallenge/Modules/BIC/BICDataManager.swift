//
//  BICDataManager.swift
//  tenerifeChallenge
//
//  Created by Markel Juaristi on 14/10/24.
//


import Combine
import CoreLocation

class BICDataManager: ObservableObject {
    private var firestoreManager = BICFirestoreManager()
    @Published var bics = [BIC]() // Mantener los BIC en memoria
    private var cancellables = Set<AnyCancellable>()
    
    func loadBICs() -> AnyPublisher<[BIC], Error> {
        // Obtenemos los BICs de Firestore
        return firestoreManager.fetchBICs()
            .handleEvents(receiveOutput: { [weak self] bics in
                self?.bics = bics // Guardar los BICs obtenidos
            })
            .eraseToAnyPublisher()
    }
    
    func filterBICs(by distance: Double, userLocation: CLLocation) -> [BIC] {
        // Filtrar por distancia
        return bics.filter { bic in
            let bicLocation = CLLocation(latitude: bic.latitude, longitude: bic.longitude)
            return userLocation.distance(from: bicLocation) / 1000 <= distance // Convertir a km
        }
    }
}

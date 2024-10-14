//
//  BICViewModel.swift
//  tenerifeChallenge
//
//  Created by Markel Juaristi on 14/10/24.
//


import Combine
import CoreLocation

class BICViewModel: ObservableObject {
    @Published var filteredBICs = [BIC]()
    private var bicManager = BICDataManager()
    private var cancellables = Set<AnyCancellable>()
    private var allBICs = [BIC]() // Mantener todos los BICs en memoria

    init() {
        // Cargar todos los BICs al inicializar
        loadAllBICs()
    }

    // Cargar todos los BICs sin aplicar filtros
    func loadAllBICs() {
        bicManager.loadBICs() // Ahora devuelve un Publisher
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error al cargar BICs: \(error)")
                }
            }, receiveValue: { [weak self] bics in
                self?.allBICs = bics
                self?.filteredBICs = bics
            })
            .store(in: &cancellables)
    }

    // Aplicar filtros por distancia
    func applyFilters(distance: Double?, userLocation: CLLocation) {
        var filtered = allBICs

        // Filtrar por distancia si hay una seleccionada
        if let distance = distance {
            filtered = filtered.filter { bic in
                let bicLocation = CLLocation(latitude: bic.latitude, longitude: bic.longitude)
                return userLocation.distance(from: bicLocation) / 1000 <= distance
            }
        }

        // Actualizar la lista de BICs filtrados
        self.filteredBICs = filtered
    }
}

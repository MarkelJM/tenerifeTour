//
//  BICView.swift
//  tenerifeChallenge
//
//  Created by Markel Juaristi on 14/10/24.
//


import SwiftUI
import CoreLocation



struct BICView: View {
    @StateObject private var viewModel = BICViewModel()
    @ObservedObject var locationManager = LocationManager()
    @State private var selectedBIC: BIC?

    // Estados para los filtros
    @State private var selectedDistance: Double? = nil // Filtro de distancia (opcional)
    let distanceOptions: [Double] = [10, 20, 50, 100, 200] // Opciones de distancia en km

    @State private var showingDistanceFilter = false // Mostrar filtro de distancia

    var body: some View {
        VStack {
            // Botón para cargar todos los BICs sin filtros
            Button(action: {
                viewModel.loadAllBICs() // Cargar todos los BICs
            }) {
                Text("Mostrar Todos los BICs")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            // Botones de filtros de distancia
            HStack {
                // Filtro de distancia
                Button(action: {
                    showingDistanceFilter.toggle()
                }) {
                    HStack {
                        Image(systemName: "location.circle")
                        Text(selectedDistance == nil ? "Seleccionar Distancia" : "Distancia: \(Int(selectedDistance!)) km")
                    }
                }
                .sheet(isPresented: $showingDistanceFilter) {
                    DistanceFilterView(selectedDistance: Binding($selectedDistance, replacingNilWith: 50), options: distanceOptions) {
                        viewModel.applyFilters(distance: selectedDistance, userLocation: locationManager.location ?? CLLocation(latitude: 43.3167, longitude: -1.9836))
                    }
                }
            }
            .padding()

            // Botón para quitar filtros
            Button(action: {
                selectedDistance = nil
                viewModel.applyFilters(distance: nil, userLocation: locationManager.location ?? CLLocation(latitude: 43.3167, longitude: -1.9836))
            }) {
                HStack {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.red)
                    Text("Quitar Distancia")
                        .foregroundColor(.red)
                }
            }
            .padding()

            // Lista de BICs filtrados o sin filtros
            if let location = locationManager.location {
                List(viewModel.filteredBICs) { bic in
                    BICRow(bic: bic)
                        .onTapGesture {
                            selectedBIC = bic
                        }
                }
                .sheet(item: $selectedBIC) { bic in
                    if let url = URL(string: bic.boletin1URL) {
                        EventWebView(url: url)
                    } else {
                        Text("No se puede cargar la página web")
                    }
                }
                .onAppear {
                    viewModel.loadAllBICs() // Mostrar todos los BICs cuando aparezca la vista
                }
            } else {
                Text("Esperando ubicación...")
                    .onAppear {
                        viewModel.loadAllBICs() // Cargar BICs predeterminados si no hay ubicación
                    }
            }
        }
        .navigationTitle("BICs")
        .navigationBarTitleDisplayMode(.inline)
    }
}
extension Binding {
    /// Provides a default value for optional bindings.
    init(_ source: Binding<Value?>, replacingNilWith defaultValue: Value) {
        self.init(
            get: { source.wrappedValue ?? defaultValue },
            set: { source.wrappedValue = $0 }
        )
    }
}

struct DistanceFilterView: View {
    @Binding var selectedDistance: Double
    let options: [Double]
    var applyFilter: () -> Void

    var body: some View {
        VStack {
            Text("Selecciona la distancia")
                .font(.headline)
                .padding()

            Picker("Distancia", selection: $selectedDistance) {
                ForEach(options, id: \.self) { distance in
                    Text("\(Int(distance)) km").tag(distance)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .padding()

            Button(action: {
                applyFilter() // Aplica el filtro de distancia
            }) {
                Text("Aplicar filtro")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.mateGold) // Usamos mateGold para coherencia
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
            }
        }
    }
}

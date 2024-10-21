//
//  BICRow.swift
//  tenerifeChallenge
//
//  Created by Markel Juaristi on 14/10/24.
//


import SwiftUI

struct BICRow: View {
    let bic: BIC

    var body: some View {
        VStack(alignment: .leading) {
            Text("Nombre: \(bic.bicNombre)")
                .font(.headline)
            Text("Municipio: \(bic.municipioNombre)")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

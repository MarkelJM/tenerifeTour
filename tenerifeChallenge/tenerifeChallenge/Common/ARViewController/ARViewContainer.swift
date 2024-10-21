//
//  ARViewContainer.swift
//  tenerifeChallenge
//
//  Created by Markel Juaristi on 14/10/24.
//


import UIKit
import Foundation
import ARKit
import RealityKit
import SwiftUI
import FirebaseStorage
import ZIPFoundation

struct ARViewContainer<VM: BaseViewModel>: UIViewRepresentable {
    var prizeImageName: String
    var viewModel: VM
    @State private var tapCount: Int = 0
    @State private var lastTapTime: Date?

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)

        #if !targetEnvironment(simulator)
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        configuration.environmentTexturing = .automatic
        arView.session.run(configuration)

        setupARScene(arView: arView, context: context)

        // Gesto de toque
        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleTap(_:)))
        arView.addGestureRecognizer(tapGesture)

        // Mostrar mensaje inicial
        context.coordinator.showInitialMessage()
        #endif

        return arView
    }

    func setupARScene(arView: ARView, context: Context) {
        #if !targetEnvironment(simulator)
        let storage = Storage.storage()
        let storageRef = storage.reference(forURL: prizeImageName)

        let tempDir = FileManager.default.temporaryDirectory
        let tempZipURL = tempDir.appendingPathComponent(UUID().uuidString + ".zip")

        storageRef.write(toFile: tempZipURL) { (url, error) in
            if let error = error {
                print("Error al descargar el archivo comprimido: \(error)")
                return
            }

            do {
                let destinationURL = tempDir.appendingPathComponent(UUID().uuidString)
                try FileManager.default.createDirectory(at: destinationURL, withIntermediateDirectories: true, attributes: nil)
                try FileManager.default.unzipItem(at: tempZipURL, to: destinationURL)

                let usdzFileURL = try FileManager.default.contentsOfDirectory(at: destinationURL, includingPropertiesForKeys: nil)
                    .first { $0.pathExtension == "usdz" }

                if let modelEntity = try? ModelEntity.loadModel(contentsOf: usdzFileURL!) {
                    // Ajustar la escala inicial si el modelo está en metros o centímetros
                    modelEntity.scale = [0.035, 0.035, 0.035]
                    
                    // Posicionar el ancla de manera que el modelo esté a una distancia razonable de la cámara
                    let anchorEntity = AnchorEntity(world: [0, -1, -4])
                    
                    // Añadir el modelo al ancla
                    anchorEntity.addChild(modelEntity)
                    arView.scene.addAnchor(anchorEntity)

                    // Añadir rotación continua con velocidad inicial
                    context.coordinator.addContinuousRotation(modelEntity, speed: 0.05)

                    context.coordinator.currentEntity = modelEntity
                } else {
                    print("Error: No se pudo cargar el archivo como ModelEntity")
                }
            } catch {
                print("Error al descomprimir el archivo o cargar el modelo: \(error)")
            }
        }
        #endif
    }

    func updateUIView(_ uiView: ARView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self, viewModel: viewModel, tapCount: $tapCount, lastTapTime: $lastTapTime)
    }

    class Coordinator: NSObject {
        var parent: ARViewContainer
        var currentEntity: ModelEntity?
        var viewModel: VM
        @Binding var tapCount: Int
        @Binding var lastTapTime: Date?
        var timer: Timer?
        var rotationSpeed: Float = 0.05

        init(_ parent: ARViewContainer, viewModel: VM, tapCount: Binding<Int>, lastTapTime: Binding<Date?>) {
            self.parent = parent
            self.viewModel = viewModel
            self._tapCount = tapCount
            self._lastTapTime = lastTapTime
        }

        @objc func handleTap(_ sender: UITapGestureRecognizer) {
            let now = Date()
            let interval = lastTapTime?.timeIntervalSince(now) ?? 0

            if interval > 1.5 {
                tapCount = 1 // Reset counter si los toques están muy separados
            } else {
                tapCount += 1
            }

            lastTapTime = now

            if let modelEntity = currentEntity {
                if tapCount == 1 {
                    adjustRotationSpeed(modelEntity) // Ralentizar rotación al primer toque
                } else if tapCount == 2 {
                    triggerResultAction() // Navegar al segundo toque
                }
            }
        }

        func adjustRotationSpeed(_ model: ModelEntity) {
            // Ralentizar la rotación
            rotationSpeed = 0.01 // Ajustar la velocidad para hacerla más lenta
            timer?.invalidate()
            addContinuousRotation(model, speed: rotationSpeed)
        }

        func triggerResultAction() {
            
            if let challengeRewardViewModel = viewModel as? ChallengeRewardViewModel {
                challengeRewardViewModel.completeRewardTask()
            } else if let coinViewModel = viewModel as? CoinViewModel {
                if let coin = coinViewModel.coins.first {
                    coinViewModel.completeTask(coin: coin)
                }
            }
        }

        // Rotación continua usando un timer con velocidad ajustable
        func addContinuousRotation(_ model: ModelEntity, speed: Float) {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { _ in
                model.transform.rotation *= simd_quatf(angle: speed, axis: [0, 1, 0])
            }
        }

        func showInitialMessage() {
            let alert = UIAlertController(title: "Para el objeto", message: "El premio está girando, tocalo para ralentizarlo y llevártelo", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

            if let window = UIApplication.shared.windows.first, let rootVC = window.rootViewController {
                rootVC.present(alert, animated: true, completion: nil)
            }
        }
    }
}


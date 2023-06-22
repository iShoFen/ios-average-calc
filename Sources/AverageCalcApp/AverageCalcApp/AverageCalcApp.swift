//
//  AverageCalcApp.swift
//  AverageCalcApp
//
//  Created by Samuel SIRVEN on 25/05/2023.
//

import SwiftUI
import AverageCalcStub
import AverageCalcViewModel
import AverageCalcModel
import JsonDataManager

@main
struct UCAverageApp: App {
    @StateObject var ucaVM = UCAVM()

    @Environment(\.scenePhase) private var scenePhase

    private var dataManager: DataManager = JsonDataManager(withFilename: "uca.data")

    var body: some Scene {
        WindowGroup {
            HomePage(ucaVM: ucaVM)
                .task {
                    do {
                        let uca = try await dataManager.load()
                        if uca.blocks.isEmpty {
                            ucaVM.load(from: loadAllBlocks())
                        } else {
                            ucaVM.load(from: uca)
                        }
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
                .onChange(of: scenePhase) { phase in
                    if phase == .inactive {
                        Task {
                            do {
                                let uca = ucaVM.model
                                _ = try await dataManager.save(uca)
                            } catch {
                                fatalError(error.localizedDescription)
                            }
                        }
                    }
                }
        }
    }
}

//
//  DataManager.swift
//  AverageCalcModel
//
//  Created by Samuel SIRVEN on 21/06/2023.
//

import Foundation

public protocol DataManager {
    func load() async throws -> UCA
    func save(_ uca: UCA) async throws
}


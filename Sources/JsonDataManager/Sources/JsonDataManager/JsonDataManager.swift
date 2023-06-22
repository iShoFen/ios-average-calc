//
//  JsonDataManager.swift
//  JsonDataManager
//
//  Created by Samuel SIRVEN on 21/06/2023.
//

import Foundation
import AverageCalcModel

public class JsonDataManager: DataManager {

    public private(set) var filename: String

    public init(withFilename filename: String) {
        self.filename = filename
    }
    
    private func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent(filename)
    }
    
    public func load() async throws -> UCA {
        let task = Task<UCA, Error> {
            let fileURL = try self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return UCA()
            }
            let uca = try JSONDecoder().decode(UCA.self, from: data)
            return uca
        }
        let uca = try await task.value
        return uca
    }
    
    public func save(_ uca: UCA) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(uca)
            let outfile = try self.fileURL()
            try data.write(to: outfile)
        }
        
        _ = try await task.value
    }
}

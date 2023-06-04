//
//  Stub.swift
//  AverageCalcStub
//
//  Created by Samuel SIRVEN on 25/05/2023.
//

import Foundation
import AverageCalcModel

private var ue1: UE = UE(name: "UE1 Génie Logiciel", coefficient: 6, courses: [
    Course(name: "Processus de développement", mark: 11.75, coefficient: 4),
    Course(name: "Programmation Objets", mark: 16.71, coefficient: 9),
    Course(name: "Qualité de développpement", mark: 13.2, coefficient: 5),
    Course(name: "Remise à niveau objets", mark: 20, coefficient: 4)
])

private var ue2: UE = UE(name: "UE2 Systèmes et réseaux", coefficient: 6, courses: [
    Course(name: "Internet des Objets", mark: 0, coefficient: 4),
    Course(name: "Réseaux", mark: 12.5, coefficient: 4),
    Course(name: "Services Mobiles", mark: 17, coefficient: 4),
    Course(name: "Système", mark: 12.13, coefficient: 5)
])

private var ue3: UE = UE(name: "UE3 Insertion Professionnelle", coefficient: 6, courses: [
    Course(name: "Anglais", mark: 12.53, coefficient: 5),
    Course(name: "Economie", mark: 0, coefficient: 4),
    Course(name: "Gestion", mark: 0, coefficient: 3),
    Course(name: "Communication", mark: 11.5, coefficient: 4)
])

private var ue4: UE = UE(name: "UE4 Technologies Mobiles 1", coefficient: 9, courses: [
    Course(name: "Android", mark: 14, coefficient: 6),
    Course(name: "Architecture de projets C# .NET (1)", mark: 18.5, coefficient: 5),
    Course(name: "C++", mark: 15.19, coefficient: 4),
    Course(name: "Swift", mark: 18.05, coefficient: 5)
])

private var ue5: UE = UE(name: "UE5 Technologies Mobiles 2", coefficient: 9, courses: [
    Course(name: "Architecture de projets C# .NET (2)", mark: 16.6, coefficient: 4),
    Course(name: "Client/Serveur", mark: 0, coefficient: 4),
    Course(name: "iOS", mark: 0, coefficient: 5),
    Course(name: "Multiplateformes", mark: 0, coefficient: 3),
    Course(name: "QT Quick", mark: 0, coefficient: 5),
    Course(name: "MAUI", mark: 0, coefficient: 5)
])

private var ue6: UE = UE(name: "UE6 Projet", coefficient: 9, courses: [
    Course(name: "Projet", mark: 16.84, coefficient: 1)
])

private var ue7: UE = UE(name: "UE7 Stage", coefficient: 15, courses: [
    Course(name: "Stage", mark: 0, coefficient: 1)
])

public func loadAllBlocks() -> [Block] {
    [
       Block(name: "Total", ues: [ue1, ue2, ue3, ue4, ue5, ue6, ue7]),
       Block(name: "Projet/Stage", ues: [ue6, ue7])
    ]
}

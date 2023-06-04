//
//  Stub.swift
//  AverageCalcStub
//
//  Created by Samuel SIRVEN on 25/05/2023.
//

import Foundation
import AverageCalcModel

private var ue1: UE = UE(withName: "UE1 Génie Logiciel", andCoefficient: 6, andCourses: [
    Course(withName:"Processus de développement", andMark: 11.75, andCoefficient: 4),
    Course(withName: "Programmation Objets", andMark: 16.71, andCoefficient: 9),
    Course(withName: "Qualité de développpement", andMark: 13.2, andCoefficient: 5),
    Course(withName: "Remise à niveau objets", andMark: 20, andCoefficient: 4)
])

private var ue2: UE = UE(withName: "UE2 Systèmes et réseaux", andCoefficient: 6, andCourses: [
    Course(withName: "Internet des Objets", andMark: 0, andCoefficient: 4),
    Course(withName: "Réseaux", andMark: 12.5, andCoefficient: 4),
    Course(withName: "Services Mobiles", andMark: 17, andCoefficient: 4),
    Course(withName: "Système", andMark: 12.13, andCoefficient: 5)
])

private var ue3: UE = UE(withName: "UE3 Insertion Professionnelle", andCoefficient: 6, andCourses: [
    Course(withName: "Anglais", andMark: 12.53, andCoefficient: 5),
    Course(withName: "Economie", andMark: 0, andCoefficient: 4),
    Course(withName: "Gestion", andMark: 0, andCoefficient: 3),
    Course(withName: "Communication", andMark: 11.5, andCoefficient: 4)
])

private var ue4: UE = UE(withName: "UE4 Technologies Mobiles 1", andCoefficient: 9, andCourses: [
    Course(withName: "Android", andMark: 14, andCoefficient: 6),
    Course(withName: "Architecture de projets C# .NET (1)", andMark: 18.5, andCoefficient: 5),
    Course(withName: "C++", andMark: 15.19, andCoefficient: 4),
    Course(withName: "Swift", andMark: 18.05, andCoefficient: 5)
])

private var ue5: UE = UE(withName: "UE5 Technologies Mobiles 2", andCoefficient: 9, andCourses: [
    Course(withName: "Architecture de projets C# .NET (2)", andMark: 16.6, andCoefficient: 4),
    Course(withName: "Client/Serveur", andMark: 0, andCoefficient: 4),
    Course(withName: "iOS", andMark: 0, andCoefficient: 5),
    Course(withName: "Multiplateformes", andMark: 0, andCoefficient: 3),
    Course(withName: "QT Quick", andMark: 0, andCoefficient: 5),
    Course(withName: "MAUI", andMark: 0, andCoefficient: 5)
])

private var ue6: UE = UE(withName: "UE6 Projet", andCoefficient: 9, andCourses: [
    Course(withName: "Projet", andMark: 16.84, andCoefficient: 1)
])

private var ue7: UE = UE(withName: "UE7 Stage", andCoefficient: 15, andCourses: [
    Course(withName: "Stage", andMark: 0, andCoefficient: 1)
])

public func loadAllBlocks() -> UCA {
    let block1 = Block(withName: "Total", andUes: [ue1, ue2, ue3, ue4, ue5, ue6, ue7])
    let block2 = Block(withName: "Projet/Stage", andUes: [ue6, ue7])
    return UCA(withBlocks: [block1, block2])
}

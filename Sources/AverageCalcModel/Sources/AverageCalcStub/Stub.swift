//
// Created by etudiant on 25/05/2023.
//

import Foundation
import AverageCalcModel

public struct Stub {
    private static let ue1: UE = UE(name: "Génie Logiciel", courses: [
        Course(name: "Processus de développement", mark: 0, coefficient: 1.09),
        Course(name: "Programmation Objets", mark: 0, coefficient: 2.46),
        Course(name: "Qualité de développpement", mark: 0, coefficient: 1.36),
        Course(name: "Remise à niveau objets", mark: 0, coefficient: 1.09)
    ])

    private static let ue2: UE = UE(name: "Systèmes et réseaux", courses: [
        Course(name: "Internet des Objets", mark: 0, coefficient: 1.41),
        Course(name: "Réseaux", mark: 0, coefficient: 1.41),
        Course(name: "Services Mobiles", mark: 0, coefficient: 1.41),
        Course(name: "Système", mark: 0, coefficient: 1.77)
    ])

    private static let ue3: UE = UE(name: "Insertion Professionnelle", courses: [
        Course(name: "Anglais", mark: 0, coefficient: 1.875),
        Course(name: "Economie", mark: 0, coefficient: 1.5),
        Course(name: "Gestion", mark: 0, coefficient: 1.125),
        Course(name: "Communication", mark: 0, coefficient: 1.5)
    ])

    private static let ue4: UE = UE(name: "Technologies Mobiles 1", courses: [
        Course(name: "Android", mark: 0, coefficient: 2.7),
        Course(name: "Architecture de projets C# .NET (1)", mark: 0, coefficient: 2.25),
        Course(name: "C++", mark: 0, coefficient: 1.8),
        Course(name: "Swift", mark: 0, coefficient: 2.25)
    ])

    private static let ue5: UE = UE(name: "Technologies Mobiles 2", courses: [
        Course(name: "Architecture de projets C# .NET (2)", mark: 0, coefficient: 1.39),
        Course(name: "Client/Serveur", mark: 0, coefficient: 1.39),
        Course(name: "iOS", mark: 0, coefficient: 1.73),
        Course(name: "Multiplateformes", mark: 0, coefficient: 1.03),
        Course(name: "QT Quick", mark: 0, coefficient: 1.73),
        Course(name: "Xamarin", mark: 0, coefficient: 1.73)
    ])

    private static let ue6: UE = UE(name: "Projet", courses: [
        Course(name: "Projet", mark: 0, coefficient: 9)
    ])

    private static let ue7: UE = UE(name: "Stage", courses: [
        Course(name: "Stage", mark: 0, coefficient: 15)
    ])

    public var total: Block = Block(name: "Total", ues: [ue1, ue2, ue3, ue4, ue5, ue6, ue7])
    public var projStage: Block = Block(name: "Projet/Stage", ues: [ue6, ue7])
}

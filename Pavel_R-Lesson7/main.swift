//
//  main.swift
//  Pavel_R-Lesson7
//
//  Created by Павел on 06.08.2020.
//  Copyright © 2020 Павел. All rights reserved.
//

import Foundation

enum LoadTruckError: Error {
    
    case noSpace (spaceNeed: Double)
    
    case truckIsBroken
}

struct Cargo {
    
    var weight: Double
    init(weight: Double) {
        
        self.weight = weight
    }
}


extension LoadTruckError: CustomStringConvertible {
    var description: String {
        switch self {
        case .noSpace(let spaceNeed):
            return "Недостаточно место в кузове \(operation.emptyTruck) кг , необходимо дополнительно: \(spaceNeed) кг"
        case .truckIsBroken:
            return "Грузовик сломан. Погрузка невозможна. Обратитесь в сервис"
        }
    }
}


class Load {
    
    var weightLimit = 50000.00
    var emptyTruck = 0.0
    var truckIsBroken = false
    
    init(weightLimit: Double, emptyTruck: Double, truckIsBroken: Bool) {
        self.weightLimit = weightLimit
        self.emptyTruck = emptyTruck
        self.truckIsBroken = truckIsBroken
    }
    
    func loadTruck(cargo: Cargo) throws {
        guard truckIsBroken == false else {
            throw LoadTruckError.truckIsBroken
        }
        guard cargo.weight <= (weightLimit - emptyTruck) else {
            if emptyTruck <= 0 {
                throw LoadTruckError.noSpace(spaceNeed: weightLimit - emptyTruck - cargo.weight)
            } else {
                throw LoadTruckError.noSpace(spaceNeed: -weightLimit + cargo.weight + emptyTruck)
            }
        }
        return emptyTruck = self.emptyTruck + cargo.weight
    }
    
    func attachTrailer (someTrailer: Double) {
        weightLimit = self.weightLimit + someTrailer
    }
    
    func printTruckSpase() {
        print("Загружено \(emptyTruck) кг")
        
    }
    
    func changeTruckState(truckIsBroken: Bool) {
        switch truckIsBroken {
        case true:
            self.truckIsBroken = true
        case false:
            self.truckIsBroken = false
        }
    }
}



let operation = Load(weightLimit: 50000.0, emptyTruck: 0, truckIsBroken: false)

do {
    try operation.loadTruck(cargo: .init(weight: 20000))
}   catch let error as LoadTruckError {
    print(error.description)
}

operation.printTruckSpase()

do {
    try operation.loadTruck(cargo: .init(weight: 30000))
}   catch let error as LoadTruckError {
    print(error.description)
}

operation.printTruckSpase()

operation.attachTrailer(someTrailer: 70000)

operation.printTruckSpase()

do {
    try operation.loadTruck(cargo: .init(weight: 90000))
}   catch let error as LoadTruckError {
    print(error.description)
}

operation.printTruckSpase()

operation.changeTruckState(truckIsBroken: true)

do {
    try operation.loadTruck(cargo: .init(weight: 90000))
}   catch let error as LoadTruckError {
    print(error.description)
}

operation.printTruckSpase()

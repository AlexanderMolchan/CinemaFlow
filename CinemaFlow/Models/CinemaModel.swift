//
//  CinemaModel.swift
//  CinemaFlow
//
//  Created by Александр Молчан on 30.01.23.
//

import Foundation

class CinemaModel {
    var name = ""
    var distance = ""
    
    init(name: String, distance: String) {
        self.name = name
        self.distance = distance
    }
    
    init() {
    }
    
    static func getCinemaData() -> [CinemaModel] {
        var cinemas = [CinemaModel]()
        let plaza = CinemaModel(name: "Screen Sinema", distance: "1.3 Km")
        let royal = CinemaModel(name: "Royal", distance: "3.7 Km")
        let pioner = CinemaModel(name: "Pioner", distance: "4.1 Km")
        let avrora = CinemaModel(name: "Avrora", distance: "10.7 Km")
        let belarus = CinemaModel(name: "Belarus", distance: "12.2 Km")
        
        cinemas.append(plaza)
        cinemas.append(royal)
        cinemas.append(pioner)
        cinemas.append(avrora)
        cinemas.append(belarus)
        
        return cinemas
    }

}

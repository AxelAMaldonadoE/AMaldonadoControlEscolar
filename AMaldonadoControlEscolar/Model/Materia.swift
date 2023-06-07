//
//  Materia.swift
//  AMaldonadoControlEscolar
//
//  Created by MacBookMBA15 on 06/06/23.
//

import Foundation

struct Materia : Codable{
    
    var IdMateria: Int
    var Nombre: String
    var Costo: Float
    
    init() {
        IdMateria = 0
        Nombre = ""
        Costo = 0.0
    }
}

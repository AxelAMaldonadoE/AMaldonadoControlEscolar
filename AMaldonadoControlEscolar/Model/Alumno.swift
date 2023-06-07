//
//  Alumno.swift
//  AMaldonadoControlEscolar
//
//  Created by MacBookMBA15 on 06/06/23.
//

import Foundation

struct Alumno : Codable {
    
    var IdAlumno: Int
    var Nombre: String
    var ApellidoPaterno: String
    var ApellidoMaterno: String
    var FechaNacimiento: String
    var Genero: String
    var Telefono: String
    
    init() {
        IdAlumno = 0
        Nombre = ""
        ApellidoPaterno = ""
        ApellidoMaterno = ""
        FechaNacimiento = ""
        Genero = ""
        Telefono = ""
    }
}

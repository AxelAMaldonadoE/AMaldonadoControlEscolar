//
//  Result.swift
//  AMaldonadoControlEscolar
//
//  Created by MacBookMBA15 on 06/06/23.
//

import Foundation

struct Result<T: Codable>: Codable{
    
    var Correct: Bool
    var ErrorMessage: String?
    var Object: T?
    var Objects: [T]?
    var Ex: Ex?
    
    init() {
        Correct = false
        ErrorMessage = nil
        Object = nil
        Objects = nil
        Ex = nil
    }
}

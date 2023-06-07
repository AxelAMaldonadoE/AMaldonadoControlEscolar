//
//  MateriaViewModel.swift
//  AMaldonadoControlEscolar
//
//  Created by MacBookMBA15 on 06/06/23.
//

import Foundation

class MateriaViewModel {
    
    static func GetAll(Response: @escaping(Result<Materia>?, Error?) -> Void) {
        let url = URL(string: "http://192.168.0.52/api/Materia")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let dataSource = data {
                let decoder = JSONDecoder()
                let result = try! decoder.decode(Result<Materia>.self, from: dataSource)
                Response(result, nil)
            }
            
            if let errorSource = error {
                Response(nil, errorSource)
            }
        }.resume()
    }
}
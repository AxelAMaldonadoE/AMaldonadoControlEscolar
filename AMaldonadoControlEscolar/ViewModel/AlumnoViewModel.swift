//
//  AlumnoViewModel.swift
//  AMaldonadoControlEscolar
//
//  Created by MacBookMBA15 on 06/06/23.
//

import Foundation

class AlumnoViewModel {
    
    static func GetAll(Response: @escaping(Result<Alumno>?, Error?) -> Void) {
        let url = URL(string: "http://192.168.0.52/api/Alumno")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let dataSource = data {
                let decoder = JSONDecoder()
                let resultSource = try! decoder.decode(Result<Alumno>.self, from: dataSource)
                Response(resultSource, nil)
            }
            
            if let errorSource = error {
                Response(nil, errorSource)
            }
        }.resume()
    }
    
}

//
//  MateriaViewModel.swift
//  AMaldonadoControlEscolar
//
//  Created by MacBookMBA15 on 06/06/23.
//

import Foundation

class MateriaViewModel {
    
    static func Add(_ materia: Materia, Response: @escaping(Result<Materia>?, Error?) -> Void) {
        let urlString = "http://192.168.0.52/api/Materia"
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(materia)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                let okRange = 200...299
                
                if okRange ~= httpResponse.statusCode {
                    if let dataSource = data {
                        let decoder = JSONDecoder()
                        let resultSource = try! decoder.decode(Result<Materia>.self, from: dataSource)
                        Response(resultSource, nil)
                        print("Se envio Add Materia Response")
                    }
                }
            }
            
            if let errorSource = error {
                Response(nil, errorSource)
                print("Se envio Add Materia Error")
            }
        }.resume()
    }
    
    static func Update(_ materia: Materia, Response: @escaping(Result<Materia>?, Error?) -> Void) {
        let urlString = "http://192.168.0.52/api/Materia/\(materia.IdMateria)"
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = try! JSONEncoder().encode(materia)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                let okRange = 200...299
                
                if okRange ~= httpResponse.statusCode {
                    if let dataSource = data {
                        let decoder = JSONDecoder()
                        let resultSource = try! decoder.decode(Result<Materia>.self, from: dataSource)
                        Response(resultSource, nil)
                        print("Se envio Update Materia Response")
                    }
                }
            }
            
            if let errorSource = error {
                Response(nil, errorSource)
                print("Se envio Update Materia Error")
            }
        }.resume()
    }
    
    static func Delete(_ idMateria: Int, Response: @escaping(Result<Materia>?, Error?) -> Void) {
        let urlString = "http://192.168.0.52/api/Materia/\(idMateria)"
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, respone, error in
            if let httpResponse = respone as? HTTPURLResponse {
                let okRange = 200...299
                
                if okRange ~= httpResponse.statusCode {
                    if let dataSource = data {
                        let decoder = JSONDecoder()
                        let resultSource = try! decoder.decode(Result<Materia>.self, from: dataSource)
                        Response(resultSource, nil)
                        print("Se envio Delete Materia Response")
                    }
                }
            }
            
            if let errorSource = error {
                Response(nil, errorSource)
                print("Se envio Delete Materia Error")
            }
        }.resume()
    }
    
    static func GetById(_ idMateria: Int, Response: @escaping(Result<Materia>?, Error?) -> Void) {
        let url = URL(string: "http://192.168.0.52/api/Materia/\(idMateria)")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                let okRange = 200...299
                
                if okRange ~= httpResponse.statusCode {
                    if let dataSource = data {
                        let decoder = JSONDecoder()
                        let resultSource = try! decoder.decode(Result<Materia>.self, from: dataSource)
                        
                        Response(resultSource, nil)
                        print("Se envio GetById Materia response")
                    }
                }
            }
            
            if let errorSource = error {
                Response(nil, errorSource)
                print("Se envio GetById Materia Error")
            }
        }.resume()
    }
    
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

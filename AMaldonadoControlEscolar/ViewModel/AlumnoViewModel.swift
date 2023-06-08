//
//  AlumnoViewModel.swift
//  AMaldonadoControlEscolar
//
//  Created by MacBookMBA15 on 06/06/23.
//

import Foundation

class AlumnoViewModel {
    
    static func Add(_ alumno: Alumno, Response: @escaping(Result<Alumno>?, Error?) -> Void) {
        let urlString = "http://192.168.0.52/api/Alumno"
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(alumno)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                let okRange = 200...299
                
                if okRange ~= httpResponse.statusCode {
                    if let dataSource = data {
                        let decoder = JSONDecoder()
                        let resultSource = try! decoder.decode(Result<Alumno>.self, from: dataSource)
                        Response(resultSource, nil)
                        print("Se envio Add Response")
                    }
                }
            }
            
            if let errorSource = error {
                Response(nil, errorSource)
                print("Se envio Add Error")
            }
        }.resume()
    }
    
    static func Update(_ alumno: Alumno, Response: @escaping(Result<Alumno>?, Error?) -> Void) {
        let urlString = "http://192.168.0.52/api/Alumno/\(alumno.IdAlumno)"
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = try! JSONEncoder().encode(alumno)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                let okRange = 200...299
                
                if okRange ~= httpResponse.statusCode {
                    if let dataSource = data {
                        let decoder = JSONDecoder()
                        let resultSource = try! decoder.decode(Result<Alumno>.self, from: dataSource)
                        Response(resultSource, nil)
                        print("Se envio Update Response")
                    }
                }
            }
            
            if let errorSource = error {
                Response(nil, errorSource)
                print("Se envio Update Error")
            }
        }.resume()
    }
    
    static func Delete(_ idAlumno: Int, Response: @escaping(Result<Alumno>?, Error?) -> Void) {
        let urlString = "http://192.168.0.52/api/Alumno/\(idAlumno)"
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
                        let resultSource = try! decoder.decode(Result<Alumno>.self, from: dataSource)
                        Response(resultSource, nil)
                        print("Se envio Delete Response")
                    }
                }
            }
            
            if let errorSource = error {
                Response(nil, errorSource)
                print("Se envio Delete Error")
            }
        }.resume()
        
    }
    
    static func GetById(_ idAlumno: Int, Response: @escaping(Result<Alumno>?, Error?) -> Void) {
        let url = URL(string: "http://192.168.0.52/api/Alumno/\(idAlumno)")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                let okRange = 200...299
                
                if okRange ~= httpResponse.statusCode {
                    if let dataSource = data {
                        let decoder = JSONDecoder()
                        let resultSource = try! decoder.decode(Result<Alumno>.self, from: dataSource)
                        Response(resultSource, nil)
                        print("Se envio GetById response")
                    }
                }
            }
            
            if let errorSource = error {
                Response(nil, errorSource)
                print("Se envio GetById Error")
            }
        }.resume()
    }
    
    static func GetAll(Response: @escaping(Result<Alumno>?, Error?) -> Void) {
        //        let urlString = "http://192.168.0.52/api/Alumno"
        let url = URL(string: "http://192.168.0.52/api/Alumno")!
        //        let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                let okRange = 200...299
                
                if okRange ~= httpResponse.statusCode {
                    if let dataSource = data {
                        let decoder = JSONDecoder()
                        let resultSource = try! decoder.decode(Result<Alumno>.self, from: dataSource)
                        Response(resultSource, nil)
                        print("Se envio GetAll response")
                    }
                }
            }
            
            if let errorSource = error {
                Response(nil, errorSource)
                print("Se envio GetAll error")
            }
        }.resume()
    }
    
}

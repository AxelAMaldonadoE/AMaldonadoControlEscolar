//
//  GetAllAlumnoController.swift
//  AMaldonadoControlEscolar
//
//  Created by MacBookMBA15 on 06/06/23.
//

import UIKit

class GetAllAlumnoController: UITableViewController {
    
    var result = Result<Alumno>()
    var ListaAlumnos: [Alumno] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        RegisterCelda()
        GetAll()
    }

    // MARK: Funciones privadas para el manejo de datos
    
    private func GetAll() {
        AlumnoViewModel.GetAll { Result, Error in
            if let result = Result {
                self.result = result
                self.UpdateTabla()
            }
            
            if let error = Error {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Notificacion", message: error.localizedDescription, preferredStyle: .alert)
                    let action = UIAlertAction(title: "Aceptar", style: .default)
                    alert.addAction(action)
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    private func UpdateTabla() {
        if result.Correct {
            self.ListaAlumnos.removeAll()
            for alumno in result.Objects! {
                self.ListaAlumnos.append(alumno)
            }
        } else {
            let alert = UIAlertController(title: "Notificacion", message: result.ErrorMessage!, preferredStyle: .alert)
            let action = UIAlertAction(title: "Aceptar", style: .default)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
                self.tableView.updateConstraints()
        }
    }
    
    private func RegisterCelda() {
        let celda = UINib(nibName: "AlumnoCell", bundle: nil)
        
        self.tableView.register(celda, forCellReuseIdentifier: "AlumnoCell")
    }
    
    // MARK: Funciones exclusivas de TableViewController
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListaAlumnos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let celda = tableView.dequeueReusableCell(withIdentifier: "AlumnoCell", for: indexPath) as? AlumnoCell {
            
            let nombreCompleto = "\(ListaAlumnos[indexPath.row].Nombre) \(ListaAlumnos[indexPath.row].ApellidoPaterno) \(ListaAlumnos[indexPath.row].ApellidoMaterno)"
            
            celda.lblNombre.text = nombreCompleto
            
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "dd/MM/yyyy"
            let date = dateFormater.date(from: ListaAlumnos[indexPath.row].FechaNacimiento)
            
            celda.lblFechaNacimiento.text = dateFormater.string(from: date!)
            celda.lblGenero.text = ListaAlumnos[indexPath.row].Genero
            celda.lblTelefono.text = ListaAlumnos[indexPath.row].Telefono
            
            return celda
        }
        
        return UITableViewCell()
    }

}

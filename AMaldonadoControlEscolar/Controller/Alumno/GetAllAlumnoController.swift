//
//  GetAllAlumnoController.swift
//  AMaldonadoControlEscolar
//
//  Created by MacBookMBA15 on 06/06/23.
//

import UIKit
import SwipeCellKit

class GetAllAlumnoController: UITableViewController {
    
    // Variables
    var ResultGlobal = Result<Alumno>()
    var ListaAlumnos: [Alumno] = []
    var IdAlumno: Int = 0
    

    // MARK: Funciones de ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        RegisterCelda()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        GetAll()
        IdAlumno = 0
    }
    
    @IBAction func unwindToGetAllAlumno(_ unwindSegue: UIStoryboardSegue) {
        let _ = unwindSegue.source

    }

    // MARK: Funciones privadas para el manejo de datos
    
    private func GetAll() {
        AlumnoViewModel.GetAll { resultSource, errorSource in
            if let result = resultSource {
                self.ResultGlobal = result
                self.UpdateTabla()
            }
            
            if let error = errorSource {
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
        if ResultGlobal.Correct {
            self.ListaAlumnos.removeAll()
            for alumno in ResultGlobal.Objects! {
                self.ListaAlumnos.append(alumno)
            }
        } else {
            let alert = UIAlertController(title: "Notificacion", message: ResultGlobal.ErrorMessage!, preferredStyle: .alert)
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
            
            celda.delegate = self
            
            let nombreCompleto = "\(ListaAlumnos[indexPath.row].Nombre) \(ListaAlumnos[indexPath.row].ApellidoPaterno) \(ListaAlumnos[indexPath.row].ApellidoMaterno)"
            
            celda.lblNombre.text = nombreCompleto
            
//            let dateFormater = DateFormatter()
//            dateFormater.dateFormat = "dd-MM-yyyy"
//            let date = dateFormater.date(from: ListaAlumnos[indexPath.row].FechaNacimiento)
            
            celda.lblFechaNacimiento.text = ListaAlumnos[indexPath.row].FechaNacimiento
            celda.lblGenero.text = ListaAlumnos[indexPath.row].Genero
            celda.lblTelefono.text = ListaAlumnos[indexPath.row].Telefono
            
            return celda
        }
        
        return UITableViewCell()
    }

}


// MARK: Extension para la libreria de SwipeCellKit
extension GetAllAlumnoController: SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        if orientation == .left {
            let update = SwipeAction(style: .default, title: "Actualizar") { action, indexPath in
                // Perform Segues to Form
                self.IdAlumno = self.ListaAlumnos[indexPath.row].IdAlumno
                print(self.IdAlumno)
                self.performSegue(withIdentifier: "toFormulario", sender: self)
            }
            update.backgroundColor = .systemBlue
            return [update]
        } else {
            let delete = SwipeAction(style: .default, title: "Eliminar") { action, indexPath in
                // Eliminar el registro
                let idAlumno = self.ListaAlumnos[indexPath.row].IdAlumno
                AlumnoViewModel.Delete(idAlumno) { resultSource, errorSource in
                    if resultSource!.Correct {
                        let alert = UIAlertController(title: "Notificacion", message: "El usuario se elimino correctamente.", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Aceptar", style: .default) { _ -> Void in
                            // Update table
                            self.GetAll()
                        }
                        alert.addAction(action)
                        DispatchQueue.main.async {
                            self.present(alert, animated: true)
                        }
                    } else {
                        let alert = UIAlertController(title: "Notificacion", message: "Ocurrio un error", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Aceptar", style: .default) { _ -> Void in
                            // Perform segue o pop
                        }
                        alert.addAction(action)
                        DispatchQueue.main.async {
                            self.present(alert, animated: true)
                        }
                    }
                }
            }
            delete.backgroundColor = .systemRed
            return [delete]
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        
        var options = SwipeOptions()
        
        options.expansionStyle = .selection
        options.transitionStyle = .border
        
        return options
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segue = segue.destination as! FormAlumnoController
        segue.IdAlumno = self.IdAlumno
    }
}

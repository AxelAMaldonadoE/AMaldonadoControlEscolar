//
//  GetallMateriaController.swift
//  AMaldonadoControlEscolar
//
//  Created by MacBookMBA15 on 06/06/23.
//

import UIKit
import SwipeCellKit

class GetallMateriaController: UIViewController {
    
    // Variables
    var ListaMaterias: [Materia] = []
    var result = Result<Materia>()
    var IdMateria = 0
    
    // Outlet
    @IBOutlet weak var tvMaterias: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvMaterias.dataSource = self
        tvMaterias.delegate = self
        
        RegisterCelda()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        GetAll()
        IdMateria = 0
    }
    
    // MARK: Funciones privadas para obtener datos
    
    private func GetAll() {
        MateriaViewModel.GetAll { Result, Error in
            if let result = Result {
                self.result = result
                self.UpdateTabla()
            }
            
            if let error = Error {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Notificación", message: error.localizedDescription, preferredStyle: .alert)
                    let action = UIAlertAction(title: "Aceptar", style: .default)
                    alert.addAction(action)
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
  
}

// MARK: Protocolos de Table View

extension GetallMateriaController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListaMaterias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let celda = tableView.dequeueReusableCell(withIdentifier: "MateriaCell", for: indexPath) as? MateriaCell {
            celda.delegate = self
            
            celda.lblNombre.text = ListaMaterias[indexPath.row].Nombre
            celda.lblCosto.text = String(format: "$ %.2f", ListaMaterias[indexPath.row].Costo)

            return celda
        }
        
        return UITableViewCell()
    }
    
    private func RegisterCelda() {
        let celda = UINib(nibName: "MateriaCell", bundle: nil)
        
        self.tvMaterias.register(celda, forCellReuseIdentifier: "MateriaCell")
    }
    
    private func UpdateTabla() {
        if result.Correct {
            self.ListaMaterias.removeAll()
            for materia in result.Objects! {
                self.ListaMaterias.append(materia)
            }
        } else {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Notificacion", message: self.result.ErrorMessage!, preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default)
                alert.addAction(action)
                self.present(alert, animated: true)
            }
        }
        DispatchQueue.main.async {
            self.tvMaterias.reloadData()
            self.tvMaterias.updateConstraints()
        }
    }

}


// MARK: Extension de Swipe Cell Kit
extension GetallMateriaController: SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        
        if orientation == .left {
            let update = SwipeAction(style: .default, title: "Actualizar") { action, indexPath in
                // perform Segues
                self.IdMateria = self.ListaMaterias[indexPath.row].IdMateria
                print(self.IdMateria)
                self.performSegue(withIdentifier: "toFormMateria", sender: self)
            }
            update.backgroundColor = .systemBlue
            return [update]
        } else {
            let delete = SwipeAction(style: .default, title: "Eliminar") { action, indexPath in
                // Realizar el delete
                let idMateria = self.ListaMaterias[indexPath.row].IdMateria
                MateriaViewModel.Delete(idMateria) { resultSource, errorSource in
                    if resultSource!.Correct {
                        let alert = UIAlertController(title: "Notificacion", message: "La materia se elimino correctamente.", preferredStyle: .alert)
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
        let segue = segue.destination as! FormMateriaController
        segue.IdMateria = self.IdMateria
    }
}

//
//  GetallMateriaController.swift
//  AMaldonadoControlEscolar
//
//  Created by MacBookMBA15 on 06/06/23.
//

import UIKit

class GetallMateriaController: UIViewController {
    
    // Variables
    var ListaMaterias: [Materia] = []
    var result = Result<Materia>()
    
    // Outlet
    @IBOutlet weak var tvMaterias: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvMaterias.dataSource = self
        tvMaterias.delegate = self
        
        RegisterCelda()
        GetAll()
    }
    
    // MARK: Funciones privadas para obtener datos
    
    private func RegisterCelda() {
        let celda = UINib(nibName: "MateriaCell", bundle: nil)
        
        self.tvMaterias.register(celda, forCellReuseIdentifier: "MateriaCell")
    }
    
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
            
            celda.lblNombre.text = ListaMaterias[indexPath.row].Nombre
            celda.lblCosto.text = String(format: "$ %.2f", ListaMaterias[indexPath.row].Costo)

            return celda
        }
        
        return UITableViewCell()
    }

}

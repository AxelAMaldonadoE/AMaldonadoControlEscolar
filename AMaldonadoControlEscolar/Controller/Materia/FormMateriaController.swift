//
//  FormMateriaController.swift
//  AMaldonadoControlEscolar
//
//  Created by MacBookMBA15 on 08/06/23.
//

import UIKit

class FormMateriaController: UIViewController {
    
    // MARK: Outlets
    
    // Text Field
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtCosto: UITextField!
    
    // Label
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblCosto: UILabel!
    
    // Button
    @IBOutlet weak var btnActions: UIButton!
    
    // MARK: Variables
    var IdMateria: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        OcultarLabel()
        
        if IdMateria == 0 {
            btnActions.setTitle("Agregar", for: .normal)
            btnActions.tintColor = UIColor.systemGreen
        } else {
            btnActions.setTitle("Actualizar", for: .normal)
            btnActions.tintColor = UIColor.systemBlue
            SetTxtMateria()
        }
        
    }
    
    @IBAction func btnAction(_ sender: UIButton) {
        guard txtNombre.text != "" else {
            txtNombre.backgroundColor = UIColor(red: 211/255, green: 10/255, blue: 4/255, alpha: 0.20)
            lblNombre.isHidden = false
            return
        }
        txtNombre.backgroundColor = UIColor(red: 156/255, green: 255/255, blue: 46/255, alpha: 0.20)
        lblNombre.isHidden = true
        
        guard lblCosto.text != "" else {
            lblCosto.backgroundColor = UIColor(red: 211/255, green: 10/255, blue: 4/255, alpha: 0.20)
            lblCosto.isHidden = false
            return
        }
        lblCosto.backgroundColor = UIColor(red: 156/255, green: 255/255, blue: 46/255, alpha: 0.20)
        lblCosto.isHidden = true
        
        var materia = Materia()
        materia.Nombre = txtNombre.text!
        materia.Costo = Float(txtCosto.text!)!
        
        if sender.titleLabel?.text == "Agregar" {
            MateriaViewModel.Add(materia) { resultSource, errorSource in
                if resultSource!.Correct {
                    let alert = UIAlertController(title: "Notificación", message: "La materia se agrego correctamente", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Aceptar", style: .default) { _ -> Void in
                        // Perform segue o pop
                    }
                    alert.addAction(action)
                    DispatchQueue.main.async {
                        self.present(alert, animated: true)
                    }
                } else {
                    let alert = UIAlertController(title: "Notificación", message: "Ocurrio un error\n\(resultSource!.Ex!.InnerException!.Message!)", preferredStyle: .alert)
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
        if sender.titleLabel?.text == "Actualizar" {
            materia.IdMateria = IdMateria
            MateriaViewModel.Update(materia) { resultSource, errorSource in
                if resultSource!.Correct {
                    let alert = UIAlertController(title: "Notificacion", message: "El usuario se actualizo correctamente.", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Aceptar", style: .default) { _ -> Void in
                        // Perform segue o pop
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
    }
    
    // MARK: Funciones Privadas Formulario
    private func OcultarLabel() {
        lblNombre.isHidden = true
        lblCosto.isHidden = true
    }
    
    private func SetTxtMateria() {
        MateriaViewModel.GetById(IdMateria) { resultSource, errorSource in
            if resultSource!.Correct {
                let alumno = resultSource!.Object!
                DispatchQueue.main.async {
                    self.txtNombre.text = alumno.Nombre
                    self.txtCosto.text = String(format: "%.2f", alumno.Costo)
                }
            } else {
                let alert = UIAlertController(title: "Notificacion", message: "Ocurrio un error\n\(resultSource!.Ex!.InnerException!.Message!)", preferredStyle: .alert)
                let action = UIAlertAction(title: "Aceptar", style: .default) {_ -> Void in
                    //Perform Unwind o Pop
                }
                
                alert.addAction(action)
                DispatchQueue.main.async {
                    self.present(alert, animated: true)
                }
            }
        }
    }

}

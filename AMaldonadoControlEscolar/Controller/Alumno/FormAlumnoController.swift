//
//  FormAlumnoController.swift
//  AMaldonadoControlEscolar
//
//  Created by MacBookMBA15 on 07/06/23.
//

import UIKit

class FormAlumnoController: UIViewController {
    
    // btn Oultet
    @IBOutlet weak var btnActions: UIButton!
    
    // txt Outlet
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtApellidoPaterno: UITextField!
    @IBOutlet weak var txtApellidoMaterno: UITextField!
    @IBOutlet weak var dpFechaNacimiento: UIDatePicker!
    @IBOutlet weak var txtGenero: UITextField!
    @IBOutlet weak var txtTelefono: UITextField!
    
    // lbl Outlet
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblApellidoPaterno: UILabel!
    @IBOutlet weak var lblApellidoMaterno: UILabel!
    @IBOutlet weak var lblGenero: UILabel!
    @IBOutlet weak var lblTelefono: UILabel!
    
    // Variables
    var IdAlumno: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        OcultarLabel()
        
        if IdAlumno == 0 {
            btnActions.tintColor = UIColor.systemGreen
            btnActions.setTitle("Agregar", for: .normal)
        } else {
            SetTxtAlumno()
            btnActions.tintColor = UIColor.systemBlue
            btnActions.setTitle("Actualizar", for: .normal)
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
        
        guard txtApellidoPaterno.text != "" else {
            txtApellidoPaterno.backgroundColor = UIColor(red: 211/255, green: 10/255, blue: 4/255, alpha: 0.20)
            lblApellidoPaterno.isHidden = false
            return
        }
        txtApellidoPaterno.backgroundColor = UIColor(red: 156/255, green: 255/255, blue: 46/255, alpha: 0.20)
        lblApellidoPaterno.isHidden = true
        
        guard txtApellidoMaterno.text != "" else {
            txtApellidoMaterno.backgroundColor = UIColor(red: 211/255, green: 10/255, blue: 4/255, alpha: 0.20)
            lblApellidoMaterno.isHidden = false
            return
        }
        txtApellidoMaterno.backgroundColor = UIColor(red: 156/255, green: 255/255, blue: 46/255, alpha: 0.20)
        lblApellidoMaterno.isHidden = true
        
        guard txtGenero.text != "" else {
            txtGenero.backgroundColor = UIColor(red: 211/255, green: 10/255, blue: 4/255, alpha: 0.20)
            lblGenero.isHidden = false
            return
        }
        txtGenero.backgroundColor = UIColor(red: 156/255, green: 255/255, blue: 46/255, alpha: 0.20)
        lblGenero.isHidden = true
        
        guard txtTelefono.text != "" else {
            txtTelefono.backgroundColor = UIColor(red: 211/255, green: 10/255, blue: 4/255, alpha: 0.20)
            lblTelefono.isHidden = false
            return
        }
        txtTelefono.backgroundColor = UIColor(red: 156/255, green: 255/255, blue: 46/255, alpha: 0.20)
        lblTelefono.isHidden = true
        
        var alumno = Alumno()
        alumno.Nombre = txtNombre.text!
        alumno.ApellidoPaterno = txtApellidoPaterno.text!
        alumno.ApellidoMaterno = txtApellidoMaterno.text!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        alumno.FechaNacimiento = dateFormatter.string(from: dpFechaNacimiento.date)
        alumno.Genero =  txtGenero.text!
        alumno.Telefono = txtTelefono.text!
        
        if sender.titleLabel?.text == "Agregar" {
            AlumnoViewModel.Add(alumno) { resultSource, errorSource in
                if resultSource!.Correct {
                    let alert = UIAlertController(title: "Notificación", message: "El usuario se agrego correctamente", preferredStyle: .alert)
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
            alumno.IdAlumno = self.IdAlumno
            AlumnoViewModel.Update(alumno) { resultSource, errorSource in
                if resultSource!.Correct {
                    let alert = UIAlertController(title: "Notificacion", message: "El usuario se actualizo correctamente.", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Aceptar", style: .default) { _ -> Void in
                        // Perform segue o pop
                        self.performSegue(withIdentifier: "", sender: self)
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
    
    // MARK: Funciones privadas Formulario
    private func OcultarLabel() {
        lblNombre.isHidden = true
        lblApellidoPaterno.isHidden = true
        lblApellidoMaterno.isHidden = true
        lblGenero.isHidden = true
        lblTelefono.isHidden = true
    }
    
    private func SetTxtAlumno() {
        AlumnoViewModel.GetById(IdAlumno) { result, error in
            if result!.Correct {
                let alumno = result!.Object!
                DispatchQueue.main.async {
                    self.txtNombre.text = alumno.Nombre
                    self.txtApellidoPaterno.text = alumno.ApellidoPaterno
                    self.txtApellidoMaterno.text = alumno.ApellidoMaterno
                    let dateFormater = DateFormatter()
                    dateFormater.dateFormat = "dd-MM-yyyy"
                    self.dpFechaNacimiento.date = dateFormater.date(from: alumno.FechaNacimiento)!
                    self.txtGenero.text = alumno.Genero
                    self.txtTelefono.text = alumno.Telefono
                }
            } else {
                let alert = UIAlertController(title: "Notificacion", message: "Ocurrio un error\n\(result!.Ex!.InnerException!.Message!)", preferredStyle: .alert)
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

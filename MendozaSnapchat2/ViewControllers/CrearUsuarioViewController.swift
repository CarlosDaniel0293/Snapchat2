//
//  CrearUsuarioViewController.swift
//  MendozaSnapchat2
//
//  Created by Daniel Mendoza on 30/05/24.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase

class CrearUsuarioViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func crearUsuarioTapped(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
            
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if let error = error {
                    print("Se presento el siguiente error al crear el usuario: \(error.localizedDescription)")
                    self.mostrarAlertaError(error.localizedDescription)
                } else {
                    print("El usuario fue creado exitosamente")
                    if let user = result?.user {
                        Database.database().reference().child("usuarios").child(user.uid).child("email").setValue(user.email)
                    }
                    self.mostrarAlertaUsuarioCreado()
                }
            }
        }

        func mostrarAlertaError(_ mensaje: String) {
            let alerta = UIAlertController(title: "Error", message: mensaje, preferredStyle: .alert)
            let btnOK = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            alerta.addAction(btnOK)
            self.present(alerta, animated: true, completion: nil)
        }

        func mostrarAlertaUsuarioCreado() {
            let alerta = UIAlertController(title: "Creacion de Usuario", message: "Usuario creado correctamente.", preferredStyle: .alert)
            let btnOK = UIAlertAction(title: "Aceptar", style: .default) { _ in
                self.dismiss(animated: true, completion: nil)
            }
            alerta.addAction(btnOK)
            self.present(alerta, animated: true, completion: nil)
        }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

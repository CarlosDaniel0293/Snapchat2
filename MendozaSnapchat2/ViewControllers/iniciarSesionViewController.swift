//
//  ViewController.swift
//  MendozaSnapchat
//
//  Created by Daniel Mendoza on 20/05/24.
//

import UIKit
import FirebaseAuth
import Firebase
import GoogleSignIn
import FirebaseDatabase

class iniciarSesionViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func iniciarSesionTapped(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
                    return
                }
                
                Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                    if let error = error {
                        print("Se presento el siguiente error: \(error.localizedDescription)")
                        self.mostrarAlertaCrearUsuario()
                    } else {
                        print("Inicio de sesion exitoso")
                        self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
                    }
                }
    }
    
    func mostrarAlertaCrearUsuario() {
        let alerta = UIAlertController(title: "Error de Autenticación", message: "El usuario no existe. ¿Desea crear una cuenta?", preferredStyle: .alert)
        let btnCrear = UIAlertAction(title: "Crear", style: .default) { _ in
            self.performSegue(withIdentifier: "crearUsuarioSegue", sender: nil)
        }
        let btnCancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alerta.addAction(btnCrear)
        alerta.addAction(btnCancelar)
        self.present(alerta, animated: true, completion: nil)
    }
    
    @IBAction func loginGoogle(_ sender: Any) {
        print("Entro")
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
          guard error == nil else {
            return
          }

          guard let user = result?.user,
            let idToken = user.idToken?.tokenString
          else {
            return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: user.accessToken.tokenString)

          // ...
        }
    }
}


//
//  LoginViewController.swift
//  Swiftbook ThirdApp
//
//  Created by Евгений Бияк on 17.07.2022.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton?) {
        guard let login = loginTextField.text, !login.isEmpty else {
            loginTextField.text = nil
            loginTextField.attributedPlaceholder = NSAttributedString(string: "Enter login", attributes: [.foregroundColor: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)])
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            passwordTextField.text = nil
            passwordTextField.attributedPlaceholder = NSAttributedString(string: "Enter password", attributes: [.foregroundColor: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)])
            return
        }
        performSegue(withIdentifier: "loginToMain", sender: login)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginToMain" {
            let mainViewController = segue.destination as? MainViewController
            mainViewController?.login = sender as? String
        }
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        let mainViewController = segue.source as? MainViewController
        if let changedLogin = mainViewController?.changeLoginTextField.text {
            loginTextField.text = changedLogin
        } else {
            loginTextField.text = nil
        }
        passwordTextField.text = nil
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            loginButtonTapped(nil)
            view.endEditing(true)
        }
        return true
    }
}

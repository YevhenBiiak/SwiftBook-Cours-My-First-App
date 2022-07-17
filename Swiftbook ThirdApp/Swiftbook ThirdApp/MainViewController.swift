//
//  MainViewController.swift
//  Swiftbook ThirdApp
//
//  Created by Евгений Бияк on 17.07.2022.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var changeLoginTextField: UITextField!
    
    var login: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeLoginTextField.delegate = self
        
        if let login = login {
            loginLabel.text = "Hello, \(login.capitalized)"
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        performSegue(withIdentifier: "unwind", sender: nil)
        return true
    }
}

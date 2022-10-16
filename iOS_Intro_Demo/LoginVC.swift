//
//  ViewController.swift
//  iOS_Intro_Demo
//
//  Created by Mohammad Kiani on 2022-10-16.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var switchRemember: UISwitch!

    @IBAction func signUp() {
        let mainSB = UIStoryboard(name: "Main", bundle: nil)
        let signUpVC = mainSB.instantiateViewController(withIdentifier: "SignUpScene")
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @IBAction func signIn() {
        if validateUser() {
            
            if switchRemember.isOn {
                //save the data
                UserDefaults.standard.set(textEmail.text!, forKey: "email")
                UserDefaults.standard.set(textPassword.text!, forKey: textEmail.text!)
            } else {
                UserDefaults.standard.removeObject(forKey: "email")
                UserDefaults.standard.removeObject(forKey: textEmail.text!)
            }
            
            //open home screen
            let mainSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let homeVC = mainSB.instantiateViewController(withIdentifier: "HomeScene")
            /// make a modal segue
//            self.present(homeVC, animated: true, completion: nil)
            navigationController?.pushViewController(homeVC, animated: true)
            
        } else {
            //display alert message
            let infoAlert = UIAlertController(title: "User Account", message: "Invalid Email and/or Password", preferredStyle: .alert)
            infoAlert.addAction(UIAlertAction(title: "Retry", style: .default, handler: nil))
            infoAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            infoAlert.addAction(UIAlertAction(title: "Don't bother me", style: .destructive, handler: nil))
            infoAlert.addAction(UIAlertAction(title: "Oh really !!", style: .default, handler: nil))
            
//            self.present(infoAlert, animated: true, completion: nil)
            self.present(infoAlert, animated: true) { [weak self] in
                self?.textEmail.text = ""
                self?.textPassword.text = ""
            }
        }
    }
    
    func validateUser() -> Bool{
        if textEmail.text == "test" && textPassword.text == "test"{
            return true
        } else {
            return false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let email = UserDefaults.standard.value(forKey: "email"){
            textEmail.text = email as? String
        }
    
        if let password = UserDefaults.standard.string(forKey: textEmail.text!){
            textPassword.text = password
        }
    }
}

//
//  SignupVC.swift
//  iOS_Intro_Demo
//
//  Created by Mohammad Kiani on 2022-10-16.
//

import UIKit

class SignupVC: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtContactNumber: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var pickCity: UIPickerView!
    @IBOutlet weak var txtPostalCode: UITextField!
    @IBOutlet weak var pickDOB: UIDatePicker!
    @IBOutlet weak var segGender: UISegmentedControl!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    let cityList : [String] = ["Toronto", "Vancouver", "New York", "Los Angeles", "Ajax", "Paris"]
    var gender: String!

    override func viewWillAppear(_ animated: Bool) {
        self.title = "Sign Up"
        navigationController?.setNavigationBarHidden(false, animated: true)
        let btnSubmit = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(displayInfo))
        self.navigationItem.rightBarButtonItem = btnSubmit
    }
    
    @objc func displayInfo() {
        
        var userInfo : String = txtName.text!
        userInfo += "\n" + txtContactNumber.text!
        userInfo += "\n" + txtAddress.text!
        userInfo += "\n" + txtEmail.text!
        userInfo += "\n" + txtPassword.text!
        userInfo += "\n \(pickDOB.date)"
        
        userInfo += "\n \(cityList[pickCity.selectedRow(inComponent: 0)])"
        
        switch segGender.selectedSegmentIndex {
        case 0:
            userInfo += "\n Male"
            gender = "Male"
        case 1:
            userInfo += "\n Female"
            gender = "Female"
        case 2:
            userInfo += "\n Others"
            gender = "Others"
        default:
            userInfo += "\n Others"
            gender = "Others"
        }
        
        let infoAlert = UIAlertController(title: "Verify Details", message: userInfo, preferredStyle: .alert)
        
        for case let textField as UITextField in self.view.subviews {
            if textField.text == "" {
                // show error
                infoAlert.message = "you should fill all fields"
                showError(infoAlert)
                return
            }
        }
        
        if txtPassword.text == txtConfirmPassword.text{
            infoAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: {_ in self.displayHomeVC()}))
        } else {
            infoAlert.message = "Both passwords must be same"
        }
        
        infoAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(infoAlert, animated: true, completion: nil)
    }
    
    private func showError(_ alert: UIAlertController) {
        let action = UIAlertAction(title: "Retry", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func displayHomeVC(){
        
        let newUser = User(name: txtName.text!, address: txtAddress.text!, contactNumber: txtContactNumber.text!, postalCode: txtPostalCode.text!, city: cityList[pickCity.selectedRow(inComponent: 0)], email: txtEmail.text!, password: txtPassword.text!, gender: self.gender, dob: pickDOB.date)
        
        if User.addUser(newUser: newUser) {
            let mainSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let homeVC = mainSB.instantiateViewController(withIdentifier: "HomeTVScene")
            navigationController?.pushViewController(homeVC, animated: true)
        } else {
            let infoAlert = UIAlertController(title: "User Account", message: "An account with this email address already exist.", preferredStyle: .alert)
            infoAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(infoAlert,animated: true)
        }
        
//        let mainSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let homeVC = mainSB.instantiateViewController(withIdentifier: "HomeScene")
//        navigationController?.pushViewController(homeVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickCity.delegate = self
        pickCity.dataSource = self
    }
}

extension SignupVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cityList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cityList[row]
    }
}

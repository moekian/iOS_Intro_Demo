//
//  HomeVC.swift
//  iOS_Intro_Demo
//
//  Created by Mohammad Kiani on 2022-10-16.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var displayGesturesLbl: UILabel!
    @IBOutlet weak var takeNoteLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapDisplayGestures = UITapGestureRecognizer(target: self, action: #selector(performTap))
        let tapTakeNote = UITapGestureRecognizer(target: self, action: #selector(performTap))
        
        tapDisplayGestures.numberOfTapsRequired = 1
        tapTakeNote.numberOfTapsRequired = 1
        
        displayGesturesLbl.addGestureRecognizer(tapDisplayGestures)
        displayGesturesLbl.isUserInteractionEnabled = true
        
        takeNoteLbl.addGestureRecognizer(tapTakeNote)
        takeNoteLbl.isUserInteractionEnabled = true
    }
    
    @objc func performTap(_ sender: UITapGestureRecognizer) {
        let tag = sender.view?.tag
        let mainSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        switch tag {
        case 1:
            let gesturesVC = mainSB.instantiateViewController(withIdentifier: "GestureScreen")
            navigationController?.pushViewController(gesturesVC, animated: true)
        case 2:
            print("2")
        default:
            return
        }
    }
}

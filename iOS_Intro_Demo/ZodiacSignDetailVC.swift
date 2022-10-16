//
//  ZodiacSignDetailVC.swift
//  iOS_Intro_Demo
//
//  Created by Mohammad Kiani on 2022-10-16.
//

import UIKit

class ZodiacSignDetailVC: UIViewController {
    
    @IBOutlet weak var lblZodiac: UILabel!
    @IBOutlet weak var lblZodiacBirthStone: UILabel!
    @IBOutlet weak var lblZodiacColor: UILabel!
    
    var plistArray = NSMutableArray()
    var selectedZodiacIndex: Int? {
        didSet {
            self.fetchZodiacDetails()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if selectedZodiacIndex !=  nil {
            self.displayDetails()
        }
    }
    
    func displayDetails(){
        lblZodiac.text = ZodiacItems.zodiac[self.selectedZodiacIndex!]
        let zodiacDetails = plistArray[self.selectedZodiacIndex!] as! NSMutableDictionary
        self.lblZodiacColor.text = zodiacDetails.value(forKey: "Color") as? String
        self.lblZodiacBirthStone.text = zodiacDetails.value(forKey: "BirthStone") as? String
    }
    
    func fetchZodiacDetails(){
        if let filePath = Bundle.main.path(forResource: "Zodiac", ofType: "plist") {
            
            //get an array representation of plist
            plistArray = NSMutableArray(contentsOfFile: filePath)!
            
            print("plistArray \(plistArray)")
        }
    }
}

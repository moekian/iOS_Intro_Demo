//
//  ZodiacSignCVC.swift
//  iOS_Intro_Demo
//
//  Created by Mohammad Kiani on 2022-10-16.
//

import UIKit

class ZodiacSignCVC: UICollectionViewController {

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return ZodiacItems.zodiac.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZodiacSign", for: indexPath) as! ZodiacSignCVCell
    
        // Configure the cell
        cell.imgZodiac.image = UIImage(named: ZodiacItems.zodiac[indexPath.row])
        cell.lblZodiac.text = ZodiacItems.zodiac[indexPath.row]
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
    func writeZodiacInfoToPlist(index: Int) {
        let myZodiac = NSMutableDictionary()
        myZodiac["Color"] = ZodiacItems.zodiacColors[index]
        myZodiac["BirthStone"] = ZodiacItems.zodiacBirthStone[index]
        if let plistPath = Bundle.main.path(forResource: "Zodiac", ofType: "plist") {
            let zodiacplist = NSMutableArray(contentsOfFile: plistPath)
            zodiacplist?.add(myZodiac)
            if (zodiacplist?.write(toFile: plistPath, atomically: true))! {
                print("Zodiaclist : \(String(describing: zodiacplist))")
            }
        } else {
            print("Unable to locate plist file")
        }
    }
}

/// adjust the size of cell in collectionView here by adopting the following protocol or set Estimate size of collectionView to none in storyboard
extension ZodiacSignCVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2 - 5, height: view.frame.height/4)
    }
}

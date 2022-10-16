//
//  HomeTVC.swift
//  iOS_Intro_Demo
//
//  Created by Mohammad Kiani on 2022-10-16.
//

import UIKit

class HomeTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TableItems.titles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeTVCell

        // Configure the cell...
        cell.lblTitle.text = TableItems.titles[indexPath.row]
        cell.lblSubtitle.text = TableItems.subTitles[indexPath.row]
        cell.imgHome.image = UIImage(named: TableItems.images[indexPath.row])

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let infoAlert = UIAlertController(title: "Menu Action", message: TableItems.titles[indexPath.row], preferredStyle: .alert)
//        infoAlert.addAction(UIAlertAction(title: "So What !!!", style: .default, handler: nil))
//        self.present(infoAlert, animated: true, completion: nil)
        
        switch indexPath.row {
        case 0:
            print("Audio performed")
        case 1:
            print("Video performed")
        case 2:
            print("Web performed")
            let mainSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let webVC = mainSB.instantiateViewController(withIdentifier: "WebScene") as! WebVC
            navigationController?.pushViewController(webVC, animated: true)
        case 3:
            print("Calender performed")
        case 4:
            print("Location performed")
        case 5:
            print("Contacts performed")
        case 6:
            print("Zodiac")
        default:
            print("No Action")
        }
    }
}

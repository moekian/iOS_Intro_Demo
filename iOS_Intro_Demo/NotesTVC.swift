//
//  NotesTVC.swift
//  iOS_Intro_Demo
//
//  Created by Mohammad Kiani on 2022-10-16.
//

import UIKit

class NotesTVC: UITableViewController {
    
    @IBOutlet weak var trashBtn: UIBarButtonItem!
    
    var deletingOption = false
    var noteVC: UIViewController!
    
    // notes
    private var notes = [Note]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Notes"
        let editBtn = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(toggleDeleteButton))
        navigationItem.rightBarButtonItem = editBtn
        navigationController?.isToolbarHidden = false
        
//        let mainSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        noteVC = mainSB.instantiateViewController(withIdentifier: "NoteScreen")
//        (noteVC as? NoteVC)?.delegate = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "note_cell", for: indexPath)
        let note = notes[indexPath.row]
        cell.textLabel?.text = note.text
        cell.textLabel?.textColor = .lightGray
        cell.imageView?.image = UIImage(systemName: "note")

        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let mainSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let noteVC = mainSB.instantiateViewController(withIdentifier: "NoteScreen") as? NoteVC
        noteVC?.delegate = self
        
        noteVC?.selectedNote = notes[indexPath.row]
        if let noteVC = noteVC, !deletingOption {
            navigationController?.pushViewController(noteVC, animated: true)
        }
    }

    @IBAction func addNote(_ sender: UIBarButtonItem) {
        
        let mainSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let noteVC = mainSB.instantiateViewController(withIdentifier: "NoteScreen") as? NoteVC
        noteVC?.delegate = self
        
        if let noteVC = noteVC {navigationController?.pushViewController(noteVC, animated: true)
        }
    }
    
    @IBAction func deleteNotes(_ sender: UIBarButtonItem) {
        if let indexPaths = tableView.indexPathsForSelectedRows {
            let rows = (indexPaths.map {$0.row}).sorted(by: >)
            
            let alert = UIAlertController(title: "Delete selected notes", message: "Are you sure?", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
                rows.forEach {self.notes.remove(at: $0)}
//                let _ = rows.map {self.notes.remove(at: $0)}
                self.disableEditingMode()
                self.tableView.reloadData()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                self.disableEditingMode()
            }
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    private func disableEditingMode() {
        tableView.setEditing(false, animated: true)
        deletingOption = false
        trashBtn.isEnabled = false
    }
    
    func addNote(_ note: Note) {
        notes.append(note)
    }
    
    func updateNote(_ note: Note, with text: String) {
        note.editNote(with: text)
    }
    
    @objc func toggleDeleteButton() {
        deletingOption = !deletingOption
        trashBtn.isEnabled = !trashBtn.isEnabled
        tableView.setEditing(deletingOption, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        disableEditingMode()
        tableView.reloadData()
    }
}

class Note {
    private var _text: String
    init(text: String) {
        self._text = text
    }
    var text: String {
        return _text
    }
    func editNote(with text: String) {
        self._text = text
    }
}

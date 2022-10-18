//
//  NoteVC.swift
//  iOS_Intro_Demo
//
//  Created by Mohammad Kiani on 2022-10-16.
//

import UIKit

class NoteVC: UIViewController {
    
    @IBOutlet weak var noteTextView: UITextView!
    
    var selectedNote: Note? {
        didSet {
            editingMode = true
        }
    }
    
    weak var delegate: NotesTVC?
    
    var editingMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteTextView.text = selectedNote?.text
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        guard noteTextView.text != "" else {return}
        if editingMode {
            delegate?.updateNote(selectedNote!, with: noteTextView.text)
        } else {
            delegate?.addNote(Note(text: noteTextView.text))
        }
    }
}

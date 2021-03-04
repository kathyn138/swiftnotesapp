//
//  NoteViewController.swift
//  Notes
//
//  Created by Kathy Nguyen on 2/22/21.
//

import UIKit

protocol NoteDelegate: class {
    func editNote (title: String, note: String) -> Void
}

class NoteViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak private var titleLabel : UILabel!
    @IBOutlet weak private var editableTitleLabel: UITextField!
    @IBOutlet weak private var noteField: UITextView!
    weak var delegate: NoteDelegate?
    
    // need to give these default values or will get "no initializers" error
    class Note {
        var noteTitle: String = ""
        var note: String = ""
    }
    
    var currNote = Note()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        title = "Note"
        
        titleLabel.text = currNote.noteTitle
        noteField.text = currNote.note
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(labelTapped))
    }
    
    @objc func labelTapped() {
        titleLabel.isHidden = true
        editableTitleLabel.isHidden = false
        editableTitleLabel.text = titleLabel.text
        editableTitleLabel.becomeFirstResponder()
        
        noteField.isEditable = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
    }
    
    @objc func didTapSave() {
        // if there is text and text isn't empty
        if let title = titleLabel.text, !title.isEmpty, !noteField.text.isEmpty {
            delegate?.editNote(title: title, note: noteField.text)
        }
    }

}

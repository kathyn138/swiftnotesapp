//
//  NewNoteViewController.swift
//  Notes
//
//  Created by Kathy Nguyen on 2/22/21.
//

import UIKit

protocol NewNoteDelegate: class {
    func makeNewNote (_ title: String, _ note: String) -> Void
}

class NewNoteViewController: UIViewController {
    @IBOutlet weak private var titleField: UITextField?
    @IBOutlet weak private var noteField: UITextView!
    weak var delegate: NewNoteDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // autofocuses here first and pull up a keyboard
        titleField?.becomeFirstResponder()
        title = "New Note"
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
    }
    
    @objc func didTapSave() {
        // if there is text and text isn't empty
        if let text = titleField?.text, !text.isEmpty, !noteField.text.isEmpty {
            delegate?.makeNewNote(text, noteField.text)
        }
    }
}

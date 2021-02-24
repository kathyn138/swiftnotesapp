//
//  NoteViewController.swift
//  Notes
//
//  Created by Kathy Nguyen on 2/22/21.
//

import UIKit


class NoteViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var titleLabel : UILabel!
    @IBOutlet var editableTitleLabel: UITextField!
    @IBOutlet var noteField: UITextView!
    
    // need to give these default values or will get "no initializers" error
    public var noteTitle: String = ""
    public var note: String = ""
    public var completion: ((String, String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editableTitleLabel.delegate = self
        titleLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        tapGesture.numberOfTapsRequired = 1
        titleLabel.addGestureRecognizer(tapGesture)
        
        titleLabel.text = noteTitle
        noteField.text = note
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
    }
    
    @objc func labelTapped() {
        titleLabel.isHidden = true
        editableTitleLabel.isHidden = false
        editableTitleLabel.text = titleLabel.text
        editableTitleLabel.becomeFirstResponder()
    }
    
    @objc func didTapSave() {
        // if there is text and text isn't empty
        if let text = titleLabel.text, !text.isEmpty, !noteField.text.isEmpty {
            completion?(text, noteField.text)
        }
        self.navigationController?.popToRootViewController(animated: true)
    }

}
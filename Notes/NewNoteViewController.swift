//
//  NewNoteViewController.swift
//  Notes
//
//  Created by Kathy Nguyen on 2/22/21.
//

import UIKit

class NewNoteViewController: UIViewController {
    @IBOutlet weak private var titleField: UITextField!
    @IBOutlet weak private var noteField: UITextView!
    
    // used to get data from this controller
    public var completion: ((String, String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // autofocuses here first and pull up a keyboard
        titleField.becomeFirstResponder()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
    }
    
    @objc func didTapSave() {
        // if there is text and text isn't empty
        if let text = titleField.text, !text.isEmpty, !noteField.text.isEmpty {
            completion?(text, noteField.text)
        }
    }
    

}

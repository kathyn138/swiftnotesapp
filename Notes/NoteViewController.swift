//
//  NoteViewController.swift
//  Notes
//
//  Created by Kathy Nguyen on 2/22/21.
//

import UIKit

class NoteViewController: UIViewController {
    @IBOutlet var titleLabel : UILabel!
    @IBOutlet var noteLabel: UITextView!
    
    // need to give these default values or will get "no initializers" error
    public var noteTitle: String = ""
    public var note: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = noteTitle
        noteLabel.text = note
    }
    

    

}

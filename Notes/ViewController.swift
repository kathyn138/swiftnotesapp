//
//  ViewController.swift
//  Notes
//
//  Created by Kathy Nguyen on 2/22/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NewNoteDelegate, NoteDelegate {
    @IBOutlet weak private var table: UITableView!
    @IBOutlet weak private var label: UILabel!
    
    struct Note {
        var title: String
        var note: String
    }
    
    var models: [Note] = []
    
    func makeNewNote(title: String, note: String) {
        self.navigationController?.popToRootViewController(animated: true)
        // add to list of notes
        self.models.append(Note(title: title, note: note))
        //  hide label bc now have notes
        self.label.isHidden = true
        // unhide table bc now have notes
        self.table.isHidden = false
        self.table.reloadData()
    }
    
    func editNote(title: String, note: String) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        title = "Notes"
    }
    
     @IBAction func didTapNewNote() {
        guard let vc = storyboard?.instantiateViewController(identifier: "new") as? NewNoteViewController else {
            return
        }
        
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row].title
        cell.detailTextLabel?.text = models[indexPath.row].note
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        // select row
        let model = models[indexPath.row]

        // show Note controller
        guard let vc = storyboard?.instantiateViewController(identifier: "note") as? NoteViewController else {
            return
        }
        
        vc.delegate = self
        vc.currNote.noteTitle = model.title
        vc.currNote.note = model.note
        navigationController?.pushViewController(vc, animated: true)
    }
}


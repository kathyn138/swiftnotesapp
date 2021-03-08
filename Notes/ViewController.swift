//
//  ViewController.swift
//  Notes
//
//  Created by Kathy Nguyen on 2/22/21.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NewNoteDelegate, NoteDelegate {
    @IBOutlet weak private var table: UITableView!
    @IBOutlet weak private var label: UILabel!
    
    let ref = Database.database().reference(withPath: "notes")

    struct Note {
        let title: String
        let note: String
        
        func toAnyObject() -> Any {
          return [
            "title": title,
            "note": note,
          ]
        }
        
        init(title: String, note: String) {
            self.title = title
            self.note = note
        }
        
        init?(snapshot: DataSnapshot) {
          guard
            let value = snapshot.value as? [String: AnyObject],
            let title = value["title"] as? String,
            let note = value["note"] as? String else {
            return nil
          }
          
          self.title = title
          self.note = note
        }
    }
    
    var models: [Note] = []
    
    func makeNewNote(title: String, note: String) {
        self.navigationController?.popToRootViewController(animated: true)
        let newNote = Note(title: title, note: note)
        let newNoteRef = self.ref.child(newNote.title.lowercased())
        // setValue accepts a dictionary
        // add new note to database
        newNoteRef.setValue(newNote.toAnyObject())
    }
    
    func editNote(title: String, note: String) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        title = "Notes"
        
        
        // listen for change in firebase db
        // update app with most recent data when changes occur
        ref.observe(.value, with: { snapshot in
            // store latest version of data in newNotes
            var newNotes: [Note] = []
            
            // listener's closure returns snapshot of latest set of data
            // snapshot has entire list of notes
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let note = Note(snapshot: snapshot) {
                    newNotes.append(note)
                }
            }
            // replace models with latest version of data
            self.models = newNotes
            
            // toggle label and table depending on if there is data
            if self.models.count > 0 {
                self.label.isHidden = true
                self.table.isHidden = false
            } else {
                self.label.isHidden = false
                self.table.isHidden = true
            }
            
            self.table.reloadData()
        })
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


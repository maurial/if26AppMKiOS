//
//  ViewController.swift
//  if26AppMK
//
//  Created by if26-grp3 on 12/12/2017.
//  Copyright © 2017 if26-grp3. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController {
    
    var GetAllDataInfo = NSMutableArray()
    
    var database : Connection!
    
    let marksTable = Table("marks")
    let id = Expression<Int>("id")
    let subjectCode = Expression<String>("subjectCode")
    let subjectMark = Expression<String>("subjectMark")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Création de la base de données
        do{
            let documentDirectory = try FileManager.default.url(for: .documentDirectory,
                in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("marks").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        }
        catch {
            print(error)
        }
        
        //Création de la table des notes
        let createTable = self.marksTable.create{ (table) in
            table.column(self.id, primaryKey: true)
            table.column(self.subjectCode)
            table.column(self.subjectMark)
        }
        
        do{
            try self.database.run(createTable)
            print("Table créée")
        }
        catch {
            print(error)
        }
        
    }
  
    
    //Bouton d'affichage
    @IBAction func insertMarks(_ sender: UIButton) {
        let alert = UIAlertController(title: "Ajouter une note", message: nil, preferredStyle: .alert)
        alert.addTextField { (tf) in tf.placeholder = "Code de l'UV" }
        alert.addTextField { (tf) in tf.placeholder = "Note sur 20" }
        let action = UIAlertAction(title: "Enregistrez", style: .default) { (_) in
            guard let subjectCode = alert.textFields?.first?.text,
                let subjectMark = alert.textFields?.last?.text
                else { return }
            print(subjectCode)
            print(subjectMark)
            
            let insertMarks = self.marksTable.insert(self.subjectCode <- subjectCode, self.subjectMark <- subjectMark)
            
            do{
                try self.database.run(insertMarks)
                print("Note ajoutée")
            } catch{
                print(error)
            }
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)    }
    
    @IBAction func listMarks(_ sender: UIButton) {
        
        do{
            let marks = try self.database.prepare(self.marksTable)
            for mark in marks {
                print("markID: \(mark[self.id]), subjectCode: \(mark[self.subjectCode]), subjectMark: \(mark[self.subjectMark])")
            }
        } catch{
            print(error)
        }
    }
    
    
    @IBAction func updateMarks(_ sender: UIButton) {

        let alert = UIAlertController(title: "Mettre à jour la note", message: nil, preferredStyle: .alert)
        alert.addTextField { (tf) in tf.placeholder = "User ID" }
        alert.addTextField { (tf) in tf.placeholder = "Code de l'UV" }
        alert.addTextField { (tf) in tf.placeholder = "La note sur 20" }
        let action = UIAlertAction(title: "Submit", style: .default) { (_) in
            guard let markIdString = alert.textFields?.first?.text,
                let markId = Int(markIdString),
                let subjectCode = alert.textFields![1].text,
                let subjectMark = alert.textFields?.last?.text
                else { return }
            print(markIdString)
            print(subjectCode)
            print(subjectMark)
            let marks = self.marksTable.filter(self.id == markId)
            let updateMark = marks.update(self.subjectCode <- subjectCode, self.subjectMark <- subjectMark)
            
            do {
                try self.database.run(updateMark)
            } catch {
                print(error)
            }
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func deleteMark(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Supprimer la note", message: nil, preferredStyle: .alert)
        alert.addTextField { (tf) in tf.placeholder = "L'ID de la note" }
        let action = UIAlertAction(title: "Supprimer", style: .default) { (_) in
            guard let markIdString = alert.textFields?.first?.text,
                let markId = Int(markIdString)
                else { return }
            print(markIdString)
            
            let mark = self.marksTable.filter(self.id == markId)
            let deleteMark = mark.delete()
            do {
                try self.database.run(deleteMark)
            } catch {
                print(error)
            }
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


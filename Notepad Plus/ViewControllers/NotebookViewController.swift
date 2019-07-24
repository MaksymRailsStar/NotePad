//
//  NotebookViewController.swift
//  Notepad
//
//  Created by Vipul Pipaliya on April/9/2019.
//  Copyright © 2019 Vipul Pipaliya. All rights reserved.
//

import UIKit
import CoreData

class NotebookViewController: UIViewController,UITextViewDelegate {

    @IBOutlet var vw_HeaderView : UIView!
    @IBOutlet var lbl_CreatedDate : UILabel!
    @IBOutlet var lbl_ModifyDate : UILabel!
    @IBOutlet var vw_UnderLine : UILabel!
    @IBOutlet var txt_editTextView : UITextView!
    @IBOutlet var txt_HeaderField: UITextField!
    
    var noteObject : NoteDataObject!
    var noteIndex: Int!
    let isNoteEdited : Bool = false
    var nsFetchController : NSFetchedResultsController<NSFetchRequestResult>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUIs()
//        let uId = self.generateNextID()
//        print(uId)
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.txt_editTextView.becomeFirstResponder()
    }
    
    func setupUIs() {
        self.txt_editTextView.delegate = self
        self.vw_HeaderView.backgroundColor = themeColor
        self.vw_UnderLine.backgroundColor = themeColor
        //Date
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        let nCreatedDate = formatter.string(from: date)
        self.lbl_CreatedDate.text = nCreatedDate
        self.lbl_ModifyDate.text = nCreatedDate
        if isEditing == true {
            self.lbl_CreatedDate.text = self.noteObject.NoteCreatedDate!
            self.lbl_ModifyDate.text = self.noteObject.NoteModiDate!
            self.txt_HeaderField.text = self.noteObject.NoteTitle!
            self.txt_editTextView.text = self.noteObject.NoteDescription!
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        print("changes")
        let string = textView.text!
        let spaceCount = string.components(separatedBy: " ")
        //print(spaceCount.count - 1)
        
        if spaceCount.count <= 3 {
            if isNoteEdited == false {
                let allText = textView.text!
                self.txt_HeaderField.text = allText
            }
        }
        //string.characters.filter{$0 == " "}.count
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("Begin editing")
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        print("End editing")
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    func saveNote(noteTitle: String,noteDesc: String, notePubDate: String, noteModiDate: String, noteDay: String, noteMonth: String, noteYear: String)
    {
        let noteId = self.generateNextID("noteID", forEntityName: "Notepad_Plus")
        
        //let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Notepad_Plus", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        // Add Record
        newUser.setValue("\(noteId)", forKey: "noteID")
        newUser.setValue(noteTitle, forKey: "noteTitle")
        newUser.setValue(noteDesc, forKey: "noteDesc")
        newUser.setValue(noteModiDate, forKey: "noteModiDate")
        newUser.setValue(notePubDate, forKey: "notePubDate")
        newUser.setValue(noteDay, forKey: "noteDay")
        newUser.setValue(noteMonth, forKey: "noteMonth")
        newUser.setValue(noteYear, forKey: "noteYear")
        
        //Save
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    func generateNextID(_ idKey: String, forEntityName entityName: String) -> Int {
       // let idKey = "noteID"
        
        //let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.propertiesToFetch = [idKey]
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: idKey, ascending: true)]
        
        do {
            let results = try context.fetch(fetchRequest)
            let lastObject = (results as! [NSManagedObject]).last
            
            guard lastObject != nil else {
                //print("1")
                return 1
            }
            let lastID = lastObject?.value(forKey: idKey) as! String
            return Int(lastID)! + 1
            
        } catch let error as NSError {
            //handle error
        }
        return 1
       
    }
    func editNote(noteTitle: String,noteDesc: String, notePubDate: String, noteModiDate: String, noteDay: String, noteMonth: String, noteYear: String)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Notepad_Plus")
        fetchRequest.predicate = NSPredicate(format: "noteID = %@", self.noteObject.NoteID)
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            if test.count != 0 {
                let objectUpdate = test[0] as! NSManagedObject
                
                objectUpdate.setValue(self.noteObject.NoteID, forKey: "noteID")
                objectUpdate.setValue(noteTitle, forKey: "noteTitle")
                objectUpdate.setValue(noteDesc, forKey: "noteDesc")
                objectUpdate.setValue(noteModiDate, forKey: "noteModiDate")
                objectUpdate.setValue(notePubDate, forKey: "notePubDate")
                objectUpdate.setValue(noteDay, forKey: "noteDay")
                objectUpdate.setValue(noteMonth, forKey: "noteMonth")
                objectUpdate.setValue(noteYear, forKey: "noteYear")
                
                //managedContext.delete(objectToDelete)
                
                do{
                    try managedContext.save()
                }
                catch
                {
                    print(error)
                }
            }
        }
        catch
        {
            print(error)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onClickBack(_ sender: UIButton) {
        print(sender.tag)
        let nTitle = self.txt_HeaderField.text!
        let nDesc = self.txt_editTextView.text!
        //Current date
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        let nCreatedDate = formatter.string(from: date)
        //
        let formatter1 = DateFormatter()
        formatter1.setLocalizedDateFormatFromTemplate("MMM")
        let month = formatter1.string(from: date)
        
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        //let month = calendar.shortMonthSymbols
        let year = calendar.component(.year, from: date)
        
        if isEditing == false {
            self.saveNote(noteTitle: nTitle, noteDesc: nDesc, notePubDate: nCreatedDate, noteModiDate: nCreatedDate, noteDay: "\(day)", noteMonth: "\(month)", noteYear: "\(year)")
        } else {
            self.editNote(noteTitle: nTitle, noteDesc: nDesc, notePubDate: self.noteObject.NoteCreatedDate!, noteModiDate: nCreatedDate, noteDay: "\(self.noteObject.NoteDay!)", noteMonth: "\(self.noteObject.NoteMonth!)", noteYear: "\(self.noteObject.NoteYear!)")
        }
        
        self.navigationController?.popViewController(animated: true)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NotiRefreshTable"), object: nil)
        
    }

}

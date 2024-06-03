//
//  NotesViewController.swift
//  Drop-a-Note
//
//  Created by Balint Dombovari on 2022. 11. 09..
//

import UIKit
import CoreData
import WidgetKit
class NotesTableViewController: UITableViewController {

    //MARK: Properties
    var day: Days!
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var note: [Notes]?
    var goal: Double = 0.0
    let dateFormatter = DateFormatter()
    let numberFormatter = NumberFormatter()
    let fetchRequest: NSFetchRequest<Notes> = Notes.fetchRequest()
    let userDefaults = UserDefaults(suiteName: "group.widgetdatasend")
    let userDefaults2 = UserDefaults(suiteName: "group.settingsdata")
    var stringarray: [String] = ["","","","","","","","","","","","","" ]
    var language: Int = 0
    var measure: Int = 0
    var today = Date()
    let bluecolor = UIColor(red: 119/255, green: 182/255, blue: 255/255, alpha: 1.0)
    let magentacolor = UIColor(red: 254/255, green: 90/255, blue: 131/255, alpha: 1.0)
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        dateFormatter.dateFormat = "Y.MM.dd"
        navigationItem.title = dateFormatter.string(from: self.day.day!)
        
        //Fetch
        
        let predicate = NSPredicate(format: "%K == %@", #keyPath(Notes.day), day)
        fetchRequest.predicate = predicate
        fetchNotes()
        set()
        //ProgressView setup
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 1)
        if round(self.day.consumption * 10) / 10.0 >= round(self.goal * 10) / 10.0{
            self.progressView.setProgress(Float(self.goal), animated: true)
            self.progressView.progressTintColor = self.magentacolor
        }
        else{
            let progress: Float = Float(self.day.consumption)/Float(self.goal)
            self.progressView.setProgress(progress, animated: true)
             }
    }
 
    //MARK: Functions
    func fetchNotes(){
        do{
            self.note = try context.fetch(fetchRequest)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
        }
        }
        catch{
            print(error.localizedDescription)
        }
    }
    func set(){
        goal = userDefaults2?.value(forKey: "PickerData") as? Double ?? 1.0
        print(goal)
        measure = userDefaults2?.value(forKey: "Measure") as? Int ?? 0
        language = userDefaults2?.value(forKey: "Language") as? Int ?? 0
        switch language{
        case 0:
            stringarray[0] = "New Note!"
            stringarray[1] = "Give the type of your drink!"
            stringarray[2] = "Press OK to water!"
            stringarray[3] = "Give an amount!"
            stringarray[4] = "Cancel"
            stringarray[5] = "Deciliter"
            stringarray[6] = "You must give an amount!"
            stringarray[7] = "Water"
            stringarray[8] = "Oops!"
            stringarray[9] = "There was an issue during saving!"
            stringarray[10] = "Delete"
            stringarray[11] = "There was an issue during deleting!"
            stringarray[12] = "Add"
        case 1:
            stringarray[0] = "Új jegyzet!"
            stringarray[1] = "Add meg az italod típusát!"
            stringarray[2] = "Víz esetén OK gomb"
            stringarray[3] = "Adj meg egy mennyiséget!"
            stringarray[4] = "Mégsem"
            stringarray[5] = "Deciliter"
            stringarray[6] = "Valós értéket adj meg!"
            stringarray[7] = "Víz"
            stringarray[8] = "Hoppá!"
            stringarray[9] = "Probléma adódott mentés közben!"
            stringarray[10] = "Törlés"
            stringarray[11] = "Probléma adódott törlés közben!"
            stringarray[12] = "Hozzá ad"
        case 2:
            stringarray[0] = "Neue Notiz!"
            stringarray[1] = "Gib den Typ deines Getränk!"
            stringarray[2] = "Drücke OK im Fall von Wasser!"
            stringarray[3] = "Gib eine Quantität!"
            stringarray[4] = "Abbrechen"
            stringarray[5] = "Deziliter"
            stringarray[6] = "Gib reale Quantität!"
            stringarray[7] = "Wasser"
            stringarray[8] = "Hoppla!"
            stringarray[9] = "Es gab ein Problem unter der Sicherung!"
            stringarray[10] = "Löschen"
            stringarray[11] = "Es gab ein Problem unter dem Löschen!"
            stringarray[12] = "Hinzufügen"
        default:
            stringarray[0] = "New Note!"
            stringarray[1] = "Give the type of your drink!"
            stringarray[2] = "Press OK to water!"
            stringarray[3] = "Give an amount!"
            stringarray[4] = "Cancel"
            stringarray[5] = "Deciliter"
            stringarray[6] = "You must give an amount!"
            stringarray[7] = "Water"
            stringarray[8] = "Oops!"
            stringarray[9] = "There was an issue during saving!"
            stringarray[10] = "Delete"
            stringarray[11] = "There was an issue during deleting!"
            stringarray[12] = "Add"
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchNotes()
        set()
        
    }
    //MARK: Outlets-Actions
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBAction func barButtonTouchUpInside(_ sender: Any) {
        //Folyadék típusának feljegyzése
        let newnoteType = UIAlertController(title: "\(self.stringarray[0])", message: "\(self.stringarray[1])", preferredStyle: .alert)
        newnoteType.view.tintColor = bluecolor
        newnoteType.addTextField()
        
        let textField1 = newnoteType.textFields![0]
        textField1.placeholder = "\(self.stringarray[2])"
        
        //Folyadék mennyiség feljegyzése
        let newnote = UIAlertController(title: "\(self.stringarray[3])", message: "", preferredStyle: .alert)
        newnote.view.tintColor = bluecolor
        newnote.addTextField()
        
        let textField2 = newnote.textFields![0]
        textField2.keyboardType = UIKeyboardType.decimalPad
        textField2.placeholder = stringarray[5]
        //CancelButton
        let cancelAction = UIAlertAction(title: "\(self.stringarray[4])", style: .cancel, handler: nil)
        cancelAction.setValue(magentacolor, forKey: "titleTextColor")
        newnoteType.addAction(cancelAction)
        newnote.addAction(cancelAction)
        
        //OKButton
        let submitButton = UIAlertAction(title: "OK", style: .default){ (action) in
            if self.measure == 0{
                
                let submitButton2 = UIAlertAction(title: "\(self.stringarray[12])", style: .default){ (action) in
                    
                    let amount = self.numberFormatter.number(from: textField2.text!)?.doubleValue
                    
                    //Amount check
                    if amount == nil{
                        let error = UIAlertController(title: "\(self.stringarray[6])", message: "", preferredStyle: .alert)
                        
                        let submitButton = UIAlertAction(title: "OK", style: .default){_ in
                            self.present(newnote,animated: true,completion: nil)
                            
                        }
                        submitButton.setValue(self.bluecolor, forKey: "titleTextColor")
                        error.addAction(submitButton)
                        self.present(error,animated: true,completion: nil)
                    }
                    else{
                        //NewNote setup
                        let newNote = Notes(context: self.context)
                        newNote.quantity = amount! / 10.0
                        newNote.measure = self.userDefaults2?.value(forKey: "Measure") as? Int ?? 0
                        self.day.consumption += amount! / 10.0
                        //Widget átadás
                        if self.dateFormatter.string(from: self.day.day!) == self.dateFormatter.string(from: self.today)
                        {
                            self.userDefaults?.set(self.day.consumption, forKey: "self.day.consumption")
                            
                            WidgetCenter.shared.reloadAllTimelines()
                        }
                    
                        if textField1.text == ""{
                            newNote.drink = "\(self.stringarray[7])"
                        }
                        else{
                        newNote.drink = textField1.text
                             }
                        newNote.day = self.day
                        
                        //ProgressView update
                        if round(self.day.consumption * 10) / 10.0 >= round(self.goal * 10) / 10.0{
                            self.progressView.setProgress(Float(self.goal), animated: true)
                            self.progressView.progressTintColor = self.magentacolor
                        }
                        else{
                            let progress: Float = Float(self.day.consumption)/Float(self.goal)
                            self.progressView.setProgress(progress, animated: true)
                            
                        }
                        
                        //Save
                        do{
                            try  self.context.save()
                        }
                        catch{
                            print(error.localizedDescription)
                            let error = UIAlertController(title: "\(self.stringarray[8])", message: "\(self.stringarray[9])", preferredStyle: .alert)
                            let submitButton3 = UIAlertAction(title: "OK", style: .default)
                            submitButton3.setValue(self.bluecolor, forKey: "titleTextColor")
                            error.addAction(submitButton3)
                            self.present(error,animated: true,completion: nil)
                        }
                        
                        //Fetch
                        self.fetchNotes()
                        
                         }
                     }
                newnote.addAction(submitButton2)
                self.present(newnote,animated: true,completion: nil)
            }//if end
            else{
                if self.measure == 1{
                    
                    textField2.placeholder = "Oz (uk)"
                }
                else{
                    textField2.placeholder = "Oz (us)"
                }
                let submitButton4 = UIAlertAction(title: self.stringarray[12], style: .default){ (action) in
                    
                    let amount = self.numberFormatter.number(from: textField2.text!)?.doubleValue
                    
                    // Amount check
                    if amount == nil{
                        let error = UIAlertController(title: "\(self.stringarray[6])", message: "", preferredStyle: .alert)
                        let submitButton = UIAlertAction(title: "OK", style: .default){_ in
                            self.present(newnote,animated: true,completion: nil)
                        }
                        submitButton.setValue(self.bluecolor, forKey: "titleTextColor")
                        error.addAction(submitButton)
                        self.present(error,animated: true,completion: nil)
                    }
                    else{
                        //NewNote setup
                        let newNote = Notes(context: self.context)
                        newNote.quantity = amount!
                        newNote.measure = self.userDefaults2?.value(forKey: "Measure") as? Int ?? 0
                        self.day.consumption += amount!
                        
                        //Widget átadás
                        if self.dateFormatter.string(from: self.day.day!) == self.dateFormatter.string(from: self.today){
                            self.userDefaults?.set(self.day.consumption, forKey: "self.day.consumption")
                            
                            WidgetCenter.shared.reloadAllTimelines()
                        }
                        
                        if textField1.text == ""{
                            newNote.drink = "\(self.stringarray[7])"
                        }
                        else{
                        newNote.drink = textField1.text
                             }
                        newNote.day = self.day
                        
                        //ProgressView update
                        if round(self.day.consumption * 10) / 10.0 >= round(self.goal * 10) / 10.0{
                            self.progressView.setProgress(Float(self.goal), animated: true)
                            self.progressView.progressTintColor = self.magentacolor
                        }
                        else{
                            let progress: Float = Float(self.day.consumption)/Float(self.goal)
                            self.progressView.setProgress(progress, animated: true)
                            
                        }
                        
                        //Save
                        do{
                            try  self.context.save()
                        }
                        catch{
                            print(error.localizedDescription)
                            let error = UIAlertController(title: "\(self.stringarray[8])", message: "\(self.stringarray[9])", preferredStyle: .alert)
                            let submitButton3 = UIAlertAction(title: "OK", style: .default)
                            submitButton3.setValue(self.bluecolor, forKey: "titleTextColor")
                            error.addAction(submitButton3)
                            self.present(error,animated: true,completion: nil)
                        }
                        
                        //Fetch
                        self.fetchNotes()
                        
                    }
                     }
                newnote.addAction(submitButton4)
                self.present(newnote,animated: true,completion: nil)
                }
            }
        newnoteType.addAction(submitButton)
        self.present(newnoteType,animated: true,completion: nil)
        
    }
    //MARK: TableView Functions
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.note!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        let newnote = self.note![indexPath.row]
        cell.textLabel?.text = newnote.drink
        switch measure{
        case 0:
            cell.detailTextLabel?.text = "\(String(format: "%.1f", newnote.quantity)) liter"
        case 1:
            cell.detailTextLabel?.text = "\(String(format: "%.1f", newnote.quantity)) Oz (uk)"
        case 2:
            cell.detailTextLabel?.text = "\(String(format: "%.1f", newnote.quantity)) Oz (us)"
        default:
            cell.detailTextLabel?.text = "\(String(format: "%.1f",newnote.quantity)) liter"
        }
        return cell
    }
    
    //Törlés funkció
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "\(self.stringarray[10])"){
            (action, view, comletionHandler) in
            let notebookToRemove = self.note![indexPath.row]
            
            //Consumption update
            self.day.consumption -= notebookToRemove.quantity
            //Widget átadás
            if self.dateFormatter.string(from: self.day.day!) == self.dateFormatter.string(from: self.today){
                self.userDefaults?.set(self.day.consumption, forKey: "self.day.consumption")
                WidgetCenter.shared.reloadAllTimelines()
            }
            //ProgressView update
            if round(self.day.consumption * 10) / 10.0 >= round(self.goal * 10) / 10.0{
                self.progressView.setProgress(Float(self.goal), animated: true)
                self.progressView.progressTintColor = self.magentacolor
            }
            else{
                let progress: Float = Float(self.day.consumption)/Float(self.goal)
                self.progressView.setProgress(progress, animated: true)
                self.progressView.progressTintColor = self.bluecolor
            }
            //Delete
            self.context.delete(notebookToRemove)
            
            //Save
            do{
               try self.context.save()
                 }
            catch{
                print(error.localizedDescription)
                let error = UIAlertController(title: "\(self.stringarray[8])", message: "\(self.stringarray[11])", preferredStyle: .alert)
                let submitButton = UIAlertAction(title: "OK", style: .default)
                submitButton.setValue(self.bluecolor, forKey: "titleTextColor")
                error.addAction(submitButton)
                self.present(error,animated: true,completion: nil)
            }
            
            //Fetch
            self.fetchNotes()
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
}

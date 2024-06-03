//
//  DaysTableViewController.swift
//  Drop-a-Note
//
//  Created by Balint Dombovari on 2022. 11. 09..
//

import UIKit
import CoreData
import WidgetKit
class DaysTableViewController: UITableViewController {
    //ManagedObjectContext elérése
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest: NSFetchRequest<Days> = Days.fetchRequest()
    var items: [Days]?
    var sectionDays: [Int: Date] = [0 : Date(timeIntervalSinceReferenceDate: 0)]
    var rowsinsections: [Int: Int] = [0 : 0]
    let dateFormatter = DateFormatter()
    let dateFormatter2 = DateFormatter()
    let dateFormatter3 = DateFormatter()
    let userDefaults = UserDefaults(suiteName: "group.settingsdata")
    let userDefaults2 = UserDefaults(suiteName: "group.widgetdatasend")
    var measure: Int = 0
    var language: Int = 0
    var stringarray: [String] = ["","","","","","",""]
    var months: [String] = ["","","","","","","","","","","","" ]
    let bluecolor = UIColor(red: 119/255, green: 182/255, blue: 255/255, alpha: 1.0)
    let magentacolor = UIColor(red: 254/255, green: 90/255, blue: 131/255, alpha: 1.0)
    override func viewDidLoad() {
        super.viewDidLoad()
        set()
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.backgroundView = UIImageView(image: UIImage(named: "Image3"))
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Days.day), ascending: false)
          fetchRequest.sortDescriptors = [sortDescriptor]
        fetchDays()
        sectionDaysfill()
        
    }
    
    func fetchDays(){
        do{
            self.items = try context.fetch(fetchRequest)
           
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
           
             }
        catch{
            print(error.localizedDescription)
        }
    }
      //MARK: Functions
    func set(){
        language = userDefaults?.value(forKey: "Language") as? Int ?? 0
        measure = userDefaults?.value(forKey: "Measure") as? Int ?? 0
        switch language{
        case 0:
            navigationItem.title = "Daily Consumption"
            stringarray[0] = "New day, new challenge!"
            stringarray[1] = "Oops!"
            stringarray[2] = "There was an issue during saving!"
            stringarray[3] = "You can create\nonly one notebook per day!"
            stringarray[4] = "Delete"
            stringarray[5] = "There was an issue during deleting!"
            stringarray[6] = "Back"
            self.dateFormatter.dateFormat = "dd.MM.Y"
            months[0] = "January"
            months[1] = "February"
            months[2] = "March"
            months[3] = "April"
            months[4] = "May"
            months[5] = "June"
            months[6] = "July"
            months[7] = "August"
            months[8] = "September"
            months[9] = "October"
            months[10] = "November"
            months[11] = "December"
        case 1:
            navigationItem.title = "Napi folyadékbevitel"
            stringarray[0] = "Új nap, új kihívás!"
            stringarray[1] = "Hoppá!"
            stringarray[2] = "Probléma adódott mentés közben!"
            stringarray[3] = "Egy jegyzettömböt\nkészíthetsz naponta!"
            stringarray[4] = "Törlés"
            stringarray[5] = "Probléma adódott törlés közben!"
            stringarray[6] = "Vissza"
            self.dateFormatter.dateFormat = "Y.MM.dd"
            months[0] = "Január"
            months[1] = "Február"
            months[2] = "Március"
            months[3] = "Április"
            months[4] = "Május"
            months[5] = "Június"
            months[6] = "Július"
            months[7] = "Augusztus"
            months[8] = "Szeptember"
            months[9] = "Október"
            months[10] = "November"
            months[11] = "December"
        case 2:
            navigationItem.title = "Täglicher Flüßigkeitverbrauch"
            stringarray[0] = "Neuer Tag,\nneue Herausforderung!"
            stringarray[1] = "Hoppla!"
            stringarray[2] = "Es gab ein Problem unter der Sicherung!"
            stringarray[3] = "Du kannst nur\neins Notizbuch täglich machen!"
            stringarray[4] = "Löschen"
            stringarray[5] = "Es gab ein Problem unter dem Löschen!"
            stringarray[6] = "Zurück"
            self.dateFormatter.dateFormat = "dd.MM.Y"
            months[0] = "Januar"
            months[1] = "Februar"
            months[2] = "März"
            months[3] = "April"
            months[4] = "Mai"
            months[5] = "Juni"
            months[6] = "Juli"
            months[7] = "August"
            months[8] = "September"
            months[9] = "Oktober"
            months[10] = "November"
            months[11] = "Dezember"
        default:
            navigationItem.title = "Daily Consumption"
            stringarray[0] = "New day, new challenge!"
            stringarray[1] = "Oops!"
            stringarray[2] = "There was an issue during saving!"
            stringarray[3] = "You can create\nonly one notebook per day!"
            stringarray[4] = "Delete"
            stringarray[5] = "There was an issue during deleting!"
            stringarray[6] = "Back"
            self.dateFormatter.dateFormat = "dd.MM.Y"
            months[0] = "January"
            months[1] = "February"
            months[2] = "March"
            months[3] = "April"
            months[4] = "May"
            months[5] = "June"
            months[6] = "July"
            months[7] = "August"
            months[8] = "September"
            months[9] = "October"
            months[10] = "November"
            months[11] = "December"
        }
        if measure == 2{
            self.dateFormatter.dateFormat = "MM.dd.Y"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchDays()
        set()
        
    }
    @IBAction func addButtonTouchUpInside(_ sender: Any) {
            var firstNote:Bool = true
            self.dateFormatter2.dateFormat = "YYYY.MMMM"
            let today:Date = Date()
            for a in self.items! {
                if self.dateFormatter.string(from: a.day!) == self.dateFormatter.string(from: today) {
                    firstNote = false
                }
            }
            if firstNote == true{
                self.newSection()
            let newDay = Days(context: self.context)
            newDay.day = Date()
            newDay.consumption = 0.0
            newDay.measure = self.userDefaults?.value(forKey: "Measure") as? Int ?? 0
                //Widget
                self.userDefaults2?.set(newDay.consumption, forKey: "self.day.consumption")
                WidgetCenter.shared.reloadAllTimelines()
            //Mentés
            do{
                try  self.context.save()
            }
            catch{
                print(error.localizedDescription)
                let error = UIAlertController(title: "\(self.stringarray[1])", message: "\(self.stringarray[2])", preferredStyle: .alert)
                let submitButton2 = UIAlertAction(title: "OK", style: .default)
                submitButton2.setValue(self.bluecolor, forKey: "titleTextColor")
                error.addAction(submitButton2)
                self.present(error,animated: true,completion: nil)
            }
            //TableView frissítése
            self.fetchDays()
            }
            else{
                let error = UIAlertController(title: "\(self.stringarray[1])", message: "\(self.stringarray[3])", preferredStyle: .actionSheet)
                let submitButton2 = UIAlertAction(title: "OK", style: .default)
                error.view.tintColor = bluecolor
                error.addAction(submitButton2)
                self.present(error,animated: true,completion: nil)
            }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowNotesSegue"{
            let backItem = UIBarButtonItem()
            backItem.title = self.stringarray[6]
            navigationItem.backBarButtonItem = backItem
            let notesTableViewController = segue.destination as! NotesTableViewController
            let x: Int = tableView.indexPathForSelectedRow!.section
            var y: Int = tableView.indexPathForSelectedRow!.row
            if x != 0{
                y += rowsinsections[x-1]!
            }
            notesTableViewController.day = items![y]
        }
    }
   
    // only with viewDidLoad
    func sectionDaysfill(){
        dateFormatter2.dateFormat = "YYYY.MMMM"
        var index: Int = 0
        var isfirst: Bool = true
            for d in self.items! {
                
                if dateFormatter2.string(from: d.day!) != dateFormatter2.string(from: sectionDays[index]!){
                        
                    if isfirst == true{
                        sectionDays[index] = d.day!
                        isfirst = false
                    }
                    else{
                        index += 1
                        sectionDays[index] =  d.day!
                    }
                }
            }
            
        
        
    }
    
    func newSection(){
        var newsection: Bool = true
        let today: Date = Date()
        fetchDays()
        for b in self.items!{
            if self.dateFormatter2.string(from: b.day!) == self.dateFormatter2.string(from: today){
                newsection = false
            }
        }
        if newsection == true{
           
            var a = self.sectionDays.count
            while a > 0{
                
                self.sectionDays[a] = self.sectionDays[a-1]
                a -= 1
            }
            
            self.sectionDays[0] = today
            self.tableView.reloadData()
    }
}
    // MARK: - Table view data source

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionDays.count
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        self.dateFormatter3.dateFormat = "M"
        self.dateFormatter2.dateFormat = "YYYY"
        switch dateFormatter3.string(from: sectionDays[section]!){
        case "1":
            return "\(dateFormatter2.string(from: sectionDays[section]!)).\(months[0])"
        case "2":
            return "\(dateFormatter2.string(from: sectionDays[section]!)).\(months[1])"
        case "3":
            return "\(dateFormatter2.string(from: sectionDays[section]!)).\(months[2])"
        case "4":
            return "\(dateFormatter2.string(from: sectionDays[section]!)).\(months[3])"
        case "5":
            return "\(dateFormatter2.string(from: sectionDays[section]!)).\(months[4])"
        case "6":
            return "\(dateFormatter2.string(from: sectionDays[section]!)).\(months[5])"
        case "7":
            return "\(dateFormatter2.string(from: sectionDays[section]!)).\(months[6])"
        case "8":
            return "\(dateFormatter2.string(from: sectionDays[section]!)).\(months[7])"
        case "9":
            return "\(dateFormatter2.string(from: sectionDays[section]!)).\(months[8])"
        case "10":
            return "\(dateFormatter2.string(from: sectionDays[section]!)).\(months[9])"
        case "11":
            return "\(dateFormatter2.string(from: sectionDays[section]!)).\(months[10])"
        case "12":
            return "\(dateFormatter2.string(from: sectionDays[section]!)).\(months[11])"
        default:
            return "ERROR"
        }
    }
    //cellák száma
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var sumrows: Int = 0
        self.dateFormatter2.dateFormat = "YYYY.MMMM"
        
        for c in self.items!{
            if dateFormatter2.string(from: sectionDays[section]!) == dateFormatter2.string(from: c.day!){
                sumrows += 1
            }
        }
        rowsinsections[section] = sumrows
        return sumrows
        
    }
    //cella készítés
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DaysCell", for: indexPath)
        let indexsection = indexPath.section
        var indexrow = indexPath.row
        if indexsection != 0 {
            indexrow += rowsinsections[indexsection-1]!
        }
            self.dateFormatter2.dateFormat = "YYYY.MMMM"
            let day = self.items![indexrow]
            ///////
            cell.textLabel?.text = "\(self.dateFormatter.string(from: day.day!)):"
            switch measure{
            case 0:
                cell.detailTextLabel?.text = "\(String(format: "%.1f", day.consumption)) liter"
            case 1:
                cell.detailTextLabel?.text = "\(String(format: "%.0f", day.consumption)) Oz (uk)"
            case 2:
                cell.detailTextLabel?.text = "\(String(format: "%.0f", day.consumption)) Oz (us)"
            default:
                cell.detailTextLabel?.text = "\(String(format: "%.1f", day.consumption)) liter"
            }
         let a = userDefaults?.value(forKey: "PickerData") as? Double ?? 1.0
        if round(day.consumption * 10)/10.0 >= round(a * 10)/10.0{
            cell.imageView?.tintColor = self.magentacolor
            }
            else{
                cell.imageView?.tintColor = self.bluecolor
            
        }
        self.dateFormatter2.dateFormat = "d"
        let imageset: String = self.dateFormatter2.string(from: day.day!)
        cell.imageView?.image = UIImage(systemName: "\(imageset).square")
        return cell
    }
  
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "\(self.stringarray[4])"){
            (action, view, comletionHandler) in
            let indexsection = indexPath.section
            var indexrow = indexPath.row
            if indexsection != 0 {
                indexrow += self.rowsinsections[indexsection-1]!
            }
            let notebookToRemove = self.items![indexrow]
            self.context.delete(notebookToRemove)
            //Widget
            self.userDefaults2?.set(0.0, forKey: "self.day.consumption")
            WidgetCenter.shared.reloadAllTimelines()
            do{
               try self.context.save()
                 }
            catch{
                print(error.localizedDescription)
                let error = UIAlertController(title: "\(self.stringarray[1])", message: "\(self.stringarray[5])", preferredStyle: .alert)
                let submitButton = UIAlertAction(title: "OK", style: .default)
                submitButton.setValue(self.bluecolor, forKey: "titleTextColor")
                error.addAction(submitButton)
                self.present(error,animated: true,completion: nil)
            }
            self.fetchDays()
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
}
public extension String {
    var image: UIImage? { get { return UIImage(named: self) } }
}

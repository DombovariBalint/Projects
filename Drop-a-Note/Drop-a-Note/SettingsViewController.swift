//
//  SettingsViewController.swift
//  Drop-a-Note
//
//  Created by Balint Dombovari on 2023. 01. 08..
//

import UIKit
import WidgetKit
class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
   
    //MARK: Properties
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var days: [Days]?
    var notes: [Notes]?
    let dateFormatter = DateFormatter()
    var pickerDataL: [Double] = []
    var pickerDataUK: [Double] = []
    var pickerDataUS: [Double] = []
    var measureindex: Int = 0
    let userDefaults = UserDefaults(suiteName: "group.settingsdata")
    let userDefaults2 = UserDefaults(suiteName: "group.widgetdatasend")
    var row:Int = 0
    var stringarray: [String] = ["",""]
    //MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "Y.M.d"
        
        //Picker
        self.Picker.delegate = self
        self.Picker.dataSource = self
        pickerDataL = [1.0,1.1,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,
                      2.0,2.1,2.2,2.3,2.4,2.5,2.6,2.7,2.8,2.9,
                      3.0,3.1,3.2,3.3,3.4,3.5,3.6,3.7,3.8,3.9,4.0]
        pickerDataUK = [35,39,42,46,49,53,56,60,63,67,70,74,
                        78,81,85,88,92,95,99,102,106,109,113,
                        116,120,123,127,130,134,137,141]
        pickerDataUS = [34,37,41,44,47,51,54,58,61,64,68,71,75,
                        78,81,85,88,91,95,98,102,105,108,112,115,
                        119,122,125,129,132,136]
        set()
        fetch()
        //Set the View
        MeasureSegmentedControl.selectedSegmentIndex = userDefaults?.value(forKey: "Measure") as? Int ?? 0
        LanguageSegmentedControl.selectedSegmentIndex = userDefaults?.value(forKey: "Language") as? Int ?? 0
        Picker.selectRow(userDefaults?.value(forKey: "Row") as? Int ?? 0, inComponent: 0, animated: true)
        row = userDefaults?.value(forKey: "Row") as? Int ?? 0
        buttonTitleSet.isHidden = true
        
    }
    func fetch(){
        do{
            self.days = try context.fetch(Days.fetchRequest())
            self.notes = try context.fetch(Notes.fetchRequest())
            
             }
        catch{
            print(error.localizedDescription)
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch measureindex{
        case 0:
            return pickerDataL.count
        case 1:
            return pickerDataUK.count
        case 2:
            return pickerDataUS.count
        default:
            return 1
        }
      
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch measureindex{
        case 0:
           
                return String(pickerDataL[row])
        case 1:
            
                return String(pickerDataUK[row])
        case 2:
            
                return String(pickerDataUS[row])
        default:
            return "Error"
        }
       
        }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        buttonTitleSet.isHidden = false
        self.row = row
        self.userDefaults?.set(row, forKey: "Row")
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func set (){
        let selectedMeasure = userDefaults?.value(forKey: "Measure")
        let selectedLanguage = userDefaults?.value(forKey: "Language")
        switch selectedMeasure {
        case 0 as Int:
            measureindex = 0
            
        case 1 as Int:
            measureindex = 1
            
        case 2 as Int:
            measureindex = 2
            
        default:
            measureindex = 0
           
        }
        switch selectedLanguage{
        case 0 as Int:
            MeasureLabel.text = "Measure:"
            LanguageLabel.text = "Language:"
            GoalLabel.text = "Goal:"
            ContactUsLabel.text = "Contact: balint@icloud.com"
            navigationItem.title = "Settings"
            buttonTitleSet.setTitle("Save", for: .normal)
            tabBarItem.title = "Settings"
            stringarray[0] = "Oops!"
            stringarray[1] = "There was an issue during saving!"
        case 1 as Int:
            MeasureLabel.text = "Mértékegység:"
            LanguageLabel.text = "Nyelv:"
            GoalLabel.text = "Cél:"
            ContactUsLabel.text = "Kapcsolat: balint@icloud.com"
            navigationItem.title = "Beállítások"
            buttonTitleSet.setTitle("Mentés", for: .normal)
            tabBarItem.title = "Beállítások"
            stringarray[0] = "Hoppá!"
            stringarray[1] = "Probléma adódott mentés közben!"
        case 2 as Int:
            MeasureLabel.text = "Maßeinheit:"
            LanguageLabel.text = "Sprache:"
            GoalLabel.text = "Ziel:"
            ContactUsLabel.text = "Kontakt: balint@icloud.com"
            navigationItem.title = "Einstellungen"
            buttonTitleSet.setTitle("Sichern", for: .normal)
            tabBarItem.title = "Einstellungen"
            stringarray[0] = "Hoppla!"
            stringarray[1] = "Es gab ein Problem unter der Sicherung!"
        default:
            MeasureLabel.text = "Measure:"
            LanguageLabel.text = "Language:"
            GoalLabel.text = "Goal:"
            ContactUsLabel.text = "Contact: balint@icloud.com"
            navigationItem.title = "Settings"
            buttonTitleSet.setTitle("Save", for: .normal)
            tabBarItem.title = "Settings"
            stringarray[0] = "Oops!"
            stringarray[1] = "There was an issue during saving!"
        }
    }
    // MARK: Outlets
    
    @IBOutlet weak var Logo: UIImageView!
    @IBOutlet weak var Picker: UIPickerView!
    @IBOutlet weak var MeasureSegmentedControl: UISegmentedControl!
    @IBOutlet weak var LanguageSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var ContactUsLabel: UILabel!
    @IBOutlet weak var GoalLabel: UILabel!
    @IBOutlet weak var LanguageLabel: UILabel!
    @IBOutlet weak var MeasureLabel: UILabel!
    @IBOutlet weak var buttonTitleSet: UIButton!
    //MARK: Actions
    @IBAction func saveButton(_ sender: Any) {
            
            self.userDefaults?.set(self.MeasureSegmentedControl.selectedSegmentIndex, forKey: "Measure")
            self.userDefaults?.set(self.LanguageSegmentedControl.selectedSegmentIndex, forKey: "Language")
            switch self.measureindex {
        case 0:
                self.userDefaults?.set(self.pickerDataL[self.row], forKey: "PickerData")
                print(self.pickerDataL[self.row])
        case 1:
                self.userDefaults?.set(self.pickerDataUK[self.row], forKey: "PickerData")
                print(self.pickerDataUK[self.row])
        case 2:
                self.userDefaults?.set(self.pickerDataUS[self.row], forKey: "PickerData")
                print(self.pickerDataUS[self.row])
        default:
                self.userDefaults?.set(self.pickerDataL[self.row], forKey: "PickerData")
                print(self.pickerDataL[self.row])
        }

        //MARK: Conversion
        for a in self.days!{
            
            switch a.measure{
            case 0:
                if self.MeasureSegmentedControl.selectedSegmentIndex-a.measure == 1{
                    a.consumption = round(a.consumption * 35.195)
                    a.measure = 1
                }
                else if self.MeasureSegmentedControl.selectedSegmentIndex-a.measure == 2{
                    a.consumption = round(a.consumption * 33.814)
                    a.measure = 2
                }
            case 1:
                if self.MeasureSegmentedControl.selectedSegmentIndex-a.measure == -1{
                    a.consumption = round(a.consumption * (1/35.195))
                    a.measure = 0
                }
                else if self.MeasureSegmentedControl.selectedSegmentIndex-a.measure == 1{
                    a.consumption = round(a.consumption * (33.814/35.195))
                    a.measure = 2
                }
            case 2:
                if self.MeasureSegmentedControl.selectedSegmentIndex-a.measure == -1{
                    a.consumption = round(a.consumption * (35.195/33.814))
                    a.measure = 1
                }
                else if self.MeasureSegmentedControl.selectedSegmentIndex-a.measure == -2{
                    a.consumption = round(a.consumption * (1/33.814))
                    a.measure = 0
                }
            default:
                if self.MeasureSegmentedControl.selectedSegmentIndex-a.measure == 1{
                    a.consumption = a.consumption
                }
                else if self.MeasureSegmentedControl.selectedSegmentIndex-a.measure == 2{
                    a.consumption = a.consumption
                }
            }
            /////////////
            if self.dateFormatter.string(from: Date()) == self.dateFormatter.string(from: a.day!){
                self.userDefaults2?.set(a.consumption, forKey: "self.day.consumption")
            }
        }
        for b in self.notes!{
            switch b.measure{
            case 0:
                if self.MeasureSegmentedControl.selectedSegmentIndex-b.measure == 1{
                    b.quantity = round(b.quantity * 35.195)
                    b.measure = 1
                }
                else if self.MeasureSegmentedControl.selectedSegmentIndex-b.measure == 2{
                    b.quantity = round(b.quantity * 33.814)
                    b.measure = 2
                }
            case 1:
                if self.MeasureSegmentedControl.selectedSegmentIndex-b.measure == -1{
                    b.quantity = round(b.quantity * (1/35.195))
                    b.measure = 0
                }
                else if self.MeasureSegmentedControl.selectedSegmentIndex-b.measure == 1{
                    b.quantity = round(b.quantity * (33.814/35.195))
                    b.measure = 2
                }
            case 2:
                if self.MeasureSegmentedControl.selectedSegmentIndex-b.measure == -1{
                    b.quantity = round(b.quantity * (35.195/33.814))
                    b.measure = 1
                }
                else if self.MeasureSegmentedControl.selectedSegmentIndex-b.measure == -2{
                    b.quantity = round(b.quantity * (1/33.814))
                    b.measure = 0
                }
            default:
                if self.MeasureSegmentedControl.selectedSegmentIndex-b.measure == 1{
                    b.quantity = b.quantity
                }
                else if self.MeasureSegmentedControl.selectedSegmentIndex-b.measure == 2{
                    b.quantity = b.quantity
                }
            }
        }
        //Save Conversion
        do{
           try self.context.save()
             }
        catch{
            print(error.localizedDescription)
            let error = UIAlertController(title: "\(self.stringarray[0])", message: "\(self.stringarray[1])", preferredStyle: .alert)
            let submitButton = UIAlertAction(title: "OK", style: .default)
            error.addAction(submitButton)
            self.present(error,animated: true,completion: nil)
        }
        WidgetCenter.shared.reloadAllTimelines()
        self.buttonTitleSet.isHidden = true
        
    }
    @IBAction func MeasureValueChanged(_ sender: Any) {
        buttonTitleSet.isHidden = false
        switch MeasureSegmentedControl.selectedSegmentIndex {
            case 0 :
                measureindex = 0
            case 1 :
                measureindex = 1
            case 2 :
                measureindex = 2
            default:
                measureindex = 0
        }
        self.Picker.reloadAllComponents()
        
    }
    @IBAction func LanguageValueChanged(_ sender: Any) {
        buttonTitleSet.isHidden = false
        switch LanguageSegmentedControl.selectedSegmentIndex{
        case 0:
            MeasureLabel.text = "Measure:"
            LanguageLabel.text = "Language:"
            GoalLabel.text = "Goal:"
            ContactUsLabel.text = "Contact us: balint@icloud.com"
            navigationItem.title = "Settings"
            buttonTitleSet.setTitle("Save", for: .normal)
            self.tabBarItem.title = "Settings"
        case 1:
            MeasureLabel.text = "Mértékegység:"
            LanguageLabel.text = "Nyelv:"
            GoalLabel.text = "Cél:"
            ContactUsLabel.text = "Kapcsolat: balint@icloud.com"
            navigationItem.title = "Beállítások"
            buttonTitleSet.setTitle("Mentés", for: .normal)
            self.tabBarItem.title = "Beállítások"
        case 2:
            MeasureLabel.text = "Maßeinheit:"
            LanguageLabel.text = "Sprache:"
            GoalLabel.text = "Ziel:"
            ContactUsLabel.text = "Kontakt: balint@icloud.com"
            navigationItem.title = "Einstellungen"
            buttonTitleSet.setTitle("Sichern", for: .normal)
            self.tabBarItem.title = "Einstellungen"
        default:
            MeasureLabel.text = "Measure:"
            LanguageLabel.text = "Language:"
            GoalLabel.text = "Goal:"
            ContactUsLabel.text = "Contact us: balint@icloud.com"
            navigationItem.title = "Settings"
            buttonTitleSet.setTitle("Save", for: .normal)
            self.tabBarItem.title = "Settings"
        }
        
    }
         
}

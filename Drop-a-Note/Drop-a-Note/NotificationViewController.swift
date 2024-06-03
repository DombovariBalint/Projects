//
//  NotificationViewController.swift
//  Drop-a-Note
//
//  Created by Balint Dombovari on 2022. 11. 07..
//

import UIKit
import UserNotifications
import CoreData
class NotificationViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    //MARK: Properties
    var notif: NOTIFICATION!
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
     let notifClass = NotificationsTableViewController()
    let notificationCenter = UNUserNotificationCenter.current()
    var pickerData: [Int] = []
    var notifiIndex: Int!
    let userDefaults = UserDefaults(suiteName: "group.settingsdata")
    var stringarry: [String] = ["","","","","","","","",""]
    var language: Int = 0
    var row: Int = 0
    let bluecolor = UIColor(red: 119/255, green: 182/255, blue: 255/255, alpha: 1.0)
    //MARK: Actions
    @IBAction func backgroundTouchUpInside(_ sender: Any) {
        view.endEditing(true)
    }
    @IBAction func setButton(_ sender: Any) {

        if textField1.text != ""{
            notif.title = textField1.text
        }
        else{
            notif.title = nil
        }
        notif.notificationindex = String(notifiIndex)
        print(String(notifiIndex))
        let index = segmentedControl.selectedSegmentIndex
        switch index{
        case 0:
            notif.type = 60
        case 1:
            notif.type = 3600
        case 2:
            notif.type = 24*3600
        default:
            notif.type = 1
        }
        notif.time = pickerData[row]
        notif.ison = true
        do{
            try  self.context.save()
        }
        catch{
            print(error.localizedDescription)
            let error = UIAlertController(title: "\(self.stringarry[0])", message: "\(self.stringarry[1])", preferredStyle: .alert)
            let submitButton2 = UIAlertAction(title: "OK", style: .default)
            submitButton2.setValue(self.bluecolor, forKey: "titleTextColor")
            error.addAction(submitButton2)
            self.present(error,animated: true,completion: nil)
        }
        
        self.notificationCenter.getNotificationSettings { settings in
                            DispatchQueue.main.async {
                if settings.authorizationStatus == .authorized {
                    
                    let content = UNMutableNotificationContent()
                    content.title = "\(self.stringarry[2])"
                    if self.notif.title != nil{
                        content.body = self.notif.title!
                    }
                    else{
                        content.body = "\(self.stringarry[3])"
                    }
                    content.sound = UNNotificationSound(named: UNNotificationSoundName("water.wav"))
                    
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: (Double(self.notif.time)) * Double(self.notif.type) , repeats:true)
                    let request = UNNotificationRequest(identifier: self.notif.notificationindex!, content: content, trigger: trigger)
                    
                    self.notificationCenter.add(request){ (error) in
                        if error != nil{
                            print("Error" + error.debugDescription)
                            return
                        }
                    }
                }
                else{
                    let ac = UIAlertController(title: "\(self.stringarry[4])", message: "\(self.stringarry[5])", preferredStyle: .alert)
                    let goToSettings = UIAlertAction(title: "OK", style: .default){
                        (_) in
                        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString)
                        else{
                            return
                        }
                        if(UIApplication.shared.canOpenURL(settingsUrl)){
                            
                            UIApplication.shared.open(settingsUrl)
                        }
                    }
                    goToSettings.setValue(self.bluecolor, forKey: "titleTextColor")
                    ac.addAction(goToSettings)
                    ac.addAction(UIAlertAction(title: "\(self.stringarry[6])", style: .default))
                    self.present(ac, animated: true)
                }
            }
        }
        textField1.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
       
     }
    @IBAction func cancelButton(_ sender: Any) {
        self.context.delete(notif)
        do{
           try self.context.save()
             }
        catch{
            print(error.localizedDescription)
            let error = UIAlertController(title: "\(self.stringarry[0])", message: "\(self.stringarry[7])", preferredStyle: .alert)
            let submitButton = UIAlertAction(title: "OK", style: .default)
            error.addAction(submitButton)
            self.present(error,animated: true,completion: nil)
        }
        self.dismiss(animated: true, completion: nil)
    }
    //MARK: Outlets
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var dataPicker: UIPickerView!
    
    @IBOutlet weak var buttonTitleSet2: UIButton!
    @IBOutlet weak var buttonTitleSet1: UIButton!
    @IBOutlet weak var constraint1: NSLayoutConstraint!
    //MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textField1.clearButtonMode = .whileEditing
        //dataPicker
        self.dataPicker.delegate = self
        self.dataPicker.dataSource = self
        pickerData = [1,2,3,4,5,6,7,8,9,10,
                      11,12,13,14,15,16,17,18,19,20,
                      21,22,23,24,25,26,27,28,29,30,
                      31,32,33,34,35,36,37,38,39,40,
                      41,42,43,44,45,46,47,48,49,50,
                      51,52,53,54,55,56,57,58,59,60]
        setLanguage()
        //Notification
        notificationCenter.requestAuthorization (options: [.alert, .sound ]) { permissionGranted, error in
            if(!permissionGranted){
                print("Permission denied!")
        }
        }
    }
    func setLanguage(){
        language = userDefaults?.value(forKey: "Language") as? Int ?? 0
        switch language{
        case 0:
            buttonTitleSet1.setTitle("Save", for: .normal)
            buttonTitleSet2.setTitle("Cancel", for: .normal)
            segmentedControl.setTitle("Minute", forSegmentAt: 0)
            segmentedControl.setTitle("Hour", forSegmentAt: 1)
            segmentedControl.setTitle("Day", forSegmentAt: 2)
            textField1.placeholder = "Custom label (opt.)"
            stringarry[0] = "Oops!"
            stringarry[1] = "There was an issue during saving!"
            stringarry[2] = "Hey!"
            stringarry[3] = "You should have a glass of water!"
            stringarry[4] = "Enable Notification"
            stringarry[5] = "To use this feature you must enable notifications in settings"
            stringarry[6] = "Cancel"
            stringarry[7] = "There was an issue during deleting!"
            stringarry[8] = " "
        case 1:
            buttonTitleSet1.setTitle("Mentés", for: .normal)
            buttonTitleSet2.setTitle("Mégsem", for: .normal)
            segmentedControl.setTitle("Perc", forSegmentAt: 0)
            segmentedControl.setTitle("Óra", forSegmentAt: 1)
            segmentedControl.setTitle("Nap", forSegmentAt: 2)
            textField1.placeholder = "Egyedi címke (opc.)"
            stringarry[0] = "Hoppá!"
            stringarry[1] = "Probléma adódott mentés közben!"
            stringarry[2] = "Héj!"
            stringarry[3] = "Igyál egy pohár vízet!"
            stringarry[4] = "Értesítések bekapcsolása"
            stringarry[5] = "A funkció használatához engedélyezned kell az éretsítéseket a beállítsokban!"
            stringarry[6] = "Mégsem"
            stringarry[7] = "Probléma adódott törlés közben!"
            stringarry[8] = " "
        case 2:
            buttonTitleSet1.setTitle("Sichern", for: .normal)
            buttonTitleSet2.setTitle("Abrrechen", for: .normal)
            segmentedControl.setTitle("Minute", forSegmentAt: 0)
            segmentedControl.setTitle("Stunde", forSegmentAt: 1)
            segmentedControl.setTitle("Tag", forSegmentAt: 2)
            textField1.placeholder = "Individuelle Beschreibung (opt.)"
            stringarry[0] = "Hoppla!"
            stringarry[1] = "Es gab ein Problem unter der Sicherung!"
            stringarry[2] = "Hallo!"
            stringarry[3] = "Trink ein Glas Wasser!"
            stringarry[4] = "Mitteilungen erlauben"
            stringarry[5] = "Du musst die Mitteulungen in der Einstellungen er lauben, diese Funktion zu benutzen!"
            stringarry[6] = "Abbrechen"
            stringarry[7] = "Es gab ein Problem unter dem Löschen!"
            stringarry[8] = " "
        default:
            buttonTitleSet1.setTitle("Save", for: .normal)
            buttonTitleSet2.setTitle("Cancel", for: .normal)
            segmentedControl.setTitle("Minute", forSegmentAt: 0)
            segmentedControl.setTitle("Hour", forSegmentAt: 1)
            segmentedControl.setTitle("Day", forSegmentAt: 2)
            stringarry[0] = "Oops!"
            stringarry[1] = "There was an issue during saving!"
            stringarry[2] = "Hey!"
            stringarry[3] = "You should have a glass of water!"
            stringarry[4] = "Enable Notification"
            stringarry[5] = "To use this feature you must enable notifications in settings"
            stringarry[6] = "Cancel"
            stringarry[7] = "There was an issue during deleting!"
            stringarry[8] = " "
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return String(pickerData[row])
        }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.row = row
    }
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }

   
    //Functions
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      NotificationCenter.default.addObserver(self, selector: #selector(NotificationViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
      NotificationCenter.default.addObserver(self, selector: #selector(NotificationViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        presentingViewController?.viewWillDisappear(true)
        setLanguage()
    }

    override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      NotificationCenter.default.removeObserver(self)
        presentingViewController?.viewWillAppear(true)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
      if let userInfo = notification.userInfo,
        //let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
         let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue{
         
          UIView.animate(withDuration: duration, animations: {
              
              self.constraint1.constant = 70
            self.view.layoutIfNeeded()
          })
        
      }
    }

    @objc private func keyboardWillHide(notification: Notification) {
      if let userInfo = notification.userInfo,
        let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue {
        UIView.animate(withDuration: duration) {
            
          
            self.constraint1.constant = -10
          self.view.layoutIfNeeded()
        }
      }
    }
}

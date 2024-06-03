//
//  NotificationsTableViewController.swift
//  Drop-a-Note
//
//  Created by Balint Dombovari on 2022. 12. 08..
//

//Notif == Notification

import UIKit
import CoreData
class NotificationsTableViewController: UITableViewController {

    
    //MARK: Properties
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let notificationCenter = UNUserNotificationCenter.current()
    var notifs: [NOTIFICATION]?
    var numberoftrues: Int = 0
    let userDefaults = UserDefaults(suiteName: "group.settingsdata")
    var language: Int = 0
    var stringarray: [String] = ["","","","","","","","","","","","","",""]
    let bluecolor = UIColor(red: 119/255, green: 182/255, blue: 255/255, alpha: 1.0)
    let magentacolor = UIColor(red: 254/255, green: 90/255, blue: 131/255, alpha: 1.0)
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        setLanguage()
        fetchNotif()
        //Notifications
        notificationCenter.requestAuthorization (options: [.alert, .sound ]) { permissionGranted, error in
            if(!permissionGranted){
                print("Permission denied!")
        }
        }
    }

    //MARK: Functions
    func fetchNotif(){
        do{
            self.notifs = try context.fetch(NOTIFICATION.fetchRequest())
            var b: Int = 0
            // notfis sorted
            while b < notifs!.count{
                if notifs![b].ison == true{
                    b += 1
                    continue
                }
                else if notifs![b].ison == false{
                    let c = notifs![b]
                    var d = notifs!.count-1
                    while d > b{
                        if notifs![d].ison == true{
                            notifs![b] = notifs![d]
                            notifs![d] = c
                            break
                        }
                        d -= 1
                    }
                    b += 1
                }
            }
            var sum: Int = 0
            for a in self.notifs!{
                if a.ison == true{
                    sum += 1
                }
            }
            numberoftrues = sum
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
           
             }
        catch{
            print(error.localizedDescription)
        }
    }
    func setLanguage(){
        language = userDefaults?.value(forKey: "Language") as? Int ?? 0
        switch language{
        case 0:
            navigationItem.title = "Notifications"
            stringarray[0] = "Hey!"
            stringarray[1] = "You should have a glass of water!"
            stringarray[2] = "Enable Notification"
            stringarray[3] = "To use this feature you must enable notifications in settings!"
            stringarray[4] = "Cancel"
            stringarray[5] = "Oops!"
            stringarray[6] = "There was an issue during saving!"
            stringarray[7] = "Active notifications"
            stringarray[8] = "Inactive notifications"
            stringarray[9] = "min"
            stringarray[10] = "hour"
            stringarray[11] = "day"
            stringarray[12] = "Delete"
            stringarray[13] = "There was an issue during deleting!"
        case 1:
            navigationItem.title = "Értesítések"
            stringarray[0] = "Héj!"
            stringarray[1] = "Igyál egy pohár vízet!"
            stringarray[2] = "Értesítések bekapcsolása"
            stringarray[3] = "A funkció használatához engedélyezned kell az éretsítéseket a beállítsokban!"
            stringarray[4] = "Mégsem"
            stringarray[5] = "Hoppá!"
            stringarray[6] = "Probléma adódott mentés közben!"
            stringarray[7] = "Aktív értesítések"
            stringarray[8] = "Inaktív értesítések"
            stringarray[9] = "perc"
            stringarray[10] = "óra"
            stringarray[11] = "nap"
            stringarray[12] = "Törlés"
            stringarray[13] = "Probléma adódott törlés közben!"
        case 2:
            navigationItem.title = "Mitteilungen"
            stringarray[0] = "Hallo!"
            stringarray[1] = "Trink ein Glas Wasser!"
            stringarray[2] = "Mitteilungen erlauben"
            stringarray[3] = "Du musst die Mitteulungen in der Einstellungen er lauben, diese Funktion zu benutzen!"
            stringarray[4] = "Abbrechen"
            stringarray[5] = "Hoppla!"
            stringarray[6] = "Es gab ein Problem unter der Sicherung!"
            stringarray[7] = "Aktive Mitteilungen"
            stringarray[8] = "Inaktive Mitteilungen"
            stringarray[9] = "min"
            stringarray[10] = "stunden"
            stringarray[11] = "tage"
            stringarray[12] = "Löschen"
            stringarray[13] = "Es gab ein Problem unter dem Löschen!"
            
        default:
            navigationItem.title = "Notifications"
            stringarray[0] = "Hey!"
            stringarray[1] = "You should have a glass of water!"
            stringarray[2] = "Enable Notification"
            stringarray[3] = "To use this feature you must enable notifications in settings"
            stringarray[4] = "Cancel"
            stringarray[5] = "Oops!"
            stringarray[6] = "There was an issue during saving!"
            stringarray[7] = "Active notifications"
            stringarray[8] = "Inactive notifications"
            stringarray[9] = "min"
            stringarray[10] = "hour"
            stringarray[11] = "day"
            stringarray[12] = "Delete"
            stringarray[13] = "There was an issue during deleting!"
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Segue"{
            let notificationViewController = segue.destination as! NotificationViewController
            let newnotif = NOTIFICATION(context: self.context)
            notificationViewController.notif = newnotif
            notificationViewController.notifiIndex = self.notifs!.count
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchNotif()
        setLanguage()
    }
    
    @objc func switchDidChange(_ sender: SwitchView){
        if  sender.isOn{
            self.notifs![sender.index].ison = true
            print(sender.index)
            self.notificationCenter.getNotificationSettings { settings in
                                DispatchQueue.main.async {
                    if settings.authorizationStatus == .authorized {
                        
                        let content = UNMutableNotificationContent()
                        content.title = "\(self.stringarray[0])"
                        if self.notifs![sender.index].title != nil{
                            content.body = self.notifs![sender.index].title!
                        }
                        else{
                            content.body = "\(self.stringarray[1])"
                        }
                        content.sound = UNNotificationSound(named: UNNotificationSoundName("water.wav"))
                        
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: (Double(self.notifs![sender.index].time)) * Double(self.notifs![sender.index].type) , repeats:true)
                        let request = UNNotificationRequest(identifier: self.notifs![sender.index].notificationindex! , content: content, trigger: trigger)
                        
                        self.notificationCenter.add(request){ (error) in
                            if error != nil{
                                print("Error" + error.debugDescription)
                                return
                            }
                        }
                        /*let ac = UIAlertController(title: "Notification is on!", message: "", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(ac, animated: true)*/
                    }
                    else{
                        let ac = UIAlertController(title: "\(self.stringarray[2])", message: "\(self.stringarray[3])", preferredStyle: .alert)
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
                        ac.addAction(UIAlertAction(title: "\(self.stringarray[4])", style: .default))
                        self.present(ac, animated: true)
                    }
                }
            }
            do{
                try  self.context.save()
            }
            catch{
                print(error.localizedDescription)
                let error = UIAlertController(title: "\(self.stringarray[5])", message: "\(self.stringarray[6])", preferredStyle: .alert)
                let submitButton2 = UIAlertAction(title: "OK", style: .default)
                submitButton2.setValue(self.bluecolor, forKey: "titleTextColor")
                error.addAction(submitButton2)
                self.present(error,animated: true,completion: nil)
            }
            self.fetchNotif()
            self.tableView.reloadData()
        }
        else
        {
            self.notifs![sender.index].ison = false
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [self.notifs![sender.index].notificationindex!])
            UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [self.notifs![sender.index].notificationindex!])
            do{
                try  self.context.save()
            }
            catch{
                print(error.localizedDescription)
                let error = UIAlertController(title: "\(self.stringarray[5])", message: "\(self.stringarray[6])", preferredStyle: .alert)
                let submitButton2 = UIAlertAction(title: "OK", style: .default)
                submitButton2.setValue(self.bluecolor, forKey: "titleTextColor")
                error.addAction(submitButton2)
                self.present(error,animated: true,completion: nil)
            }
            self.fetchNotif()
            self.tableView.reloadData()
        }
        /*do{
            try  self.context.save()
        }
        catch{
            print(error.localizedDescription)
            let error = UIAlertController(title: "Oops!", message: "There was an issue during saving!", preferredStyle: .alert)
            let submitButton2 = UIAlertAction(title: "OK", style: .default)
            error.addAction(submitButton2)
            self.present(error,animated: true,completion: nil)
        }
        //TableView frissítése
        self.fetchNotif()
        self.tableView.reloadData()*/
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
   
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "\(self.stringarray[7])"
        }
        else{
            return "\(self.stringarray[8])"
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if self.notifs?.count != nil{
            if section == 0 {
                return numberoftrues
            }
            else{
                return self.notifs!.count-numberoftrues
                 }
        }
        else{
            return 0
        }
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotifCell", for: indexPath)
        let indexsection = indexPath.section
        var indexrows = indexPath.row
        var plural: Bool = true
        if indexsection == 1 {
            indexrows += numberoftrues
        }
        let actualnotif = self.notifs![indexrows]
        let switchView = SwitchView(frame: .zero)
        switchView.setOn(actualnotif.ison, animated: true)
        switchView.tag = indexrows
        switchView.onTintColor = self.bluecolor
        switchView.index = indexrows
        switchView.addTarget(self, action: #selector(self.switchDidChange(_:)), for: .valueChanged)
        let timetype = actualnotif.type
        if actualnotif.type != 60 && actualnotif.time == 1 && language == 2{
            stringarray[10] = stringarray[10].replacingOccurrences(of: "en", with: "e")
            stringarray[11] = stringarray[11].replacingOccurrences(of: "e", with: "")
            plural = false
        }
        let ifnil = ""
            switch timetype {
            case 60:
                cell.textLabel?.text = "\(actualnotif.time) : \(stringarray[9])"
            case 3600:
                cell.textLabel?.text = "\(actualnotif.time) : \(stringarray[10])"
            case 86400:
                cell.textLabel?.text = "\(actualnotif.time) : \(stringarray[11])"
            default:
                cell.textLabel?.text = "\(actualnotif.time) (?)"
            }
        if plural != false && language == 2{
            stringarray[10] = "stunden"
            stringarray[11] = "tage"
            plural = true
        }
        cell.detailTextLabel?.text = "\(actualnotif.title ?? ifnil)"
        
                if actualnotif.ison == true{
                    cell.imageView?.image = UIImage(systemName: "clock.badge.checkmark")
                    cell.imageView?.tintColor = self.bluecolor
                }
                else{
                    cell.imageView?.image = UIImage(systemName: "clock.badge.xmark")
                    cell.imageView?.tintColor = self.magentacolor
                }
            
        
        cell.accessoryView = switchView
        return cell
    }
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "\(self.stringarray[12])") {
            (action, view, comletionHandler) in
            if indexPath.section == 0 {
                let notifToRemove = self.notifs![indexPath.row]
                self.notificationCenter.removeAllDeliveredNotifications()
                self.notificationCenter.removeAllPendingNotificationRequests()
                self.context.delete(notifToRemove)
                do{
                   try self.context.save()
                     }
                catch{
                    print(error.localizedDescription)
                    let error = UIAlertController(title: "\(self.stringarray[5])", message: "\(self.stringarray[13])", preferredStyle: .alert)
                    let submitButton = UIAlertAction(title: "OK", style: .default)
                    submitButton.setValue(self.bluecolor, forKey: "titleTextColor")
                    error.addAction(submitButton)
                    self.present(error,animated: true,completion: nil)
                }
                self.fetchNotif()
            }
            else {
                let notifToRemove = self.notifs![indexPath.row + self.numberoftrues]
                self.notificationCenter.removeAllDeliveredNotifications()
                self.notificationCenter.removeAllPendingNotificationRequests()
                self.context.delete(notifToRemove)
                do{
                   try self.context.save()
                     }
                catch{
                    print(error.localizedDescription)
                    let error = UIAlertController(title: "\(self.stringarray[5])", message: "\(self.stringarray[13])", preferredStyle: .alert)
                    let submitButton = UIAlertAction(title: "OK", style: .default)
                    submitButton.setValue(self.bluecolor, forKey: "titleTextColor")
                    error.addAction(submitButton)
                    self.present(error,animated: true,completion: nil)
                }
                self.fetchNotif()
            }

        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }

}

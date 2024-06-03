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
    let fetchRequest: NSFetchRequest<NOTIFICATION> = NOTIFICATION.fetchRequest()
    let fetchRequest1: NSFetchRequest<NOTIFICATION> = NOTIFICATION.fetchRequest()
    var notifs: [NOTIFICATION]?
    var notifstrue: [NOTIFICATION]?
    var notifsfalse: [NOTIFICATION]?
    var sumtrue: Int = 0
    let True: Bool = true
    let False: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        let predicate = NSPredicate(format: "anAttribute == %@", #keyPath(NOTIFICATION.ison), True)
        fetchRequest.predicate = predicate
        let predicate1 = NSPredicate(format: "anAttribute == %@", NSNumber(value: NOTIFICATION.ison), False)
        fetchRequest1.predicate = predicate1
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
            self.notifstrue = try context.fetch(fetchRequest)
            self.notifsfalse = try context.fetch(fetchRequest1)
            let lenght1: Int = notifsfalse!.count
            let lenght: Int = notifstrue!.count
            
            for i in 0...lenght{
                notifs?[i] = notifstrue![i]
                
            }
            for i in 0...lenght1{
                notifs?[lenght-1+i] = notifstrue![i]
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
           
             }
        catch{
            print(error.localizedDescription)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Segue"{
            let notificationViewController = segue.destination as! NotificationViewController
            let newnotif = NOTIFICATION(context: self.context)
            notificationViewController.notif = newnotif
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchNotif()
    }
    
    @objc func switchDidChange(_ sender: SwitchView){
        if  sender.isOn{
            self.notifs![sender.index].ison = true
            self.notificationCenter.getNotificationSettings { settings in
                                DispatchQueue.main.async {
                    if settings.authorizationStatus == .authorized {
                        
                        let content = UNMutableNotificationContent()
                        content.title = "Hey!"
                        if self.notifs![sender.index].title != nil{
                            content.body = self.notifs![sender.index].title!
                        }
                        else{
                            content.body = "You should have a glass of water!"
                        }
                        
                        
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: (Double(self.notifs![sender.index].time)) * Double(self.notifs![sender.index].type) , repeats:true)
                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                        
                        self.notificationCenter.add(request){ (error) in
                            if error != nil{
                                print("Error" + error.debugDescription)
                                return
                            }
                        }
                        let ac = UIAlertController(title: "Notification is on!", message: "", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(ac, animated: true)
                    }
                    else{
                        let ac = UIAlertController(title: "Enable Notification?", message: "To use this feature you must enable notifications in settings", preferredStyle: .alert)
                        let goToSettings = UIAlertAction(title: "String", style: .default){
                            (_) in
                            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString)
                            else{
                                return
                            }
                            if(UIApplication.shared.canOpenURL(settingsUrl)){
                                
                                UIApplication.shared.open(settingsUrl)
                            }
                        }
                        ac.addAction(goToSettings)
                        ac.addAction(UIAlertAction(title: "Cancel", style: .default))
                        self.present(ac, animated: true)
                    }
                }
            }
            self.tableView.reloadData()
        }
        else
        {
            self.notifs![sender.index].ison = false
            let turnOffAc = UIAlertController(title: "Notification is off!", message: "", preferredStyle: .alert)
            turnOffAc.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(turnOffAc, animated: true)
            notificationCenter.removeAllDeliveredNotifications()
            notificationCenter.removeAllPendingNotificationRequests()
            self.tableView.reloadData()
        }
        do{
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
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Active notifications"
        }
        else{
            return "Inactive notifications"
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if self.notifs?.count != nil{
        
            for a in self.notifs!{
                if a.ison == true{
                    sumtrue += 1
                }
            }
            if section == 0{
                return sumtrue
            }
            else{
                return self.notifs!.count - sumtrue
            }
            
        }
        else{
            return 0
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotifCell", for: indexPath)
        var indexrow: Int = indexPath.row
        if indexPath.section == 1{
            indexrow += sumtrue
        }
        let actualnotif = self.notifs![indexrow]
        let switchView = SwitchView(frame: .zero)
        switchView.setOn(actualnotif.ison, animated: true)
        switchView.tag = indexrow
        switchView.onTintColor = .systemCyan
        switchView.index = indexrow
        switchView.addTarget(self, action: #selector(self.switchDidChange(_:)), for: .valueChanged)
        let timetype = actualnotif.type
        let ifnil = ""
            switch timetype {
            case 60:
                cell.textLabel?.text = "\(actualnotif.time) : min"
            case 3600:
                cell.textLabel?.text = "\(actualnotif.time) : hour"
            case 86400:
                cell.textLabel?.text = "\(actualnotif.time) : day"
            default:
                cell.textLabel?.text = "\(actualnotif.time) (?)"
            }
        cell.detailTextLabel?.text = "\(actualnotif.title ?? ifnil)"
        
                if actualnotif.ison == true{
                    cell.imageView?.image = UIImage(systemName: "clock.badge.checkmark")
                    cell.imageView?.tintColor = .systemCyan
                }
                else{
                    cell.imageView?.image = UIImage(systemName: "clock.badge.xmark")
                    cell.imageView?.tintColor = .systemRed
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
        
        let action = UIContextualAction(style: .destructive, title: "Delete"){
            (action, view, comletionHandler) in
            let notifToRemove = self.notifs![indexPath.row]
            self.notificationCenter.removeAllDeliveredNotifications()
            self.notificationCenter.removeAllPendingNotificationRequests()
            self.context.delete(notifToRemove)
            do{
               try self.context.save()
                 }
            catch{
                print(error.localizedDescription)
                let error = UIAlertController(title: "Oops!", message: "There was an issue during deleting!", preferredStyle: .alert)
                let submitButton = UIAlertAction(title: "OK", style: .default)
                error.addAction(submitButton)
                self.present(error,animated: true,completion: nil)
            }
            self.fetchNotif()
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }

}

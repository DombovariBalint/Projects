//
//  TabBarController.swift
//  Drop-a-Note
//
//  Created by Balint Dombovari on 2023. 01. 09..
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.items?[0].title = ""
        self.tabBar.items?[1].title = ""
        self.tabBar.items?[2].title = ""
        self.tabBar.items?[3].title = ""
    }
    func set(){
        let userDefaults = UserDefaults(suiteName: "group.settingsdata")
        var Language: Int = 0
        Language = userDefaults?.value(forKey: "Language") as? Int ?? 0
        switch Language {
        case 0:
            self.tabBar.items?[0].title = ""
            self.tabBar.items?[1].title = ""
            self.tabBar.items?[2].title = ""
            self.tabBar.items?[3].title = ""
        case 1:
            self.tabBar.items?[0].title = ""
            self.tabBar.items?[1].title = ""
            self.tabBar.items?[2].title = ""
            self.tabBar.items?[3].title = ""
        case 2:
            self.tabBar.items?[0].title = ""
            self.tabBar.items?[1].title = ""
            self.tabBar.items?[2].title = ""
            self.tabBar.items?[3].title = ""
        default:
            self.tabBar.items?[0].title = ""
            self.tabBar.items?[1].title = ""
            self.tabBar.items?[2].title = ""
            self.tabBar.items?[3].title = ""
        }
       
    }
    func set2(){
        let userDefaults = UserDefaults(suiteName: "group.settingsdata")
        var Language: Int = 0
        Language = userDefaults?.value(forKey: "Language") as? Int ?? 0
        switch Language {
        case 0:
            self.viewControllers?[0].tabBarItem.title = "Today"
            self.viewControllers?[1].tabBarItem.title = "Notebooks"
            self.viewControllers?[2].tabBarItem.title = "Notification"
            self.viewControllers?[3].tabBarItem.title = "Settings"
        case 1:
            self.viewControllers?[0].tabBarItem.title = "Ma"
            self.viewControllers?[1].tabBarItem.title = "Jegyzetek"
            self.viewControllers?[2].tabBarItem.title = "Értesítések"
            self.viewControllers?[3].tabBarItem.title = "Beállítások"
        case 2:
            self.viewControllers?[0].tabBarItem.title = "Heute"
            self.viewControllers?[1].tabBarItem.title = "Noten"
            self.viewControllers?[2].tabBarItem.title = "Notifikation"
            self.viewControllers?[3].tabBarItem.title = "Einstellungen"
        default:
            self.viewControllers?[0].tabBarItem.title = "Today"
            self.viewControllers?[1].tabBarItem.title = "Notebooks"
            self.viewControllers?[2].tabBarItem.title = "Notification"
            self.viewControllers?[3].tabBarItem.title = "Settings"
        }
        tabBar.reloadInputViews()
    }

}

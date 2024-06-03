//
//  ButtonSetView.swift
//  Drop-a-Note
//
//  Created by Balint Dombovari on 2023. 02. 23..
//

import SwiftUI
import CoreData

struct ButtonSetView: View {
    
    @EnvironmentObject var buttons: ButtonS
    @Environment(\.dismiss) var dismiss
    let userDefaults = UserDefaults(suiteName: "group.settingsdata")
    @State private var language: Int = 0
    @State private var measure: Int = 0
    @State private var quantity: String = ""
    @State private var type: String = ""
    @State private var selected: Int = 0
    @State private var buttonsNummber: Int = 0
    @State private var isDelete: Bool = false
    @State var selectedToDelete: Int = 0
    @Binding var id: Int
    @State private var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var body: some View {
        VStack{
            HStack{
                //Cancel Button
                Button(action:{
                    dismiss()
                }, label:{
                    switch language{
                    case 0:
                        Text("Cancel")
                            .foregroundColor(Color.white)
                            
                    case 1:
                        Text("Mégsem")
                            .foregroundColor(Color.white)
                    case 2:
                        Text("Löschen")
                            .foregroundColor(Color.white)
                    default:
                        Text("Cancel")
                            .foregroundColor(Color.white)
                    }
                   
                })
                .frame(width: 100, height: 30)
                .background(Color(red: 254/255, green: 90/255, blue: 131/255))
                .clipShape(Capsule())
                .padding()
                Spacer()
                //Save Button
                Button(action:{
                    if isDelete == true{
                        if buttons.array?[selectedToDelete] != nil{
                            deleteButtons(button: buttons.array![selectedToDelete])
                        }
                        
                    }
                    else{
                        if buttons.names[id-1] != "---"{
                            changeButton()
                        }
                        else{
                            createButton()
                        }
                    }
                    fetchButtons()
                    dismiss()
                }, label:{
                    if isDelete == true{
                        switch language{
                        case 0:
                            Text("Delete")
                                .foregroundColor(Color.white)
                        case 1:
                            Text("Törlés")
                                .foregroundColor(Color.white)
                        case 2:
                            Text("Löschen")
                                .foregroundColor(Color.white)
                        default:
                            Text("Delete")
                                .foregroundColor(Color.white)
                        }
                    }
                    else{
                        switch language{
                        case 0:
                            Text("Save")
                                .foregroundColor(Color.white)
                        case 1:
                            Text("Mentés")
                                .foregroundColor(Color.white)
                        case 2:
                            Text("Sichern")
                                .foregroundColor(Color.white)
                        default:
                            Text("Save")
                                .foregroundColor(Color.white)
                        }
                    }
                })
                .frame(width: 100, height: 30)
                .background(Color(red: 119/255, green: 182/255, blue: 255/255))
                .clipShape(Capsule())
                .padding()
            }
            switch language{
            case 0:
                Text("Customize Button")
                    .fontWeight(.light)
                    .font(.system(size: 20, design: .default))
                TextField("Quantity:", text: $quantity )
                    .fontWeight(.light)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .keyboardType(.decimalPad)
                TextField("Type of drink:", text: $type )
                    .textFieldStyle(.roundedBorder)
                    .fontWeight(.light)
                    .padding()
                switch measure{
                case 0:
                    Picker("Operation", selection:$selected)
                    {
                        Text("ml").tag(0)
                        Text("dl").tag(1)
                        Text("l").tag(2)
                    }
                        .pickerStyle(.segmented)
                        .padding()
                case 1:
                    Picker("Operation", selection:$selected)
                    {
                        Text("Oz (UK)").tag(0)
                        
                    }
                        .pickerStyle(.segmented)
                        .padding()
                case 2:
                    Picker("Operation", selection:$selected)
                    {
                        Text("Oz (US)").tag(0)
                        
                    }
                        .pickerStyle(.segmented)
                        .padding()
                default:
                    Picker("Operation", selection:$selected)
                    {
                        Text("ml").tag(0)
                        Text("dl").tag(1)
                        Text("l").tag(2)
                    }
                        .pickerStyle(.segmented)
                        .padding()
                }

            case 1:
                Text("Gomb testreszabása")
                    .fontWeight(.light)
                    .font(.system(size: 20, design: .default))
                TextField("Mennyiség:", text: $quantity )
                    .fontWeight(.light)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .keyboardType(.decimalPad)
                TextField("Ital típusa:", text: $type )
                    .textFieldStyle(.roundedBorder)
                    .fontWeight(.light)
                    .padding()
                switch measure{
                case 0:
                    Picker("Operation", selection:$selected)
                    {
                        Text("ml").tag(0)
                        Text("dl").tag(1)
                        Text("l").tag(2)
                    }
                        .pickerStyle(.segmented)
                        .padding()
                case 1:
                    Picker("Operation", selection:$selected)
                    {
                        Text("Oz (UK)").tag(0)
                        
                    }
                        .pickerStyle(.segmented)
                        .padding()
                case 2:
                    Picker("Operation", selection:$selected)
                    {
                        Text("Oz (US)").tag(0)
                        
                    }
                        .pickerStyle(.segmented)
                        .padding()
                default:
                    Picker("Operation", selection:$selected)
                    {
                        Text("ml").tag(0)
                        Text("dl").tag(1)
                        Text("l").tag(2)
                    }
                        .pickerStyle(.segmented)
                        .padding()
                }
            case 2:
                Text("Anpassung dem Button")
                    .fontWeight(.light)
                    .font(.system(size: 20, design: .default))
                TextField("Quantität:", text: $quantity )
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .fontWeight(.light)
                    .keyboardType(.decimalPad)
                TextField("Typ dem Getränk:", text: $type )
                    .textFieldStyle(.roundedBorder)
                    .fontWeight(.light)
                    .padding()
                switch measure{
                case 0:
                    Picker("Operation", selection:$selected)
                    {
                        Text("ml").tag(0)
                        Text("dl").tag(1)
                        Text("l").tag(2)
                    }
                        .pickerStyle(.segmented)
                        .padding()
                case 1:
                    Picker("Operation", selection:$selected)
                    {
                        Text("Oz (UK)").tag(0)
                        
                    }
                        .pickerStyle(.segmented)
                        .padding()
                case 2:
                    Picker("Operation", selection:$selected)
                    {
                        Text("Oz (US)").tag(0)
                        
                    }
                        .pickerStyle(.segmented)
                        .padding()
                default:
                    Picker("Operation", selection:$selected)
                    {
                        Text("ml").tag(0)
                        Text("dl").tag(1)
                        Text("l").tag(2)
                    }
                        .pickerStyle(.segmented)
                        .padding()
                }
            default:
                Text("Customize Button")
                    .fontWeight(.light)
                    .font(.system(size: 20, design: .default))
                TextField("Quantity:", text: $quantity )
                    .fontWeight(.light)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .keyboardType(.decimalPad)
                TextField("Type of drink:", text: $type )
                    .textFieldStyle(.roundedBorder)
                    .fontWeight(.light)
                    .padding()
                switch measure{
                case 0:
                    Picker("Operation", selection:$selected)
                    {
                        Text("ml").tag(0)
                        Text("dl").tag(1)
                        Text("l").tag(2)
                    }
                        .pickerStyle(.segmented)
                        .padding()
                case 1:
                    Picker("Operation", selection:$selected)
                    {
                        Text("Oz (UK)").tag(0)
                        
                    }
                        .pickerStyle(.segmented)
                        .padding()
                case 2:
                    Picker("Operation", selection:$selected)
                    {
                        Text("Oz (US)").tag(0)
                        
                    }
                        .pickerStyle(.segmented)
                        .padding()
                default:
                    Picker("Operation", selection:$selected)
                    {
                        Text("ml").tag(0)
                        Text("dl").tag(1)
                        Text("l").tag(2)
                    }
                        .pickerStyle(.segmented)
                        .padding()
                }
            }
            if buttonsNummber > 0{
                VStack{
                    switch language{
                    case 0:
                        Toggle(isOn: $isDelete, label: {
                                    Label("Delete Buttons:", systemImage: "trash")
                                })
                        .toggleStyle(SwitchToggleStyle())
                                    .tint(Color(red: 254/255, green: 90/255, blue: 131/255))
                                    .foregroundColor(Color(red: 119/255, green: 182/255, blue: 255/255))
                                    
                                    .padding()
                    case 1:
                        Toggle(isOn: $isDelete, label: {
                                    Label("Gombok törlése:", systemImage: "trash")
                                })
                        .toggleStyle(SwitchToggleStyle())
                                    .tint(Color(red: 254/255, green: 90/255, blue: 131/255))
                                    .foregroundColor(Color(red: 119/255, green: 182/255, blue: 255/255))
                                    .padding()
                    case 2:
                        Toggle(isOn: $isDelete, label: {
                                    Label("Löschen die Buttons:", systemImage: "trash")
                                })
                        .toggleStyle(SwitchToggleStyle())
                                    .tint(Color(red: 254/255, green: 90/255, blue: 131/255))
                                    .foregroundColor(Color(red: 119/255, green: 182/255, blue: 255/255))
                                    .padding()
                    default:
                        Toggle(isOn: $isDelete, label: {
                                    Label("Delete Buttons:", systemImage: "trash")
                                })
                        .toggleStyle(SwitchToggleStyle())
                                    .tint(Color(red: 254/255, green: 90/255, blue: 131/255))
                                    .foregroundColor(Color(red: 119/255, green: 182/255, blue: 255/255))
                                    .padding()
                    }
                }
                
            if isDelete == true{
                
                Picker("Delete Buttons", selection: $selectedToDelete){
                    
                    ForEach(buttons.array!, id: \.self) { a in
                        switch a.id{
                        case 1:
                            switch a.measure{
                            case "ml":
                                Text("\(String(format: "%.0f",a.quantity * 1000)) ml \(a.type ?? "")").tag(0)
                            case "dl":
                                Text("\(String(format: "%.0f",a.quantity * 10)) dl \(a.type ?? "")").tag(0)
                            case "l":
                                Text("\(String(format: "%.0f",a.quantity)) l \(a.type ?? "")").tag(0)
                            case "Oz(uk)":
                                Text("\(String(format: "%.0f",a.quantity)) Oz(uk) \(a.type ?? "")").tag(0)
                            case "Oz(us)":
                                Text("\(String(format: "%.0f",a.quantity)) Oz(us) \(a.type ?? "")").tag(0)
                            default:
                                Text("\(String(format: "%.0f",a.quantity)) l \(a.type ?? "")").tag(0)
                                
                            }
                        case 2:
                            switch a.measure{
                            case "ml":
                                Text("\(String(format: "%.0f",a.quantity * 1000)) ml \(a.type ?? "")").tag(1)
                            case "dl":
                                Text("\(String(format: "%.0f",a.quantity * 10)) dl \(a.type ?? "")").tag(1)
                            case "l":
                                Text("\(String(format: "%.0f",a.quantity)) l \(a.type ?? "")").tag(1)
                            case "Oz(uk)":
                                Text("\(String(format: "%.0f",a.quantity)) Oz(uk) \(a.type ?? "")").tag(1)
                            case "Oz(us)":
                                Text("\(String(format: "%.0f",a.quantity)) Oz(us) \(a.type ?? "")").tag(1)
                            default:
                                Text("\(String(format: "%.0f",a.quantity)) l \(a.type ?? "")").tag(1)
                                
                            }
                        case 3:
                            switch a.measure{
                            case "ml":
                                Text("\(String(format: "%.0f",a.quantity * 1000)) ml \(a.type ?? "")").tag(2)
                            case "dl":
                                Text("\(String(format: "%.0f",a.quantity * 10)) dl \(a.type ?? "")").tag(2)
                            case "l":
                                Text("\(String(format: "%.0f",a.quantity)) l \(a.type ?? "")").tag(2)
                            case "Oz(uk)":
                                Text("\(String(format: "%.0f",a.quantity)) Oz(uk) \(a.type ?? "")").tag(2)
                            case "Oz(us)":
                                Text("\(String(format: "%.0f",a.quantity)) Oz(us) \(a.type ?? "")").tag(2)
                            default:
                                Text("\(String(format: "%.0f",a.quantity)) l \(a.type ?? "")").tag(2)
                                
                            }
                        case 4:
                            switch a.measure{
                            case "ml":
                                Text("\(String(format: "%.0f",a.quantity * 1000)) ml \(a.type ?? "")").tag(3)
                            case "dl":
                                Text("\(String(format: "%.0f",a.quantity * 10)) dl \(a.type ?? "")").tag(3)
                            case "l":
                                Text("\(String(format: "%.0f",a.quantity)) l \(a.type ?? "")").tag(3)
                            case "Oz(uk)":
                                Text("\(String(format: "%.0f",a.quantity)) Oz(uk) \(a.type ?? "")").tag(3)
                            case "Oz(us)":
                                Text("\(String(format: "%.0f",a.quantity)) Oz(us) \(a.type ?? "")").tag(3)
                            default:
                                Text("\(String(format: "%.0f",a.quantity)) l \(a.type ?? "")").tag(3)
                                
                            }
                        default:
                            switch a.measure{
                            case "ml":
                                Text("\(String(format: "%.0f",a.quantity * 1000)) ml \(a.type ?? "")").tag(0)
                            case "dl":
                                Text("\(String(format: "%.0f",a.quantity * 10)) dl \(a.type ?? "")").tag(0)
                            case "l":
                                Text("\(String(format: "%.0f",a.quantity)) l \(a.type ?? "")").tag(0)
                            case "Oz(uk)":
                                Text("\(String(format: "%.0f",a.quantity)) Oz(uk) \(a.type ?? "")").tag(0)
                            case "Oz(us)":
                                Text("\(String(format: "%.0f",a.quantity)) Oz(us) \(a.type ?? "")").tag(0)
                            default:
                                Text("\(String(format: "%.0f",a.quantity)) l \(a.type ?? "")").tag(0)
                                
                            }
                        }
                        
                        
                    }
                }
                .pickerStyle(.wheel)
                .fontWeight(.light)
            }
             }
            Spacer()
        }
        .onAppear(){
            language = self.userDefaults?.value(forKey: "Language") as? Int ?? 0
            measure = self.userDefaults?.value(forKey: "Measure") as? Int ?? 0
            fetchButtons()
            buttonsNummber = buttons.array?.count ?? 0
        }
        
        .background(Color(.systemGray6))
    }
    
    func createButton(){
        let newButton = CustomB(context: context)
        let numberFormatter = NumberFormatter()
        newButton.type = type
        newButton.id = id
        switch measure{
        case 0:
            switch selected{
            case 0:
                newButton.measure = "ml"
                newButton.quantity = (numberFormatter.number(from: quantity)?.doubleValue ?? 0)/1000
            case 1:
                newButton.measure = "dl"
                newButton.quantity = (numberFormatter.number(from: quantity)?.doubleValue ?? 0)/10
            case 2:
                newButton.measure = "l"
                newButton.quantity = (numberFormatter.number(from: quantity)?.doubleValue ?? 0)
            default:
                newButton.measure = "ml"
                newButton.quantity = (numberFormatter.number(from: quantity)?.doubleValue ?? 0)/1000
            }
        case 1:
            newButton.measure = "Oz(uk)"
            newButton.quantity = (numberFormatter.number(from: quantity)?.doubleValue ?? 0)
        case 2:
            newButton.measure = "Oz(us)"
            newButton.quantity = (numberFormatter.number(from: quantity)?.doubleValue ?? 0)
        default:
            switch selected{
            case 0:
                newButton.measure = "ml"
                newButton.quantity = (numberFormatter.number(from: quantity)?.doubleValue ?? 0)/1000
            case 1:
                newButton.measure = "dl"
                newButton.quantity = (numberFormatter.number(from: quantity)?.doubleValue ?? 0)/10
            case 2:
                newButton.measure = "l"
                newButton.quantity = (numberFormatter.number(from: quantity)?.doubleValue ?? 0)
            default:
                newButton.measure = "ml"
                newButton.quantity = (numberFormatter.number(from: quantity)?.doubleValue ?? 0)/1000
            }
        }
        do{
            try context.save()
        }
        catch{
            print(error.localizedDescription)
        }
        
    }
    func changeButton(){
        var button: [CustomB]?
        let fetchrequest: NSFetchRequest<CustomB> = CustomB.fetchRequest()
        let predicate = NSPredicate(format: "%K == %i", #keyPath(CustomB.id), id)
        fetchrequest.predicate = predicate
        do{
            button = try context.fetch(fetchrequest)
        }
        catch{
            print(error.localizedDescription)
        }
        let numberFormatter = NumberFormatter()
        if button?[0] != nil{
            button?[0].type = type
            switch measure{
            case 0:
                switch selected{
                case 0:
                    button?[0].measure = "ml"
                    button?[0].quantity = (numberFormatter.number(from: quantity)?.doubleValue ?? 0)/1000
                case 1:
                    button?[0].measure = "dl"
                    button?[0].quantity = (numberFormatter.number(from: quantity)?.doubleValue ?? 0)/10
                case 2:
                    button?[0].measure = "l"
                    button?[0].quantity = (numberFormatter.number(from: quantity)?.doubleValue ?? 0)
                default:
                    button?[0].measure = "ml"
                    button?[0].quantity = (numberFormatter.number(from: quantity)?.doubleValue ?? 0)/1000
                }
            case 1:
                button?[0].measure = "Oz(uk)"
                button?[0].quantity = (numberFormatter.number(from: quantity)?.doubleValue ?? 0)
            case 2:
                button?[0].measure = "Oz(us)"
                button?[0].quantity = (numberFormatter.number(from: quantity)?.doubleValue ?? 0)
            default:
                switch selected{
                case 0:
                    button?[0].measure = "ml"
                    button?[0].quantity = (numberFormatter.number(from: quantity)?.doubleValue ?? 0)/1000
                case 1:
                    button?[0].measure = "dl"
                    button?[0].quantity = (numberFormatter.number(from: quantity)?.doubleValue ?? 0)/10
                case 2:
                    button?[0].measure = "l"
                    button?[0].quantity = (numberFormatter.number(from: quantity)?.doubleValue ?? 0)
                default:
                    button?[0].measure = "ml"
                    button?[0].quantity = (numberFormatter.number(from: quantity)?.doubleValue ?? 0)/1000
                }
            }
            do{
                try context.save()
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
    func deleteButtons(button: CustomB){
        context.delete(button)
        do{
            try self.context.save()
        }
        catch{
            print(error.localizedDescription)
        }
    }
    func fetchButtons(){
    let fetchRequest: NSFetchRequest<CustomB> = CustomB.fetchRequest()
    let sortDescriptor = NSSortDescriptor(key: #keyPath(CustomB.id), ascending: true)
      fetchRequest.sortDescriptors = [sortDescriptor]
    do{
        buttons.array = try context.fetch(fetchRequest)
    }
    catch{
        print(error.localizedDescription)
    }
    if buttons.array != nil{
        for a in 0...3{
            buttons.names[a] = "---"
        }
        var i: Int = 0
        for a in buttons.array!{
            while i < a.id-1{
                i += 1
            }
            print(i)
            switch a.measure{
            case "ml":
                buttons.names[i] = "\(String(format: "%.0f",a.quantity * 1000)) ml \(a.type ?? "")"
            case "dl":
                buttons.names[i] = "\(String(format: "%.0f",a.quantity * 10)) dl \(a.type ?? "")"
            case "l":
                buttons.names[i] = "\(String(format: "%.0f",a.quantity)) l \(a.type ?? "")"
            case "Oz(uk)":
                buttons.names[i] = "\(String(format: "%.0f",a.quantity)) Oz(uk) \(a.type ?? "")"
            case "Oz(us)":
                buttons.names[i] = "\(String(format: "%.0f",a.quantity)) Oz(us) \(a.type ?? "")"
            default:
                buttons.names[i] = "\(String(format: "%.0f",a.quantity)) l \(a.type ?? "")"
            }
            i = 0
         }
        }
        else {
            for a in 0...3{
                buttons.names[a] = "---"
            }
        }
    }
}

struct ButtonSetView_Previews: PreviewProvider {
    static var previews: some View {
        let previewInt: Int = 0
        ButtonSetView(id: .constant(previewInt))
    }
}
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

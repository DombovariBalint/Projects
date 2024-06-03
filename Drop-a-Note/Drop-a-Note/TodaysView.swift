//
//  TodaysView.swift
//  Drop-a-Note
//
//  Created by Balint Dombovari on 2023. 02. 12..
//

import SwiftUI
import CoreData
import WidgetKit
class HostingTodays: UIHostingController<TodaysView>{
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: TodaysView())
    }
}
class ButtonS: ObservableObject {
    @Published var names: [String] = ["---","---","---","---"]
    @Published var array: [CustomB]?
    
}
struct TodaysView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let userDefaults = UserDefaults(suiteName: "group.settingsdata")
    let userDefaults2 = UserDefaults(suiteName: "group.widgetdatasend")
    @State private var showingPopover1 = false
    @State private var showingPopover2 = false
    @State private var showingPopover3 = false
    @State private var showingPopover4 = false
    @State var canEdit: Bool = false
    @State var firstnotebook: Bool = true
    @State var measure: Int = 0
    @State var language: Int = 0
    @State var pickerdata: Double = 0.0
    @State var consumption: Double = 0.0
    @State var pressedButtonID: Int = 0
    @StateObject var Buttons = ButtonS()
    @State var animatingHeart: Bool = false;
    var body: some View {
            VStack{
                switch language {
                case 0:
                    Text("Today")
                        .font(.system(size: 25, design: .default))
                        .fontWeight(.light)
                case 1:
                    Text("Mai nap")
                        .font(.system(size: 25, design: .default))
                        .fontWeight(.light)
                case 2:
                    Text("Heute")
                        .font(.system(size: 25, design: .default))
                        .fontWeight(.light)
                default:
                    Text("Today")
                        .font(.system(size: 25, design: .default))
                        .fontWeight(.light)
                }
                Spacer()
                ZStack{
                    // iPhone SE
                    if UIScreen.screenWidth == 375 && UIScreen.screenHeight == 667{
                        Ellipse()
                            .fill(.white.shadow(.inner(color: Color(red: 106/255, green: 166/255, blue: 234/255), radius: 10)) )
                            .frame(width: 183.3,height: 38.076)
                            .shadow(color: Color(red: 106/255, green: 166/255, blue: 234/255).opacity(0.5), radius: 10, y: 10)
                            .offset(y: 85)
                        Ellipse()
                              
                            .fill(.white.shadow(.inner(color: Color(red: 106/255, green: 166/255, blue: 234/255), radius: 10)) )
                            .frame(width: 150,height: 28.724)
                              .offset(y: 84)
                        Ellipse()
                            .fill(.white.shadow(.inner(color: Color(red: 106/255, green: 166/255, blue: 234/255), radius: 8)) )
                            .frame(width: 116.7,height: 20.04)
                            .offset(y: 83)
                        Drop()
                            .frame(width: 100, height: 167)
                            .foregroundStyle(Color(red: 119/255, green: 182/255, blue: 255/255).gradient.shadow(.inner(color: Color.black.opacity(0.4),radius: 10, x: -7, y: -11)))
                            .shadow(color: Color.gray.opacity(0), radius: 20, x: 20, y: 20)
                        
                            Heart()
                                .frame(width: 25, height: 25)
                                .rotationEffect(.degrees(30))
                                .foregroundStyle(Color(red: 254/255, green: 90/255, blue: 131/255).gradient.shadow(.inner(color: Color.black.opacity(0.4),radius: 3, x: -2.5, y: -2.5)))
                                .shadow(color: Color.gray.opacity(0), radius: 20, x: 20, y: 20)
                                .offset(x: 40, y: -70)
                                .scaleEffect(animatingHeart ? 0.9 : 1.4)
                                .scaleEffect(animatingHeart ? 1.4 : 0.9)
                        
                    }
                    // iPhone 7-8 Plus
                    else if UIScreen.screenWidth ==  414 && UIScreen.screenHeight == 736{
                        Ellipse()
                            .fill(.white.shadow(.inner(color: Color(red: 106/255, green: 166/255, blue: 234/255), radius: 15)) )
                            .frame(width: 275,height: 57)
                            .shadow(color: Color(red: 106/255, green: 166/255, blue: 234/255).opacity(0.5), radius: 10, y: 10)
                            .offset(y: 110)
                        Ellipse()
                              
                            .fill(.white.shadow(.inner(color: Color(red: 106/255, green: 166/255, blue: 234/255), radius: 15)) )
                              .frame(width: 225,height: 43)
                              .offset(y: 109)
                        Ellipse()
                            .fill(.white.shadow(.inner(color: Color(red: 106/255, green: 166/255, blue: 234/255), radius: 13)) )
                            .frame(width: 175,height: 30)
                            .offset(y: 108)
                        Drop()
                            .frame(width: 135, height: 225)
                            .foregroundStyle(Color(red: 119/255, green: 182/255, blue: 255/255).gradient.shadow(.inner(color: Color.black.opacity(0.4),radius: 10, x: -7, y: -11)))
                            .shadow(color: Color.gray.opacity(0), radius: 20, x: 20, y: 20)
                        
                            Heart()
                                .frame(width: 35, height: 35)
                                .rotationEffect(.degrees(30))
                                .foregroundStyle(Color(red: 254/255, green: 90/255, blue: 131/255).gradient.shadow(.inner(color: Color.black.opacity(0.4),radius: 4, x: -3, y: -3)))
                                .shadow(color: Color.gray.opacity(0), radius: 20, x: 20, y: 20)
                                .offset(x: 50, y: -100)
                                .scaleEffect(animatingHeart ? 0.9 : 1.4)
                                .scaleEffect(animatingHeart ? 1.4 : 0.9)
                        
                    }
                    else{
                        Ellipse()
                            .fill(.white.shadow(.inner(color: Color(red: 106/255, green: 166/255, blue: 234/255), radius: 15)) )
                            .frame(width: 275,height: 57)
                            .shadow(color: Color(red: 106/255, green: 166/255, blue: 234/255).opacity(0.5), radius: 10, y: 10)
                            .offset(y: 120)
                        Ellipse()
                              
                            .fill(.white.shadow(.inner(color: Color(red: 106/255, green: 166/255, blue: 234/255), radius: 15)) )
                              .frame(width: 225,height: 43)
                              .offset(y: 119)
                        Ellipse()
                            .fill(.white.shadow(.inner(color: Color(red: 106/255, green: 166/255, blue: 234/255), radius: 13)) )
                            .frame(width: 175,height: 30)
                            .offset(y: 118)
                        Drop()
                            .frame(width: 150, height: 250)
                            .foregroundStyle(Color(red: 119/255, green: 182/255, blue: 255/255).gradient.shadow(.inner(color: Color.black.opacity(0.4),radius: 10, x: -7, y: -11)))
                            .shadow(color: Color.gray.opacity(0), radius: 20, x: 20, y: 20)
                       
                            Heart()
                                .frame(width: 35, height: 35)
                                .rotationEffect(.degrees(30))
                                .foregroundStyle(Color(red: 254/255, green: 90/255, blue: 131/255).gradient.shadow(.inner(color: Color.black.opacity(0.4),radius: 4, x: -3, y: -3)))
                                .shadow(color: Color.gray.opacity(0), radius: 20, x: 20, y: 20)
                                .offset(x: 50, y: -100)
                                .scaleEffect(animatingHeart ? 0.9 : 1.4)
                                .scaleEffect(animatingHeart ? 1.4 : 0.9)
                        
                    }
                    
                }
               
                Spacer()
                HStack{
                    Spacer()
                    switch measure{
                    case 0 :
                        Text("\(String(format: "%.1f",pickerdata)) / \(String(format: "%.1f", consumption))")
                            .font(.system(size: 25, design: .default))
                            .fontWeight(.light)
                    case 1 :
                        Text("\(String(format: "%.0f",pickerdata)) / \(String(format: "%.0f",  consumption))")
                            .font(.system(size: 25, design: .default))
                            .fontWeight(.light)
                    case 2 :
                        Text("\(String(format: "%.0f", pickerdata)) / \(String(format: "%.0f", consumption))")
                            .font(.system(size: 25, design: .default))
                            .fontWeight(.light)
                    default:
                        Text("\(String(format: "%.1f",pickerdata)) / \(String(format: "%.1f", consumption))")
                            .font(.system(size: 25, design: .default))
                            .fontWeight(.light)
                    }
                    Spacer()
                    Spacer()
                    Spacer()
                    Button{
                        if canEdit == true{
                            canEdit = false
                            
                        }
                        else{
                            canEdit = true
                        }
                    } label:{
                        switch language{
                        case 0:
                            if canEdit == true{
                                Text("Save")
                                    .foregroundColor(Color(red: 254/255, green: 90/255, blue: 131/255))
                                    .fontWeight(.semibold)
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(Color(red: 254/255, green: 90/255, blue: 131/255))
                            }
                            else{
                                Text("Edit")
                                    .foregroundColor(Color(red: 254/255, green: 90/255, blue: 131/255))
                                    .fontWeight(.semibold)
                                
                                
                            }
                        case 1:
                            if canEdit == true{
                                Text("Mentés")
                                    .foregroundColor(Color(red: 254/255, green: 90/255, blue: 131/255))
                                    .fontWeight(.semibold)
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(Color(red: 254/255, green: 90/255, blue: 131/255))

                            }
                            else{
                                Text("Szerkesztés")
                                    .foregroundColor(Color(red: 254/255, green: 90/255, blue: 131/255))
                                    .fontWeight(.semibold)
                                
                            }
                        case 2:
                            if canEdit == true{
                                Text("Sichern")
                                    .foregroundColor(Color(red: 254/255, green: 90/255, blue: 131/255))
                                    .fontWeight(.semibold)
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(Color(red: 254/255, green: 90/255, blue: 131/255))

                            }
                            else{
                                Text("Bearbeiten")
                                    .foregroundColor(Color(red: 254/255, green: 90/255, blue: 131/255))
                                    .fontWeight(.semibold)
                               
                            }
                        default:
                            if canEdit == true{
                                Text("Save")
                                    .foregroundColor(Color.red)
                                    .fontWeight(.semibold)
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(Color(red: 254/255, green: 90/255, blue: 131/255))

                            }
                            else{
                                Text("Edit")
                                    .foregroundColor(Color.red)
                                    .fontWeight(.semibold)
                                Image(systemName: "eraser")
                                    .foregroundColor(Color(red: 254/255, green: 90/255, blue: 131/255))
                            }
                        }
                            
                    }
                    Spacer()
                    
                }
                
                //Spacer()
                HStack{
                    VStack{
                        
                        HStack{
                            Spacer()
                            VStack{
            //Button 1
                                ZStack{
                                    Button {
                                        if canEdit == true{
                                            
                                        }
                                        else{
                                            if firstnotebook == false{
                                                if Buttons.names[0] != "---"{
                                                    var i: Int = 0;
                                                    while Buttons.array![i].id != 1{
                                                        i += 1;
                                                    }
                                                    addNote(type: Buttons.array![i].type!, quantity: Buttons.array![i].quantity , M: Buttons.array![i].measure!)
                                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.1)){
                                                        animatingHeart.toggle()
                                                       
                                                    }
                                                }
                                            }
                                            
                                        }
                                        
                                    } label: {
                                        Text(Buttons.names[0])
                                            .frame(width: 150, height: 60, alignment: .center)
                                            .fontWeight(.light)
                                            .overlay(
                                                        RoundedRectangle(cornerRadius: 15)
                                                            .stroke(firstnotebook == false ? Color(red: 119/255, green: 182/255, blue: 255/255) : Color.black.opacity(0.3), lineWidth: 1)
                                                        )
                                            .foregroundColor(firstnotebook == false ? Color(red: 119/255, green: 182/255, blue: 255/255) : Color.black.opacity(0.3))
                                            .background(RoundedRectangle(cornerRadius: 15).fill(firstnotebook == false ? Color.white : Color.gray.opacity(0.3)))
                                            //.shadow(color: Color.gray.opacity(0.6) ,radius:5 , x: 5, y: 5)
                                            
                                    }
                                    .padding(5)
                                    if canEdit == true{
                                        Button(
                                            action: {
                                                showingPopover1 = true
                                                pressedButtonID = 1
                                            },
                                                 label:{
                                            Image(systemName: "eraser")
                                                .resizable()
                                                .frame(width: 20, height: 20, alignment: .center)
                                                .padding(5)
                                                .overlay(Circle()
                                                    .stroke(Color.black.opacity(0.9), lineWidth: 2))
                                                .foregroundColor(Color.white)
                                                .background(Circle().fill(Color.black.opacity(0.9)))
                                                
                                        })
                                        .offset(x: 70 ,y: -25 )
                                        .popover(isPresented: $showingPopover1 ){
                                            ButtonSetView(id: $pressedButtonID)
                                        }

                                    }
                                }
                                
            //Button 2
                                ZStack{
                                    Button {
                                        if canEdit == true{
                                            
                                        }
                                        else{
                                            if firstnotebook == false{
                                                if Buttons.names[1] != "---"{
                                                    var i: Int = 0;
                                                    while Buttons.array![i].id != 2{
                                                        i += 1;
                                                    }
                                                    addNote(type: Buttons.array![i].type!, quantity: Buttons.array![i].quantity , M: Buttons.array![i].measure!)
                                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.1)){
                                                        animatingHeart.toggle()
                                                       
                                                    }
                                                }
                                            }
                                            
                                        }
                                        
                                    } label: {
                                        Text(Buttons.names[1])
                                            .frame(width: 150, height: 60, alignment: .center)
                                            .fontWeight(.light)
                                            .overlay(
                                                        RoundedRectangle(cornerRadius: 15)
                                                            .stroke(firstnotebook == false ? Color(red: 119/255, green: 182/255, blue: 255/255) : Color.black.opacity(0.3), lineWidth: 1)
                                                        )
                                            .foregroundColor(firstnotebook == false ? Color(red: 119/255, green: 182/255, blue: 255/255) : Color.black.opacity(0.3))
                                            .background(RoundedRectangle(cornerRadius: 15).fill(firstnotebook == false ? Color.white : Color.gray.opacity(0.3)))
                                            
                                    }
                                    if canEdit == true{
                                        Button(
                                            action: {
                                                showingPopover2 = true
                                                pressedButtonID = 2
                                            },
                                                 label:{
                                            Image(systemName: "eraser")
                                                .resizable()
                                                .frame(width: 20, height: 20, alignment: .center)
                                                .padding(5)
                                                .overlay(Circle()
                                                    .stroke(Color.black.opacity(0.9), lineWidth: 2))
                                                .foregroundColor(Color.white)
                                                .background(Circle().fill(Color.black.opacity(0.9)))
                                                
                                        })
                                        .offset(x: 70 ,y: -25 )
                                        .popover(isPresented: $showingPopover2 ){
                                            ButtonSetView(id: $pressedButtonID)
                                        }
                                    }
                                    
                                    
                                }
                                
                            }
                            .padding(10)
                            
                            VStack{
            //Button 3
                                ZStack{
                                    Button {
                                        if canEdit == true{
                                            
                                        }
                                        else{
                                            if firstnotebook == false{
                                                if Buttons.names[2] != "---"{
                                                    var i: Int = 0;
                                                    while Buttons.array![i].id != 3{
                                                        i += 1;
                                                    }
                                                    addNote(type: Buttons.array![i].type!, quantity: Buttons.array![i].quantity , M: Buttons.array![i].measure!)
                                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.1)){
                                                        animatingHeart.toggle()
                                                       
                                                    }
                                                }
                                            }
                                            
                                        }
                                        
                                    } label: {
                                        Text(Buttons.names[2])
                                            .frame(width: 150, height: 60, alignment: .center)
                                            .fontWeight(.light)
                                            .overlay(
                                                        RoundedRectangle(cornerRadius: 15)
                                                            .stroke(firstnotebook == false ? Color(red: 119/255, green: 182/255, blue: 255/255) : Color.black.opacity(0.3), lineWidth: 1)
                                                        )
                                            .foregroundColor(firstnotebook == false ? Color(red: 119/255, green: 182/255, blue: 255/255) : Color.black.opacity(0.3))
                                            .background(RoundedRectangle(cornerRadius: 15).fill(firstnotebook == false ? Color.white : Color.gray.opacity(0.3)))
                                            //.shadow(color: Color.gray.opacity(0.6) ,radius:5 , x: 5, y: 5)
                                    }
                                    .padding(5)
                                    if canEdit == true{
                                        Button(
                                            action: {
                                                showingPopover3 = true
                                                pressedButtonID = 3
                                            },
                                                 label:{
                                            Image(systemName: "eraser")
                                                .resizable()
                                                .frame(width: 20, height: 20, alignment: .center)
                                                .padding(5)
                                                .overlay(Circle()
                                                    .stroke(Color.black.opacity(0.9), lineWidth: 2))
                                                .foregroundColor(Color.white)
                                                .background(Circle().fill(Color.black.opacity(0.9)))
                                                
                                        })
                                        .offset(x: 70 ,y: -25 )
                                        .popover(isPresented: $showingPopover3 ){
                                            ButtonSetView(id: $pressedButtonID)
                                        }
                                    }
                                }
                                
            //Button 4
                                ZStack{
                                    Button {
                                        if canEdit == true{
                                            
                                        }
                                        else{
                                            if firstnotebook == false{
                                                if Buttons.names[3] != "---"{
                                                    var i: Int = 0;
                                                    while Buttons.array![i].id != 4{
                                                        i += 1;
                                                    }
                                                    addNote(type: Buttons.array![i].type!, quantity: Buttons.array![i].quantity , M: Buttons.array![i].measure!)
                                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.1)){
                                                        animatingHeart.toggle()
                                                       
                                                    }
                                                }
                                            }
                                            
                                        }
                                    } label: {
                                        Text(Buttons.names[3])
                                            .frame(width: 150, height: 60, alignment: .center)
                                            .fontWeight(.light)
                                            .overlay(
                                                        RoundedRectangle(cornerRadius: 15)
                                                            .stroke(firstnotebook == false ? Color(red: 119/255, green: 182/255, blue: 255/255) : Color.black.opacity(0.3), lineWidth: 1)
                                                        )
                                            .foregroundColor(firstnotebook == false ? Color(red: 119/255, green: 182/255, blue: 255/255) : Color.black.opacity(0.3))
                                            .background(RoundedRectangle(cornerRadius: 15).fill(firstnotebook == false ? Color.white : Color.gray.opacity(0.3)))
                                            
                                            //.shadow(color: Color.gray.opacity(0.6) ,radius:5 , x: 5, y: 5)
                                        
                                        
                                    }
                                    if canEdit == true{
                                        Button(
                                            action: {
                                                showingPopover4 = true
                                                pressedButtonID = 4
                                            },
                                                 label:{
                                            Image(systemName: "eraser")
                                                .resizable()
                                                .frame(width: 20, height: 20, alignment: .center)
                                                .padding(5)
                                                .overlay(Circle()
                                                    .stroke(Color.black.opacity(0.9), lineWidth: 2))
                                                .foregroundColor(Color.white)
                                                .background(Circle().fill(Color.black.opacity(0.9)))
                                                
                                        })
                                        .offset(x: 70 ,y: -25 )
                                        .popover(isPresented: $showingPopover4 ){
                                            ButtonSetView(id: $pressedButtonID)
                                        }
                                    }
                                }
                            }
                            .padding(10)
                            Spacer()
                        }
            // Button 5
                        ZStack{
                            Button {
                                if canEdit == true{
                                    
                                }
                                else{
                                    if firstnotebook == true{
                                        addDay()
                                        firstnotebook = false
                                    }
                                }
                            } label: {
                                switch language{
                                case 0:
                                    Text("Today's notebook")
                                        .frame(width: 340, height: 60, alignment: .center)
                                        .fontWeight(.light)
                                        .overlay(
                                                    RoundedRectangle(cornerRadius: 20)
                                                        .stroke(Color(red: 119/255, green: 182/255, blue: 255/255), lineWidth: 1)
                                                    )
                                        .foregroundColor(Color(red: 119/255, green: 182/255, blue: 255/255))
                                        .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
                                case 1:
                                    Text("Mai jegyzetfüzet")
                                        .frame(width: 340, height: 60, alignment: .center)
                                        .fontWeight(.light)
                                        .overlay(
                                                    RoundedRectangle(cornerRadius: 20)
                                                        .stroke(Color(red: 119/255, green: 182/255, blue: 255/255), lineWidth: 1)
                                                    )
                                        .foregroundColor(Color(red: 119/255, green: 182/255, blue: 255/255))
                                        .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
                                case 2:
                                    Text("Heutiges Notizbuch")
                                        .frame(width: 340, height: 60, alignment: .center)
                                        .fontWeight(.light)
                                        .overlay(
                                                    RoundedRectangle(cornerRadius: 20)
                                                        .stroke(Color(red: 119/255, green: 182/255, blue: 255/255), lineWidth: 1)
                                                    )
                                        .foregroundColor(Color(red: 119/255, green: 182/255, blue: 255/255))
                                        .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
                                default:
                                    Text("Today's notebook")
                                        .frame(width: 340, height: 60, alignment: .center)
                                        .fontWeight(.light)
                                        .overlay(
                                                    RoundedRectangle(cornerRadius: 20)
                                                        .stroke(Color(red: 119/255, green: 182/255, blue: 255/255), lineWidth: 1)
                                                    )
                                        .foregroundColor(Color(red: 119/255, green: 182/255, blue: 255/255))
                                        .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
                                }
                            }
                            .padding(10)
                            if firstnotebook == false{
                                Image(systemName: "checkmark.circle")
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(Color(red: 254/255, green: 90/255, blue: 131/255))
                                    . offset(x: 90)
                            }
                            else{
                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(Color(red: 119/255, green: 182/255, blue: 255/255))
                                    . offset(x: 90)
                            }
                            
                        }
                        
                    }
                }
                
            }
            .onAppear(){
                language = self.userDefaults?.value(forKey: "Language") as? Int ?? 0
                measure = self.userDefaults?.value(forKey: "Measure") as? Int ?? 0
                firstnotebook = fetchDays()
                consumption = consumptionFetch()
                fetchButtons()
                switch measure{
                case 0:
                    pickerdata = self.userDefaults?.value(forKey: "PickerData") as? Double ?? 1.0
                case 1:
                    pickerdata = self.userDefaults?.value(forKey: "PickerData") as? Double ?? 35.0
                case 2:
                    pickerdata = self.userDefaults?.value(forKey: "PickerData") as? Double ?? 34.0
                default:
                    pickerdata = self.userDefaults?.value(forKey: "PickerData") as? Double ?? 1.0
                }
                
            }
            .environmentObject(Buttons)
            .background(Color(.systemGray6))
                    
    }
        
    private func fetchDays() -> Bool{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        var items: [Days]?
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "Y.M.d"
        let today:Date = Date()
        var firstNotebook: Bool = true
        do{
            items = try context.fetch(Days.fetchRequest())
            
            
             }
        catch{
            print(error.localizedDescription)
        }
        for a in items!{
            if dateFormatter.string(from: a.day!) == dateFormatter.string(from: today) {
                firstNotebook = false
            }
        }
        return firstNotebook
    }
                
    private func fetchButtons(){
        let fetchRequest: NSFetchRequest<CustomB> = CustomB.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: #keyPath(CustomB.id), ascending: true)
          fetchRequest.sortDescriptors = [sortDescriptor]
        do{
            Buttons.array = try context.fetch(fetchRequest)
        }
        catch{
            print(error.localizedDescription)
        }
        if Buttons.array != nil{
            for a in 0...3{
                Buttons.names[a] = "---"
            }
            var i: Int = 0
            for a in Buttons.array!{
                while i < a.id-1{
                    i += 1
                }
                print(i)
                switch a.measure{
                case "ml":
                    Buttons.names[i] = "\(String(format: "%.0f",a.quantity * 1000)) ml \(a.type ?? "")"
                case "dl":
                    Buttons.names[i] = "\(String(format: "%.0f",a.quantity * 10)) dl \(a.type ?? "")"
                case "l":
                    Buttons.names[i] = "\(String(format: "%.0f",a.quantity)) l \(a.type ?? "")"
                case "Oz(uk)":
                    Buttons.names[i] = "\(String(format: "%.0f",a.quantity)) Oz(uk) \(a.type ?? "")"
                case "Oz(us)":
                    Buttons.names[i] = "\(String(format: "%.0f",a.quantity)) Oz(us) \(a.type ?? "")"
                default:
                    Buttons.names[i] = "\(String(format: "%.0f",a.quantity)) l \(a.type ?? "")"
                }
                i = 0
             }
            }
            else {
                for a in 0...3{
                    Buttons.names[a] = "---"
                }
            }
        }
    private func addDay() {
        withAnimation {
                let newItem = Days(context: context)
                newItem.day = Date()
                newItem.consumption = 0.0
            // Widget
                userDefaults2?.set(newItem.consumption, forKey: "self.day.consumption")
                WidgetCenter.shared.reloadAllTimelines()
                switch self.userDefaults?.value(forKey: "Measure"){
                case 0 as Int:
                    newItem.measure = 0
                case 1 as Int:
                    newItem.measure = 1
                case 2 as Int:
                    newItem.measure = 2
                default:
                    newItem.measure = 0
                }
                do {
                    try context.save()
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            DaysTableViewController().newSection()
        }
        
    }
    private func consumptionFetch() -> Double {
        var items: [Days]?
        let fetchRequest: NSFetchRequest<Days> = Days.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Days.day), ascending: false)
          fetchRequest.sortDescriptors = [sortDescriptor]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "Y.MM.d"
        do{
            items = try context.fetch(fetchRequest)
        }
        catch{
            print(error.localizedDescription)
        }
        if items?.count == 0{
            return 0.0
        }
        else{
            print(dateFormatter.string(from: items![0].day!))
            if dateFormatter.string(from: items![0].day!) == dateFormatter.string(from: Date()){
                return items?[0].consumption ?? 0.0
            }
            else{
                return 0.0
            }
        }
    }
    private func addNote(type: String, quantity: Double, M: String) {
        withAnimation {
            var items: [Days]?
            let fetchRequest: NSFetchRequest<Days> = Days.fetchRequest()
            let dateFormatter = DateFormatter()
            dateFormatter.date(from: "Y.M.d")
            let sortDescriptor = NSSortDescriptor(key: #keyPath(Days.day), ascending: false)
              fetchRequest.sortDescriptors = [sortDescriptor]
            do{
                items = try context.fetch(fetchRequest)
            }
            catch{
                print(error.localizedDescription)
            }
            let newItem = Notes(context: context)
            newItem.quantity = quantity
            newItem.drink = type
            if items?[0] != nil{
                newItem.day = items?[0]
                items?[0].consumption += quantity
                //Widget
                self.userDefaults2?.set(items?[0].consumption, forKey: "self.day.consumption")
                WidgetCenter.shared.reloadAllTimelines()
            }
            switch M{
            case "ml":
                newItem.measure = 0
            case "dl":
                newItem.measure = 0
            case "l":
                newItem.measure = 0
            case "Oz(uk)":
                newItem.measure = 1
            case "Oz(us)":
                newItem.measure = 2
            default:
                newItem.measure = 0
            }
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
        consumption = consumptionFetch()
        
        
    }
}
struct Drop: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.53191*width, y: 0))
        path.addCurve(to: CGPoint(x: 0.2077*width, y: 0.35684*height), control1: CGPoint(x: 0.53191*width, y: 0), control2: CGPoint(x: 0.29616*width, y: 0.25208*height))
        path.addCurve(to: CGPoint(x: 0.02302*width, y: 0.63853*height), control1: CGPoint(x: 0.11923*width, y: 0.4616*height), control2: CGPoint(x: 0.0816*width, y: 0.50101*height))
        path.addCurve(to: CGPoint(x: 0.12752*width, y: 0.91853*height), control1: CGPoint(x: -0.03556*width, y: 0.77605*height), control2: CGPoint(x: 0.02433*width, y: 0.8663*height))
        path.addCurve(to: CGPoint(x: 0.53191*width, y: 0.98871*height), control1: CGPoint(x: 0.23072*width, y: 0.97076*height), control2: CGPoint(x: 0.36323*width, y: 0.98871*height))
        path.addCurve(to: CGPoint(x: 0.94457*width, y: 0.85233*height), control1: CGPoint(x: 0.70059*width, y: 0.98871*height), control2: CGPoint(x: 0.88107*width, y: 0.93686*height))
        path.addCurve(to: CGPoint(x: 0.96774*width, y: 0.64817*height), control1: CGPoint(x: 1.00806*width, y: 0.76779*height), control2: CGPoint(x: 0.99726*width, y: 0.71914*height))
        path.addCurve(to: CGPoint(x: 0.8102*width, y: 0.48865*height), control1: CGPoint(x: 0.93821*width, y: 0.5772*height), control2: CGPoint(x: 0.89254*width, y: 0.54267*height))
        path.addCurve(to: CGPoint(x: 0.60345*width, y: 0.30882*height), control1: CGPoint(x: 0.72786*width, y: 0.43463*height), control2: CGPoint(x: 0.65122*width, y: 0.38383*height))
        path.addCurve(to: CGPoint(x: 0.55246*width, y: 0.17767*height), control1: CGPoint(x: 0.58345*width, y: 0.27742*height), control2: CGPoint(x: 0.57301*width, y: 0.23574*height))
        path.addCurve(to: CGPoint(x: 0.53191*width, y: 0.05236*height), control1: CGPoint(x: 0.53876*width, y: 0.13897*height), control2: CGPoint(x: 0.53191*width, y: 0.09719*height))
        path.addCurve(to: CGPoint(x: 0.53191*width, y: 0), control1: CGPoint(x: 0.53191*width, y: 0.01745*height), control2: CGPoint(x: 0.53191*width, y: 0))
        path.closeSubpath()
        return path
        
        }
     }
struct Heart: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 1.16118*width, y: 0.3974*height))
        path.addCurve(to: CGPoint(x: 0.97454*width, y: 0.50592*height), control1: CGPoint(x: 1.08163*width, y: 0.41599*height), control2: CGPoint(x: 0.97454*width, y: 0.50592*height))
        path.addCurve(to: CGPoint(x: 0.78001*width, y: 0.3974*height), control1: CGPoint(x: 0.97454*width, y: 0.50592*height), control2: CGPoint(x: 0.88112*width, y: 0.41867*height))
        path.addCurve(to: CGPoint(x: 0.53999*width, y: 0.4757*height), control1: CGPoint(x: 0.67889*width, y: 0.37612*height), control2: CGPoint(x: 0.58355*width, y: 0.42035*height))
        path.addCurve(to: CGPoint(x: 0.53999*width, y: 0.79224*height), control1: CGPoint(x: 0.49642*width, y: 0.53105*height), control2: CGPoint(x: 0.45995*width, y: 0.65478*height))
        path.addCurve(to: CGPoint(x: 0.97454*width, y: 1.38444*height), control1: CGPoint(x: 0.59335*width, y: 0.88388*height), control2: CGPoint(x: 0.7382*width, y: 1.08128*height))
        path.addCurve(to: CGPoint(x: 1.42973*width, y: 0.79224*height), control1: CGPoint(x: 1.23863*width, y: 1.06657*height), control2: CGPoint(x: 1.39037*width, y: 0.86917*height))
        path.addCurve(to: CGPoint(x: 1.42973*width, y: 0.4757*height), control1: CGPoint(x: 1.48879*width, y: 0.67685*height), control2: CGPoint(x: 1.50847*width, y: 0.5726*height))
        path.addCurve(to: CGPoint(x: 1.16118*width, y: 0.3974*height), control1: CGPoint(x: 1.351*width, y: 0.3788*height), control2: CGPoint(x: 1.24072*width, y: 0.3788*height))
        path.closeSubpath()
        return path
    }
}
struct TodaysView_Previews: PreviewProvider {
    static var previews: some View {
        TodaysView()
    }
}
extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
}

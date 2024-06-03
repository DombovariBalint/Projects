//
//  SmallSizeView.swift
//  ProgressWidgetExtension
//
//  Created by Balint Dombovari on 2022. 11. 16..
//

import SwiftUI
import WidgetKit
struct SmallSizeView: View {

    var entry: SimpleEntry
    
    init(entry:SimpleEntry)
      {
            self.entry = entry
          
      }
        var body: some View {
            
            VStack{
                
                switch entry.language{
                case 0:Text("Today")
                        .font(.system(size: 20, design: .default))
                        .fontWeight(.ultraLight)
                        .padding()
                        
                case 1:Text("Mai nap")
                        .font(.system(size: 20, design: .default))
                        .fontWeight(.ultraLight)
                        .padding()
                        
                case 2:Text("Heute")
                        .font(.system(size: 20, design: .default))
                        .fontWeight(.ultraLight)
                        .padding()
                        
                default:
                    Text("Today")
                        .font(.system(size: 20, design: .default))
                        .fontWeight(.ultraLight)
                        .padding()
                        
                }
                
                ZStack{
                    if entry.consumption >= entry.goal{
                        ZStack{
                            if UIScreen.screenWidth == 375 && UIScreen.screenHeight == 667{
                                Ellipse()
                                    .fill(.white.shadow(.inner(color: Color(red: 106/255, green: 166/255, blue: 234/255), radius: 6)) )
                                    .frame(width: 73.3,height: 19.55)
                                    .shadow(color: Color(red: 106/255, green: 166/255, blue: 234/255).opacity(0.5), radius: 3, y: 3)
                                    .offset(y: 35)
                                Ellipse()
                                      
                                    .fill(.white.shadow(.inner(color: Color(red: 106/255, green: 166/255, blue: 234/255), radius: 5)) )
                                    .frame(width: 60,height: 13.34)
                                      .offset(y: 34)
                                Ellipse()
                                    .fill(.white.shadow(.inner(color: Color(red: 106/255, green: 166/255, blue: 234/255), radius: 4)) )
                                    .frame(width: 46.67,height: 8)
                                    .offset(y: 33)
                                Drop()
                                    
                                    .frame(width: 40, height: 66.67)
                                    //.foregroundColor(Color(red: 119/255, green: 182/255, blue: 255/255))
                                    .foregroundStyle(Color(red: 119/255, green: 182/255, blue: 255/255).gradient.shadow(.inner(color: Color.black.opacity(0.4),radius: 3, x: -3, y: -3)))
                                    .shadow(color: Color.gray.opacity(0), radius: 0, x: 20, y: 20)
                                Heart()
                                    .frame(width: 17, height: 17)
                                    //.foregroundColor(Color(red: 254/255, green: 90/255, blue: 131/255))
                                    .foregroundStyle(Color(red: 254/255, green: 90/255, blue: 131/255).gradient.shadow(.inner(color: Color.black.opacity(0.35),radius: 2, x: -2, y: -2)))
                                    .rotationEffect(.degrees(30))
                                    .offset(x: 20, y: -45)
                            }
                            else{
                                Ellipse()
                                    .fill(.white.shadow(.inner(color: Color(red: 106/255, green: 166/255, blue: 234/255), radius: 6)) )
                                    .frame(width: 82.5,height: 22)
                                    .shadow(color: Color(red: 106/255, green: 166/255, blue: 234/255).opacity(0.5), radius: 3, y: 3)
                                    .offset(y: 37)
                                Ellipse()
                                      
                                    .fill(.white.shadow(.inner(color: Color(red: 106/255, green: 166/255, blue: 234/255), radius: 5)) )
                                    .frame(width: 67.5,height: 15)
                                      .offset(y: 36)
                                Ellipse()
                                    .fill(.white.shadow(.inner(color: Color(red: 106/255, green: 166/255, blue: 234/255), radius: 4)) )
                                    .frame(width: 52.5,height: 9)
                                    .offset(y: 36)
                                Drop()
                                    
                                    .frame(width: 45, height: 75)
                                    //.foregroundColor(Color(red: 119/255, green: 182/255, blue: 255/255))
                                    .foregroundStyle(Color(red: 119/255, green: 182/255, blue: 255/255).gradient.shadow(.inner(color: Color.black.opacity(0.4),radius: 3, x: -3, y: -3)))
                                    .shadow(color: Color.gray.opacity(0), radius: 0, x: 20, y: 20)
                                Heart()
                                    .frame(width: 20, height: 20)
                                    //.foregroundColor(Color(red: 254/255, green: 90/255, blue: 131/255))
                                    .foregroundStyle(Color(red: 254/255, green: 90/255, blue: 131/255).gradient.shadow(.inner(color: Color.black.opacity(0.35),radius: 2, x: -2, y: -2)))
                                    .rotationEffect(.degrees(30))
                                    .offset(x: 20, y: -50)
                            }
                            
                        }
                    
                }
                else{
                    if UIScreen.screenWidth == 375 && UIScreen.screenHeight == 667{
                        Drop()
                             .stroke(Color.gray.opacity(0.2), lineWidth: 3)
                             .frame(width: 40,height: 66.67)
                             
                         Drop()
                             .trim(from: 0.0, to: (entry.consumption/entry.goal))
                             .stroke(Color(red: 119/255, green: 182/255, blue: 255/255) ,style: StrokeStyle( lineWidth: 3, lineCap: .round))
                             .frame(width: 40, height: 66.67)
                              
                         switch entry.measure{
                         case 0:
                             Text("\(String(format: "%.1f",entry.consumption))")
                                 .font(.system(size: 13, design: .default))
                                 .fontWeight(.ultraLight)
                                 .offset(y: 15)
                         case 1:
                             Text("\(String(format: "%.0f",entry.consumption))")
                                 .font(.system(size: 13, design: .default))
                                 .fontWeight(.ultraLight)
                                 .offset(y: 15)
                         case 2:
                             Text("\(String(format: "%.0f",entry.consumption))")
                                 .font(.system(size: 13, design: .default))
                                 .fontWeight(.ultraLight)
                                 .offset(y: 15)
                         default:
                             Text("\(String(format: "%.1f",entry.consumption))")
                                 .font(.system(size: 13, design: .default))
                                 .fontWeight(.ultraLight)
                                 .offset(y: 15)
                         }
                    }
                    else{
                        Drop()
                             .stroke(Color.gray.opacity(0.2), lineWidth: 3)
                             .frame(width: 45,height: 75)
                             
                         Drop()
                             .trim(from: 0.0, to: (entry.consumption/entry.goal))
                             .stroke(Color(red: 119/255, green: 182/255, blue: 255/255) ,style: StrokeStyle( lineWidth: 3, lineCap: .round))
                             .frame(width: 45, height: 75)
                              
                         switch entry.measure{
                         case 0:
                             Text("\(String(format: "%.1f",entry.consumption))")
                                 .font(.system(size: 15, design: .default))
                                 .fontWeight(.ultraLight)
                                 .offset(y: 15)
                         case 1:
                             Text("\(String(format: "%.0f",entry.consumption))")
                                 .font(.system(size: 15, design: .default))
                                 .fontWeight(.ultraLight)
                                 .offset(y: 15)
                         case 2:
                             Text("\(String(format: "%.0f",entry.consumption))")
                                 .font(.system(size: 15, design: .default))
                                 .fontWeight(.ultraLight)
                                 .offset(y: 15)
                         default:
                             Text("\(String(format: "%.1f",entry.consumption))")
                                 .font(.system(size: 15, design: .default))
                                 .fontWeight(.ultraLight)
                                 .offset(y: 15)
                         }
                    }
                }
                    
                 }
                Spacer()
                Spacer()
                }
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
extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   
}

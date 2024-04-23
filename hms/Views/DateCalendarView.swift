//
//  DatePicker.swift
//  hms
//
//  Created by srijan mishra on 22/04/24.
//
import SwiftUI

class Booking : ObservableObject{
    @Published var index : Int = 0
    @Published var date : Date = Date()
    
}

let booking : Booking = Booking()

struct DateCalendarView: View {
    
    //    #A1A8B0
    @State private var dayColor:Color = Color(red: 161/255, green: 168/255, blue: 176/255)
    //     #101623
    @State private var dateColor:Color = Color(red: 16/255, green: 22/255, blue: 35/255)
    
    func dateGetter(index : Int) -> Date{
        return Calendar.current.date(byAdding: .day, value: index, to: Date())!
    }
    @State private var bgColor:Color = Color(red: 242/255, green: 242/255, blue: 242/255)
    @State private var symptomsColor:Color = Color(red: 157/255, green: 159/255, blue: 159/255)
    @State private var timeArray:[String] = ["10:00","10:30","11:00","11:30","12:00","5:00","5:30","6:00","6:30","7:00"]
    
    @State private var headingColor:Color = Color(red: 28/255, green: 28/255, blue: 28/255)
    
    
    
    func getDay(date : Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: date)
    }
    func getDate(date : Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: date)
    }
    @ObservedObject var indexDate = booking
    let columns : [GridItem] = [GridItem(.fixed( 2)),
                                GridItem(.flexible())
    ]
    @StateObject var temp = Booking()
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false){
            HStack{
                ForEach(0..<7){ i in
                    
                    let date = dateGetter(index: i)
                    if i != indexDate.index{
                        Button {
                            withAnimation {
                                indexDate.index = i
                            }
                            temp.date = date
                            
                            print(temp.date)
                            
                        } label: {
                            VStack{
                                Text((getDay(date: date)))
                                    .font(Font.custom("SF Pro Display Regular", size: 16))
                                    .foregroundColor(dayColor)
                                
                                
                                Text((getDate(date: date)))
                                    .font(Font.custom("SF Pro Display ", size: 18))
                                    .foregroundColor(dateColor)
                            }.frame(alignment: .center)
                                .padding(.leading)
                            
                                .background{
                                    RoundedRectangle(cornerRadius: 15)
                                        .frame(width:64,height: 80)
                                        .foregroundColor(.white)
                                        .padding(.leading)
                                }
                                .padding()
                        }
                        
                    }
                    else{
                        Button {
                            withAnimation {
                                indexDate.index = i
                            }
                            
                        } label: {
                            VStack{
                                Text((getDay(date: date)))
                                    .font(Font.custom("SF Pro Display Regular", size: 16))
                                    .foregroundColor(.white)
                                
                                Text((getDate(date: date)))
                                    .font(Font.custom("SF Pro Display ", size: 18))
                                    .foregroundColor(.white)
                            }.frame(alignment: .center)
                                .padding(.leading)
                                .background{
                                    RoundedRectangle(cornerRadius: 15)
                                        .frame(width:64,height: 80)
                                        .foregroundColor(.blue)
                                        .padding(.leading)
                                }
                                .padding()
                        }
                    }
                }
            }
            .frame(height: 85)
            .padding(.bottom)
            .padding(.trailing,16)
            Divider()
        }
        
        
    }
}

#Preview {
    DateCalendarView()
}

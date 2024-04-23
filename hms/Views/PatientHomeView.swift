//
//  PatientHomeVIew.swift
//  HMS-Team 5
//
//  Created by Ishan on 22/04/24.
//

import SwiftUI

struct PatientHomeView: View {

    var body: some View {
        NavigationView {
            VStack{

                ZStack{
                    Rectangle()
                        .foregroundStyle(Color("bg-color1"))
                        .frame(height: UIScreen.main.bounds.size.height * 0.30)
                    
                    VStack{
                        
                        Text("Good Morning, Nancy")
                            .foregroundStyle(Color.white)
                            .font(.system(size: 20))
                            .opacity(0.8)
                            .padding(.trailing, 25)
                        
                        Text("Welcome Back")
                            .foregroundStyle(Color.white)
                            .font(.system(size: 32))
                            .bold()
                    }
                    .padding(.trailing, UIScreen.main.bounds.size.height * 0.15)
                    
                }
                
                DoctorCardList()
            }
            .ignoresSafeArea(.all)
        }
    }
}

struct PatientHomeView_Previews: PreviewProvider {
    static var previews: some View {
        PatientHomeView()
    }
}

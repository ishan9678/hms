//
//  DoctorCardList.swift
//  HMS-Team 5
//
//  Created by Ishan on 22/04/24.
//

import SwiftUI

struct DoctorCardList: View {
    @ObservedObject var doctorsViewModel = DoctorsViewModel()
    
    var body: some View {
        VStack{
            HStack {
                Text("Find your doctor")
                    .padding(.leading, 25)
                    .font(.headline)
                Spacer()
                Button("See all") {}
                    .padding(.trailing, 25)
                    .font(.headline)
            }
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    ForEach(doctorsViewModel.doctors, id: \.id) { doctor in
                        VStack(alignment: .leading) {
                            AsyncImage(url: URL(string: doctor.image)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 130, height: 130)
                                        .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                                    Text(doctor.name)
                                        .font(.headline)
                                    Text(doctor.department)
                                        .font(.subheadline)
                                case .failure:
                                    Image(systemName: "person.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        }
                        .padding(.vertical)
                    }
                }
                .padding(.horizontal)
            }
            .onAppear {
                doctorsViewModel.fetchDoctors()
                print(doctorsViewModel.fetchDoctors())
            }
        }
    }
}


struct DoctorCardList_Previews: PreviewProvider {
    static var previews: some View {
        DoctorCardList()
    }
}

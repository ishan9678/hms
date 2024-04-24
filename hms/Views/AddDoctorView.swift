//
//  AddDoctorView.swift
//  hms
//
//  Created by Divyanshu Pabia on 23/04/24.
//

import SwiftUI

struct AddDoctorView: View {
    
    //Personal Details
    @State var fullName: String = ""
    @State private var gender = 0
    @State private var dateofbirth = Date()
    @State var emailTextField: String = ""
    @State var phoneTextField: String = ""
    @State var emergencyContactTextField: String = ""
    
    // Professional Information
    @State var employeeID: String = ""
    @State private var department = 0
    @State var qualification: String = ""
    @State var position: String = ""
    @State var startDate: Date = Date()


    // Professional Licenses
    @State var licenseNumber: String = ""
    @State var issuingOrganization: String = ""
    @State var expiryDate: Date = Date()

    // Description
    @State var description: String = ""
    @State var yearsOfExperience: String = ""
    
    

    let chosenGender = ["Female","Male","Prefer not to disclose"]

    let chosenDept = [
        "Emergency Medicine", // Provides immediate care for acute illnesses and injuries.
        "General Surgery",    // Handles a wide range of common ailments requiring surgical intervention.
        "Cardiology",         // Manages disorders of the heart and blood vessels.
        "Obstetrics & Gynecology", // Cares for reproductive health, childbirth, and females
        "Pediatrics",         // Focuses on the medical care of infants, children, and adolescents.
        "Oncology",           // Specializes in the diagnosis and treatment of cancer.
        "Neurology",          // Focuses on diseases of the nervous system.
        "Orthopedics",        // Concerned with conditions involving the musculoskeletal system.
        "Radiology",          // Essential for diagnostics using imaging technologies.
        "Internal Medicine"   // Deals with the prevention, diagnosis, and treatment of adult diseases.
    ]
   
    @StateObject var addDoctorVM = AddDoctorsViewModel()
    
    
    var body: some View {
        Text("Add Doctor")
            .font(.title)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity,alignment: .center)
        
            Form {
                Section(header: Text("Personal Details")) {
                    TextField("Full Name", text: $fullName)
                    DatePicker("Date of Birth", selection: $dateofbirth, displayedComponents: .date)
                    Picker("Gender", selection: $gender) {
                        ForEach(0..<chosenGender.count, id: \.self) { index in
                            Text(self.chosenGender[index]).tag(index)
                        }
                    }
                    TextField("Email", text: $emailTextField)
                    TextField("Phone Number", text: $phoneTextField)
                    TextField("Emergency Contact", text: $emergencyContactTextField)
                }

                Section(header: Text("Professional Details")) {
                    TextField("Employee ID", text: $employeeID)
                    Picker("Department", selection: $department) {
                        ForEach(0..<chosenDept.count, id: \.self) { index in
                            Text(self.chosenDept[index]).tag(index)
                        }
                    }
                    TextField("Qualification", text: $qualification)
                    TextField("Position", text: $position)
                    DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                }

                Section(header: Text("Professional Licenses")) {
                    TextField("License Number", text: $licenseNumber)
                    TextField("Issuing Organization", text: $issuingOrganization)
                    DatePicker("Expiry Date", selection: $expiryDate, displayedComponents: .date)
                }

                Section(header: Text("Details")) {
                    TextField("Description", text: $description)
                    TextField("Years of Experience", text: $yearsOfExperience)
                }
                
                Button(action: {
                                
                    let newDoctor = Doctor(
                        fullName: fullName,
                        gender: chosenGender[gender],
                        dateOfBirth: dateofbirth,
                        email: emailTextField,
                        phone: phoneTextField,
                        emergencyContact: emergencyContactTextField,
                        employeeID: employeeID,
                        department: chosenDept[department],
                        qualification: qualification,
                        position: position,
                        startDate: startDate,
                        licenseNumber: licenseNumber,
                        issuingOrganization: issuingOrganization,
                        expiryDate: expiryDate,
                        description: description,
                        yearsOfExperience: yearsOfExperience
                    )
                                
                                addDoctorVM.addDoctor(doctor: newDoctor)
                            }) {
                                Text("Save")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(width: 280, height: 48)
                                    .background(Color.blue)
                                    .cornerRadius(15)
                            }
            }
        }
}

#Preview {
    AddDoctorView()
}

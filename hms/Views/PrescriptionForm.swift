//
//  PrescriptionForm.swift
//  hms
//
//  Created by srijan mishra on 23/04/24.
//
import SwiftUI

struct MedicineDetails {
    var dosage: Int = 1
    var selectedTimesOfDay: [String] = []
    var toBeTaken: String = "After Food"
}

struct Medicine: Identifiable {
    let id = UUID()
    let name: String
    let details: String
    var medicineDetails = MedicineDetails()
}

struct Test: Identifiable {
    let id = UUID()
    let name: String
}

struct PrescriptionForm: View {
    @State private var symptoms = ""
    @State private var diagnosis = ""
    @State private var medicines: [Medicine] = []
    @State private var tests: [Test] = []
    @State private var selectedMedicine: Medicine? = nil
    @State private var selectedTest: Test? = nil
    @State private var dosage = 1
    @State private var selectedTimesOfDay: [String] = []
    @State private var toBeTaken = "After Food"
    @State private var referralDepartments: [String: Bool] = [
        "Cardiology": false,
        "Orthopedics": false,
        "Neurology": false,
        // Add more departments as needed
    ]
    @State private var searchTextMedicine = ""
    @State private var searchTextTest = ""
    @State private var isEditingMedicine = false
    @State private var isEditingTest = false
    @State private var isEditingDetails = false
    
    let medicineList: [Medicine] = [
        Medicine(name: "Paracetamol", details: "For fever and pain relief"),
        Medicine(name: "Amoxicillin", details: "Antibiotic for bacterial infections"),
        Medicine(name: "Lisinopril", details: "For high blood pressure"),
        Medicine(name: "Partamol", details: "For fever and pain relief"),
        Medicine(name: "Paracamol", details: "For fever and pain relief"),
        Medicine(name: "etamol", details: "For fever and pain relief"),
        Medicine(name: "Psudhikj", details: "For fever and pain relief"),
        Medicine(name: "tamol", details: "For fever and pain relief")
        // Add more medicines as needed
    ]
    
    let testList: [Test] = [
        Test(name: "Blood Test"),
        Test(name: "X-Ray"),
        Test(name: "MRI"),
        Test(name: "CT Scan"),
        // Add more tests as needed
    ]
    
    var filteredMedicines: [Medicine] {
        if searchTextMedicine.isEmpty {
            return medicineList
        } else {
            return medicineList.filter { $0.name.lowercased().contains(searchTextMedicine.lowercased()) }
        }
    }
    
    var filteredTests: [Test] {
        if searchTextTest.isEmpty {
            return testList
        } else {
            return testList.filter { $0.name.lowercased().contains(searchTextTest.lowercased()) }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Symptoms")
                TextField("Enter symptoms", text: $symptoms)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Diagnosis")
                TextField("Enter diagnosis", text: $diagnosis)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Medication")
                VStack(alignment: .leading, spacing: 10) {
                    VStack(alignment: .leading, spacing: 10) {
                        TextField("Search for medicine", text: $searchTextMedicine, onEditingChanged: { editing in
                            self.isEditingMedicine = editing
                        })
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .overlay(
                            HStack {
                                Spacer()
                                if isEditingMedicine {
                                    Button(action: {
                                        self.searchTextMedicine = ""
                                        self.isEditingMedicine = false
                                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                    }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.gray)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 5)
                                            .background(Color.white)
                                            .cornerRadius(20)
                                            .padding(.trailing, 8)
                                    }
                                }
                            }
                        )
                        .padding(.vertical, 8)
                        .padding(.horizontal, 10)
                        .background(Color.white)
                        .cornerRadius(8)
                        
                        if !medicines.isEmpty {
                            ForEach(medicines) { medicine in
                                VStack(alignment: .leading, spacing: 5) {
                                    HStack {
                                        Text("\(medicine.name)").bold()
                                        Spacer()
                                        Button(action: {
                                            self.selectedMedicine = medicine
                                            self.isEditingDetails.toggle()
                                        }) {
                                            Image(systemName: "arrowtriangle.down.fill")
                                                .foregroundColor(.blue)
                                        }
                                        Button(action: {
                                            self.medicines.removeAll { $0.id == medicine.id }
                                        }) {
                                            Image(systemName: "trash")
                                                .foregroundColor(.red)
                                        }
                                    }
                                    if isEditingDetails && selectedMedicine?.id == medicine.id {
                                        Text("Dosage")
                                        HStack {
                                            Button(action: {
                                                // Functionality to increase dosage
                                                self.medicines[self.medicines.firstIndex(where: { $0.id == medicine.id })!].medicineDetails.dosage += 1
                                            }) {
                                                Text("+")
                                                    .foregroundColor(.blue)
                                                    .padding()
                                                    .background(RoundedRectangle(cornerRadius: 5).stroke(Color.blue, lineWidth: 1))
                                            }
                                            
                                            Text("\(medicine.medicineDetails.dosage) tablet")
                                            
                                            Button(action: {
                                                // Functionality to decrease dosage
                                                if medicine.medicineDetails.dosage > 1 {
                                                    self.medicines[self.medicines.firstIndex(where: { $0.id == medicine.id })!].medicineDetails.dosage -= 1
                                                }
                                            }) {
                                                Text("-")
                                                    .foregroundColor(.blue)
                                                    .padding()
                                                    .background(RoundedRectangle(cornerRadius: 5).stroke(Color.blue, lineWidth: 1))
                                            }
                                        }
                                        Text("Time of the Day")
                                        HStack {
                                            ForEach(["Morning", "Noon", "Night"], id: \.self) { time in
                                                Button(action:{
                                                    if medicine.medicineDetails.selectedTimesOfDay.contains(time){
                                                        self.medicines[self.medicines.firstIndex(where: { $0.id == medicine.id })!].medicineDetails.selectedTimesOfDay.removeAll(where: {$0 == time})
                                                    }
                                                    else{
                                                        self.medicines[self.medicines.firstIndex(where: { $0.id == medicine.id })!].medicineDetails.selectedTimesOfDay.append(time)
                                                    }
                                                }){
                                                    Text(time)
                                                        .padding(8)
                                                        .background(RoundedRectangle(cornerRadius: 5).stroke(medicine.medicineDetails.selectedTimesOfDay.contains(time) ? Color.red : Color.gray, lineWidth: 5))
                                                }
                                            }
                                        }
                                        Text("To be Taken")
                                        Picker("To be Taken", selection: $toBeTaken) {
                                            Text("After Food").tag("After Food")
                                            Text("Before Food").tag("Before Food")
                                        }
                                        .pickerStyle(SegmentedPickerStyle())
                                    }
                                }
                                .padding(.vertical, 5)
                                .background(Color.secondary.opacity(0.1))
                                .cornerRadius(8)
                            }
                        }
                        
                        if isEditingMedicine {
                            List(filteredMedicines) { medicine in
                                Button(action: {
                                    self.medicines.append(medicine)
                                    self.isEditingMedicine = false
                                    self.searchTextMedicine = ""
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                }) {
                                    Text(medicine.name)
                                }
                            }
                            .listStyle(PlainListStyle())
                        }
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Tests")
                VStack(alignment: .leading, spacing: 10) {
                    VStack(alignment: .leading, spacing: 10) {
                        TextField("Search for test", text: $searchTextTest, onEditingChanged: { editing in
                            self.isEditingTest = editing
                        })
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .overlay(
                            HStack {
                                Spacer()
                                if isEditingTest {
                                    Button(action: {
                                        self.searchTextTest = ""
                                        self.isEditingTest = false
                                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                    }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.gray)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 5)
                                            .background(Color.white)
                                            .cornerRadius(20)
                                            .padding(.trailing, 8)
                                    }
                                }
                            }
                        )
                        .padding(.vertical, 8)
                        .padding(.horizontal, 10)
                        .background(Color.white)
                        .cornerRadius(8)
                        
                        if !tests.isEmpty {
                            ForEach(tests) { test in
                                VStack(alignment: .leading, spacing: 5) {
                                    HStack {
                                        Text("\(test.name)").bold()
                                        Spacer()
                                      
                                        Button(action: {
                                            self.tests.removeAll { $0.id == test.id }
                                        }) {
                                            Image(systemName: "trash")
                                                .foregroundColor(.red)
                                        }
                                    }
                                }
                                .padding(.vertical, 5)
                                .background(Color.secondary.opacity(0.1))
                                .cornerRadius(8)
                            }
                        }
                        
                        if isEditingTest {
                            List(filteredTests) { test in
                                Button(action: {
                                    self.tests.append(test)
                                    self.isEditingTest = false
                                    self.searchTextTest = ""
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                }) {
                                    Text(test.name)
                                }
                            }
                            .listStyle(PlainListStyle())
                        }
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Referral")
            }
            
            Spacer()
        }
        .padding()
        .background(Color(red: 239/255, green: 239/255, blue: 239/255))
        .cornerRadius(10)
        .padding()
    }
}

struct PrescriptionForm_Previews: PreviewProvider {
    static var previews: some View {
        PrescriptionForm()
    }
}

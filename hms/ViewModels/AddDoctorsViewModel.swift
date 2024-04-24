//
//  DoctorsViewModel.swift
//  HMS-Team 5
//
//  Created by Ishan on 22/04/24.
//

import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class AddDoctorsViewModel: ObservableObject {
    @Published var doctors: [Doctor] = []

    private var db = Firestore.firestore()

    func fetchDoctors() {
        db.collection("doctors").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else if let querySnapshot = querySnapshot {
                // Initialize an empty array to store fetched doctors
                var fetchedDoctors: [Doctor] = []

                // Iterate over each document returned from the Firestore collection
                for document in querySnapshot.documents {
                    do {
                        // Attempt to decode the document into a Doctor object
                        // Note: Make sure the Doctor model conforms to Decodable or is compatible with Firestore's data model
                        let doctor = try document.data(as: Doctor.self)
                        fetchedDoctors.append(doctor)
                    } catch let decodeError {
                        print("Error decoding doctor: \(decodeError)")
                    }
                }

                // Update the UI on the main thread since Firestore completion handler is executed on a background thread
                DispatchQueue.main.async {
                    self.doctors = fetchedDoctors
                }
            }
        }
    }


    func addDoctor(doctor: Doctor) {
        do {
            let _ = try db.collection("doctors").addDocument(from: doctor) { error in
                if let error = error {
                    print("Error adding doctor: \(error)")
                } else {
                    print("Doctor added successfully")
                    self.fetchDoctors() // Optionally refresh the doctors list
                }
            }
        } catch let error {
            print("Error serializing doctor: \(error)")
        }
    }
}

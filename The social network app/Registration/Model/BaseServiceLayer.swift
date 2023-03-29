//
//  BaseServiceLayer.swift
//  The social network app
//
//  Created by Mykyta Babanin on 24.10.2022.
//

import Foundation
import UIKit
import CoreData

class BaseServiceLayer {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var userCredentials = [UserCredentials]()
    var userModel = [SignModel]()
    
    func retrieveData() -> [SignModel] {
        do {
            userCredentials = try context.fetch(UserCredentials.fetchRequest())
            for creds in userCredentials {
                let resultModel = SignModel(name: creds.name!, phoneNumber: creds.phoneNumber!, password: creds.password!, email: creds.email!)
                userModel.append(resultModel)
            }
        } catch {
            print("Cannot retrieve data")
        }
        return userModel
    }
    
    func userData() -> [SignModel] {
        var userCreds: [SignModel] = []
        do {
            userCredentials = try context.fetch(UserCredentials.fetchRequest())
            for creds in userCredentials {
                
                guard let credName = creds.name,
                      let credPassword = creds.password,
                      let credEmail = creds.email,
                      let credPhoneNumber = creds.phoneNumber else { return [] }
                
                let resultModel = SignModel(name: credName, phoneNumber: credPassword, password: credPassword, email: credEmail)
                userCreds.append(resultModel)
            }
        } catch {
            print("Cannot store data")
        }
        return userCreds
    }
    
    func addData(model: SignModel) {
        let creds = UserCredentials(context: context)
        creds.password = model.password
        creds.email = model.email
        creds.phoneNumber = model.phoneNumber
        creds.name = model.name
        
        do {
            try context.save()
        } catch {
            print("Cannot add data")
        }
    }
    
    func removeData() {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "UserCredentials")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("Cannot remove data")
        }
    }
    
}

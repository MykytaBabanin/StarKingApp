//
//  SignUpModel.swift
//  The social network app
//
//  Created by Mykyta Babanin on 24.10.2022.
//

import Foundation


class SignUpEntry {
    let serviceLayer: BaseServiceLayer?
    
    init(serviceLayer: BaseServiceLayer) {
        self.serviceLayer = serviceLayer
    }
    
    func retrieveData() {
        serviceLayer?.retrieveData()
    }
    
    func addData(name: String, phoneNumber: String, password: String, email: String) {
        let signInModel = SignModel(name: name, phoneNumber: phoneNumber, password: password, email: email)
        serviceLayer?.addData(model: signInModel)
    }
    
    func cleanData() {
        serviceLayer?.removeData()
    }
}

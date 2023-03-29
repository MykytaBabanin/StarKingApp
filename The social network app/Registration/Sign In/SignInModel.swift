//
//  SignInModel.swift
//  The social network app
//
//  Created by Mykyta Babanin on 24.10.2022.
//

import Foundation

struct SignModel {
    var name: String?
    var phoneNumber: String?
    var password: String?
    var email: String?
}

class SignInEntry: BaseModel {
    let serviceLayer: BaseServiceLayer?
    
    init(serviceLayer: BaseServiceLayer) {
        self.serviceLayer = serviceLayer
    }
    
    func dataFromCoreData() -> [SignModel] {
        return (serviceLayer?.userData())!
    }
    
    func cleanData() {
        serviceLayer?.removeData()
    }
}




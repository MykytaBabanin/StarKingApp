//
//  SignInViewModel.swift
//  The social network app
//
//  Created by Mykyta Babanin on 24.10.2022.
//

import Foundation
import UIKit

enum SignAction {
    case pushToSignUp
    case pushToSignIn
    case pushToMoviePage
    case handleError(UIAlertController)
}

class SignInViewModel: BaseViewModel {
    typealias SignActionCallback = (SignAction) -> Void
    let model: SignInEntry
    var signAction: SignActionCallback?
    
    init(model: SignInEntry,
         signAction: @escaping SignActionCallback) {
        self.model = model
        self.signAction = signAction
    }
    
    func dataFromCoreData() -> [SignModel] {
        return model.dataFromCoreData()
    }
    
    func cleanData() {
        model.cleanData()
    }
    
    func loginUser(userModel: SignModel) {
        let result = dataFromCoreData().contains { model in
            if userModel.email == model.email && userModel.password == model.password {
                return true
            } else {
                return false
            }
        }
        
        if result {
            signAction?(.pushToMoviePage)
        } else {
            showNotAuthorizedUserAlert()
        }
    }
    
    private func showNotAuthorizedUserAlert() {
        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Click", style: .default))
        signAction?(.handleError(alert))
    }
}

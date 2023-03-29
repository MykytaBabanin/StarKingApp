//
//  MainScreenViewModel.swift
//  The social network app
//
//  Created by Mykyta Babanin on 25.10.2022.
//

import Foundation

class MainScreenViewModel: BaseViewModel {
    typealias SignUpActionCallback = (SignAction) -> Void
    var signUpAction: SignUpActionCallback?
    
    init(signUpAction: SignUpActionCallback? = nil) {
        self.signUpAction = signUpAction
    }
    
    func moveToSignUp() {
        signUpAction?(.pushToSignUp)
    }
    
    func moveToSignIn() {
        signUpAction?(.pushToSignIn)
    }
}

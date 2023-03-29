//
//  SignUpViewModel.swift
//  The social network app
//
//  Created by Mykyta Babanin on 24.10.2022.
//

import Foundation
import Combine

enum SubmitAction {
    case popToMain
}

class SignUpViewModel {
    typealias SignUpActionCallback = (SubmitAction) -> Void
    let model: SignUpEntry
    var signUpAction: SignUpActionCallback?

    private var store = Set<AnyCancellable>()
    
    private var loginEntered = PassthroughSubject<Bool, Never>()
    private var passwordEntered = PassthroughSubject<Bool, Never>()
    private var processEnabled = CurrentValueSubject<Bool, Never>(false)
    
    var isLoginEntered: AnyPublisher<Bool, Never> {
        return loginEntered.eraseToAnyPublisher()
    }
    
    var isPassEntered: AnyPublisher<Bool, Never> {
        return passwordEntered.eraseToAnyPublisher()
    }
    
    var isProcessingEnabled: AnyPublisher<Bool, Never> {
        return passwordEntered.eraseToAnyPublisher()
    }
    
    init(model: SignUpEntry,
         signUpAction: @escaping SignUpActionCallback) {
        self.model = model
        self.signUpAction = signUpAction
        
        Publishers.CombineLatest(passwordEntered, loginEntered)
            .map { $0 && $1}
            .subscribe(processEnabled)
            .store(in: &store)
    }
    
    func retrieveData() {
        model.retrieveData()
    }
    
    func popToMain() {
        signUpAction?(.popToMain)
    }
    
    func subscribeLoginText(publisher: AnyPublisher<String, Never>) {
        publisher
            .map { !$0.isEmpty && $0.contains("@") }
            .subscribe(loginEntered)
            .store(in: &store)
    }
    
    func subscribePasswordText(publisher: AnyPublisher<String, Never>) {
        publisher
            .map { !$0.isEmpty && $0.count > 7 }
            .subscribe(passwordEntered)
            .store(in: &store)
    }
    
    func addData(userModel: SignModel,
                 completionHandler: EmptyClosure) {
        guard let name = userModel.name,
              let phoneNumber = userModel.phoneNumber,
              let password = userModel.password,
              let email = userModel.email else { return }
        
        model.addData(name: name, phoneNumber: phoneNumber, password: password, email: email)
        completionHandler()
    }
}

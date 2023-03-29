//
//  SignUpViewController.swift
//  The social network app
//
//  Created by Mykyta Babanin on 24.10.2022.
//

import Foundation
import UIKit
import Combine

public enum TextFieldSettings {
    static let textFieldCornerRadius: CGFloat = 10
    static let textFieldBorderWidth: CGFloat = 1
    static let textFieldBorderColor = UIColor.lightGray.cgColor
}

final class SignUpViewController: UIViewController, UIGestureRecognizerDelegate {
    weak var coordinator: BaseCoordinator?

    @IBOutlet private weak var submitButton: UIButton!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var phoneNumberTextField: UITextField!
    @IBOutlet private weak var fullNameTextField: UITextField!
    @IBOutlet private var textFields: [UITextField]!
    private let viewModel: SignUpViewModel
    private var store: Set<AnyCancellable> = []
    private var isProcessingEnabled = CurrentValueSubject<Bool, Never>(false)
    
    private var login = PassthroughSubject<String, Never>()
    private var password = PassthroughSubject<String, Never>()

    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupStyle()
        setupCustomBackButton()
        setupActions()
        bind()
    }
    
    private func setupCustomBackButton() {
        let backButton = UIBarButtonItem(image: UIImage(named: "arrow"),
                                         style: .plain,
                                         target: navigationController,
                                         action: #selector(navigationController?.popToRootViewController(animated:)))
        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    private func bind() {
        viewModel.isProcessingEnabled
            .subscribe(isProcessingEnabled)
            .store(in: &store)
        
        viewModel.subscribeLoginText(publisher: login.eraseToAnyPublisher())
        viewModel.subscribePasswordText(publisher: password.eraseToAnyPublisher())
    }
    
    private func setupActions() {
        submitButton.addTarget(self, action: #selector(setupData), for: .touchUpInside)
        passwordTextField.addTarget(self, action: #selector(isSubmitEnabled), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(isSubmitEnabled), for: .editingChanged)
    }
    
    private func setupStyle() {
        textFields.forEach { textField in
            textField.layer.cornerRadius = TextFieldSettings.textFieldCornerRadius
            textField.layer.borderWidth = TextFieldSettings.textFieldBorderWidth
            textField.layer.borderColor = TextFieldSettings.textFieldBorderColor
            textField.setLeftPaddingPoints(10)
        }
        submitButton.isEnabled = false
        passwordTextField.isSecureTextEntry = true
        submitButton.layer.cornerRadius = TextFieldSettings.textFieldCornerRadius
    }
    
    @objc private func isSubmitEnabled() {
        guard let emailInput = emailTextField.text,
              let passwordInput = passwordTextField.text else { return }
        
        login.send(emailInput)
        password.send(passwordInput)
        
        submitButton.isEnabled = isProcessingEnabled.value
    }
    
    @objc private func setupData() {
        guard let name = fullNameTextField.text,
              let phoneNumber = phoneNumberTextField.text,
              let password = passwordTextField.text,
              let email = emailTextField.text else { return }
        
        let userModel = SignModel(name: name,
                                  phoneNumber: phoneNumber,
                                  password: password,
                                  email: email)
        
        viewModel.addData(userModel: userModel) { [unowned viewModel] in
            viewModel.popToMain()
        }
    }
}




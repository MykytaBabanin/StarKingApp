//
//  SignInViewController.swift
//  The social network app
//
//  Created by Mykyta Babanin on 24.10.2022.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import GoogleSignIn
import AuthenticationServices
import UIKit

class SignInViewController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var signInViaGoogle: UIButton!
    @IBOutlet private weak var submitButton: UIButton!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private var textFields: [UITextField]!
    
    private let viewModel: SignInViewModel
    
    weak var coordinator: BaseCoordinator?
    
    init(viewModel: SignInViewModel) {
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
    
    private func setupStyle() {
        textFields.forEach { textField in
            textField.layer.cornerRadius = TextFieldSettings.textFieldCornerRadius
            textField.layer.borderWidth = TextFieldSettings.textFieldBorderWidth
            textField.layer.borderColor = TextFieldSettings.textFieldBorderColor
            textField.setLeftPaddingPoints(10)
        }
        signInViaGoogle.layer.cornerRadius = TextFieldSettings.textFieldCornerRadius
        signInViaGoogle.layer.borderWidth = TextFieldSettings.textFieldBorderWidth
        signInViaGoogle.layer.borderColor = TextFieldSettings.textFieldBorderColor
        
        passwordTextField.isSecureTextEntry = true
        submitButton.layer.cornerRadius = TextFieldSettings.textFieldCornerRadius
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        guard let password = passwordTextField.text,
              let email = emailTextField.text else { return }
        
        let userModel = SignModel(password: password,
                                  email: email)
        
        viewModel.loginUser(userModel: userModel)
    }
    
    @IBAction func signInWithGoogleTapped(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(
            with: signInConfiguration(),
            presenting: self) { user, error in
                guard let signInUser = user else { return }
                print("If sign in succeeded, display the app's main content View.")
            }
    }
    
    private func signInConfiguration() -> GIDConfiguration {
        return GIDConfiguration(clientID: "867748373427-mhbv9eft26ktbmba2u7cdolgl2uq57b7.apps.googleusercontent.com")
    }
}

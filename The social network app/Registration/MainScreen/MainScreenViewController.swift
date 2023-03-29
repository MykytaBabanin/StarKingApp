//
//  MainScreenViewController.swift
//  The social network app
//
//  Created by Mykyta Babanin on 25.10.2022.
//

import Foundation
import UIKit
import Combine

class MainScreenViewController: UIViewController {
    private enum Consts {
        static let buttonCornerRadius: CGFloat = 10
        static let buttonBorderWidth: CGFloat = 1
        static let buttonBorderColor = UIColor.lightGray.cgColor
    }
    
    @IBOutlet private weak var alreadyHaveAnAccountButton: UIButton!
    @IBOutlet private weak var signUpButton: UIButton!
    
    let viewModel: MainScreenViewModel
    weak var coordinator: BaseCoordinator?
    
    init(viewModel: MainScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupActions()
        setupStyle()
    }
    
    private func setupStyle() {
        signUpButton.layer.cornerRadius = Consts.buttonCornerRadius
        alreadyHaveAnAccountButton.layer.cornerRadius = Consts.buttonCornerRadius
        alreadyHaveAnAccountButton.layer.borderWidth = Consts.buttonBorderWidth
        alreadyHaveAnAccountButton.layer.borderColor = Consts.buttonBorderColor
    }
    
    private func setupActions() {
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        alreadyHaveAnAccountButton.addTarget(self, action: #selector(alreadyHaveAnAccountButtonTapped), for: .touchUpInside)
    }
    
    @objc private func signUpButtonTapped() {
        viewModel.moveToSignUp()
    }
    
    @objc private func alreadyHaveAnAccountButtonTapped() {
        viewModel.moveToSignIn()
    }
}

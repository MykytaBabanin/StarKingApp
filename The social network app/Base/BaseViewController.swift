//
//  BaseViewController.swift
//  The social network app
//
//  Created by Mykyta Babanin on 24.10.2022.
//

import Foundation
import UIKit

public protocol ControlSetup {
    func setupSubviews()
    func setupAutoLayout()
    func setupStyle()
    func setupActions()
}

public extension ControlSetup {
    func setupActions() { }
    
    func controlSetup() {
        setupSubviews()
        setupAutoLayout()
        setupStyle()
        setupActions()
    }
}

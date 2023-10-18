//
//  View.swift
//  UPT Ultimate Pomodoro Timer
//
//  Created by  user on 11.10.2023.
//

import UIKit

public protocol View {
    associatedtype ViewModelType: ViewModel
    var viewModel: ViewModelType! { get set }
    func setupOutput()
    func setupInput(input: ViewModelType.Output)
}

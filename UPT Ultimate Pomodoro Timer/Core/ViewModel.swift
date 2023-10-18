//
//  ViewModel.swift
//  UPT Ultimate Pomodoro Timer
//
//  Created by  user on 11.10.2023.
//

import Foundation

public protocol ViewModel {
    associatedtype Input
    associatedtype Output
    func transform(
        _ input: Input,
        outputHandler: @escaping (_ output: Output) -> Void
    )
}

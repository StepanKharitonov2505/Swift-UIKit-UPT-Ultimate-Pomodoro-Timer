import Foundation

public protocol ViewModel {
    associatedtype Input
    associatedtype Output
    func transform(
        _ input: Input,
        outputHandler: @escaping (_ output: Output) -> Void
    )
}

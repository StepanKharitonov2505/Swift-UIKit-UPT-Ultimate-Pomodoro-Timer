import UIKit

public protocol View {
    associatedtype ViewModelType: ViewModel
    var viewModel: ViewModelType! { get set }
    func setupOutput()
    func setupInput(input: ViewModelType.Output)
}

import UIKit
import RxSwift
import RxCocoa

final class TimerScreenViewController: UIViewController, View {
    
    // MARK: - Public Properties
    
    public var viewModel: TimerScreenViewModel!
    
    // MARK: - Private Properties
    
    private var disposeBag: DisposeBag! = DisposeBag()
    private let customView = TimerScreenView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        self.view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = TimerScreenViewModel()
        setupOutput()
    }
    
    // MARK: - Rx Output/Input
    
    func setupOutput() {
        guard let viewModel = viewModel else { return }

        let input = TimerScreenViewModel.Input(
            pressingPlayButton: customView.playPauseButton.rx.tap,
            pressingNextButton: customView.nextButton.rx.tap,
            pressingRefreshButton: customView.refreshButton.rx.tap,
            disposeBag: disposeBag
        )
        viewModel.transform(input, outputHandler: setupInput(input:))
    }
    
    func setupInput(input: TimerScreenViewModel.Output) {
        
    }
}

// MARK: - Private Methods

private extension TimerScreenViewController {

}

// MARK: - Constants

private extension TimerScreenViewController {
    enum NumericConstants {
        
    }
    
    enum StrokeConstants {
        
    }
}


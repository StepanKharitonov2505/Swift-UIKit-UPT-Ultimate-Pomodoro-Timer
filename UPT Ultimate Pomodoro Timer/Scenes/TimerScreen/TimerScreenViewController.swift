import UIKit
import RxSwift
import RxCocoa

final class TimerScreenViewController: UIViewController, View {
    
    // MARK: - Public Properties
    
    public var viewModel: TimerScreenViewModel!
    
    // MARK: - Private Properties
    
    private var disposeBag: DisposeBag! = DisposeBag()
    private let timerView = TimerScreenView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        self.view = timerView
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
            pressingPlayButton: timerView.playPauseButton.rx.tap,
            pressingNextButton: timerView.nextButton.rx.tap,
            pressingRefreshButton: timerView.refreshButton.rx.tap,
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


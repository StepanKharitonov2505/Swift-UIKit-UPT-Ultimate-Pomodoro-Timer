import Foundation
import RxSwift
import RxCocoa

class TimerScreenViewModel: ViewModel {
    
    public struct Input {
        let pressingPlayButton: ControlEvent<Void>
        let pressingNextButton: ControlEvent<Void>
        let pressingRefreshButton: ControlEvent<Void>
        let disposeBag: DisposeBag
    }
    
    public struct Output {
        let workHasBegun: Observable<Void>
        let workIsSuspended: Observable<Void>
        let workIsRefreshed: Observable<Void>
    }
    
    func transform(
        _ input: TimerScreenViewModel.Input,
        outputHandler: @escaping (TimerScreenViewModel.Output) -> Void
    ) {
        input.pressingPlayButton
            .subscribe(onNext: {
                print("Play button pressed")
            })
            .disposed(by: input.disposeBag)
        
        input.pressingNextButton
            .subscribe(onNext: {
                print("Next button pressed")
            })
            .disposed(by: input.disposeBag)
        
        input.pressingRefreshButton
            .subscribe(onNext: {
                print("Refresh button pressed")
            })
            .disposed(by: input.disposeBag)
        
        let output = Output(
            workHasBegun: Observable.just(()),
            workIsSuspended: Observable.just(()),
            workIsRefreshed: Observable.just(())
        )
        outputHandler(output)
    }
}

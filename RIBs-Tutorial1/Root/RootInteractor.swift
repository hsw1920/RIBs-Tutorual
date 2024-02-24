////
////  RootInteractor.swift
////  RIBs-Tutorial1
////
////  Created by 홍승완 on 2024/02/23.
////
//
//import RIBs
//import RxSwift
//
//protocol RootRouting: ViewableRouting {
//    func attachLoggedIn()
//    func attachLoggedOut()
//}
//
//protocol RootPresentable: Presentable {
//    var listener: RootPresentableListener? { get set }
//}
//
//protocol RootListener: AnyObject {
//    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
//
//}
//
//final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener {
//
//    weak var router: RootRouting?
//    weak var listener: RootListener?
//
//    private let loginRepository: LoginRepository
//    
//    private var disposeBag: DisposeBag = DisposeBag()
//    // TODO: Add additional dependencies to constructor. Do not perform any logic
//    // in constructor.
//    init(
//        presenter: RootPresentable,
//        loginRepository: LoginRepository
//    ) {
//        self.loginRepository = loginRepository
//        super.init(presenter: presenter)
//        presenter.listener = self
//    }
//
//    override func didBecomeActive() {
//        super.didBecomeActive()
//        // TODO: Implement business logic here.
//        loginRepository.isLoggedIn
//            .subscribe(onNext: { [weak self] isLoggedIn in
//                print("isLoggedIn: \(isLoggedIn)")
//                isLoggedIn ? self?.router?.attachLoggedIn() : self?.router?.attachLoggedOut()
//            })
//            .disposed(by: disposeBag)
//
//    }
//
//    override func willResignActive() {
//        super.willResignActive()
//        // TODO: Pause any business logic.
//    }
//
//}

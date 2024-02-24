//
//  AppRootRouter.swift
//  RIBs-Tutorial1
//
//  Created by 홍승완 on 2024/02/24.
//

import RIBs
import RxSwift

protocol AppRootInteractable: Interactable, LoggedInListener, LoggedOutListener {
    var router: AppRootRouting? { get set }
    var listener: AppRootListener? { get set }
}

protocol AppRootViewControllable: ViewControllable {
}

final class AppRootRouter: LaunchRouter<AppRootInteractable, AppRootViewControllable> {

    private let loggedInBuilder: LoggedInBuildable
    private var loggedInRouting: Routing?
    
    private let loggedOutBuilder: LoggedOutBuildable
    private var loggedOutRouting: Routing?
    
    private var disposeBag = DisposeBag()

    init(
        interactor: AppRootInteractable,
        viewController: AppRootViewControllable,
        loggedInBuilder: LoggedInBuildable,
        loggedOutBuilder: LoggedOutBuildable
    ) {
        self.loggedInBuilder = loggedInBuilder
        self.loggedOutBuilder = loggedOutBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }

}

extension AppRootRouter: AppRootRouting {

    func attachLoggedIn() {
        // loggedInRouting이 nil일 때만 Attach 하도록
        if loggedInRouting != nil {
            return
        }

        // Attach
        let router = loggedInBuilder.build(withListener: interactor)
        router.viewControllable.uiviewController.modalPresentationStyle = .fullScreen
        viewController.replaceRoot(to: router.viewControllable)
        
        attachChild(router)
        self.loggedInRouting = router
    }
    
    func attachLoggedOut() {
        // loggedOutRouting이 nil일 때만 Attach 하도록
        if loggedOutRouting != nil {
            return
        }
        
        // Detach
        let router = loggedOutBuilder.build(withListener: interactor)
        router.viewControllable.uiviewController.modalPresentationStyle = .fullScreen
        viewController.replaceRoot(to: router.viewControllable)
        
        attachChild(router)
        self.loggedOutRouting = router
    }
    
    func detachLoggedIn() {
        // loggedInRouting이 nil이 아닐때만 detach 하도록
        guard let router = loggedInRouting else {
            return
        }
        viewController.dismiss(animated: false, completion: nil)
        detachChild(router)
        loggedInRouting = nil
    }
    
    func detachLoggedOut() {
        // loggedOutRouting이 nil이 아닐때만 detach 하도록
        guard let router = loggedOutRouting else {
            return
        }
        viewController.dismiss(animated: false, completion: nil)
        detachChild(router)
        loggedOutRouting = nil
    }
}

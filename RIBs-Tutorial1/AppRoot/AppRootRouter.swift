//
//  AppRootRouter.swift
//  RIBs-Tutorial1
//
//  Created by 홍승완 on 2024/02/24.
//

import RIBs
import UIKit

/// Build 시 AppRootRouter가 LoggedIn, LoggedOut의 Listener로써 작동하기 위해서 채택함.
protocol AppRootInteractable: Interactable, LoggedInListener, LoggedOutListener {
    var router: AppRootRouting? { get set }
    var listener: AppRootListener? { get set }
}

protocol AppRootViewControllable: ViewControllable {
    var viewController: AppRootViewControllable { get }
    func present(viewController: ViewControllable)
}

//final class AppRootRouter: LaunchRouter<AppRootInteractable, AppRootViewControllable>, AppRootRouting {
final class AppRootRouter: Router<AppRootInteractable>, AppRootRouting {

    init(
        interactor: AppRootInteractable,
        loggedInBuilder: LoggedInBuildable,
        loggedOutBuilder: LoggedOutBuildable,
        window: UIWindow
    ) {
        
        self.loggedInBuilder = loggedInBuilder
        self.loggedOutBuilder = loggedOutBuilder
        self.window = window
        
        super.init(interactor: interactor)
        interactor.router = self
    }

    func setupLoggedIn() {
        let router = loggedInBuilder.build(withListener: interactor)
        self.loggedInRouting = router
        self.attachChild(router)
        setupRootViewController(with: router.viewControllable)
        
        print("## Setup: LoggedIn")
    }
    
    func setupLoggedOut() {
        let router = loggedOutBuilder.build(withListener: interactor)
        self.loggedOutRouting = router
        self.attachChild(router)
        self.setupRootViewController(with: router.viewControllable)
        
        print("## Setup: LoggedOut")
    }
    
    func attachLoggedIn() {
        if loggedInRouting != nil {
             return
        }
        
        let router = loggedInBuilder.build(withListener: interactor)
        self.loggedInRouting = router
        self.attachChild(router)
        
        self.setupRootViewController(with: router.viewControllable)

        print("## Attach: LoggedIn")
    }
    
    func attachLoggedOut() {
        if loggedOutRouting != nil {
            return
        }
        
        let router = loggedOutBuilder.build(withListener: interactor)
        self.loggedOutRouting = router
        self.attachChild(router)

        self.setupRootViewController(with: router.viewControllable)
        
        print("## Attach: LoggedOut")
    }
    
    func detachLoggedOut() {
        guard let router = loggedOutRouting else {
            return
        }
        
        self.detachChild(router)
        self.loggedOutRouting = nil
        
        print("## Detach: LoggedOut")
    }
    
    func detachLoggedIn() {
        guard let router = loggedInRouting else {
            return
        }
        
        self.detachChild(router)
        self.loggedInRouting = nil
        
        print("## Detach: LoggedIn")
    }
    
    func setupRootViewController(with viewControllable: ViewControllable) {
        let vc = viewControllable.uiviewController
        window.rootViewController = vc
        window.makeKeyAndVisible()
    }
    
    // MARK: - Private
    private let window: UIWindow
    private let loggedInBuilder: LoggedInBuildable
    private let loggedOutBuilder: LoggedOutBuildable
    private var loggedInRouting: Routing?
    private var loggedOutRouting: Routing?
}

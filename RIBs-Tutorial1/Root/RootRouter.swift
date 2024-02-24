////
////  RootRouter.swift
////  RIBs-Tutorial1
////
////  Created by 홍승완 on 2024/02/23.
////
//
//import RIBs
//
//protocol RootInteractable: Interactable, LoggedInListener, LoggedOutListener {
//    var router: RootRouting? { get set }
//    var listener: RootListener? { get set }
//}
//
//protocol RootViewControllable: ViewControllable {
//    func present(viewController: ViewControllable)
//}
//
///// Root에서는 ViewableRouter가 아니라 LaunchRouter를 사용함
//final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
//final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
//
//    private let loggedInBuilder: LoggedInBuildable
//    private let loggedOutBuilder: LoggedOutBuildable
//    
//    
//    // TODO: Constructor inject child builder protocols to allow building children.
//    init(
//        interactor: RootInteractable,
//        viewController: RootViewControllable,
//        loggedInBuilder: LoggedInBuildable,
//        loggedOutBuilder: LoggedOutBuildable
//    ) {
//        self.loggedInBuilder = loggedInBuilder
//        self.loggedOutBuilder = loggedOutBuilder
//        
//        super.init(interactor: interactor, viewController: viewController)
//        interactor.router = self
//    }
//    
//    func attachLoggedIn() {
//        let router = loggedInBuilder.build(withListener: interactor)
//        self.attachChild(router)
//        viewController.present(viewController: router.viewControllable)
//    }
//    
//    func attachLoggedOut() {
//        let router = loggedOutBuilder.build(withListener: interactor)
//        self.attachChild(router)
//        viewController.present(viewController: router.viewControllable)
//    }
//    
//}

//
//  LoggedInViewController.swift
//  RIBs-Tutorial1
//
//  Created by 홍승완 on 2024/02/23.
//

import RIBs
import RxSwift
import RxCocoa
import UIKit
import SnapKit
protocol LoggedInPresentableListener: AnyObject {
    func logout()
}

final class LoggedInViewController: UIViewController, LoggedInPresentable, LoggedInViewControllable {

    weak var listener: LoggedInPresentableListener?
    
    private var disposeBag = DisposeBag()
    
    private lazy var logOutButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("로그아웃", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
         super.viewDidLoad()

        self.view.backgroundColor = .systemBackground
        print("Init: \(self)")
        setupUI()
        bind()
     }
    
    deinit {
        print("Deinit: \(self)")
    }
    
    private func setupUI() {
        view.addSubview(logOutButton)
        logOutButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func bind() {
        logOutButton.rx.tap
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] _ in
                self?.listener?.logout()
            })
            .disposed(by: disposeBag)
    }

}

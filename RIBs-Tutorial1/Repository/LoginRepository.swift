//
//  LoginRepository.swift
//  RIBs-Tutorial1
//
//  Created by 홍승완 on 2024/02/23.
//

import RxSwift

protocol LoginRepository {
    var isLoggedIn: Observable<Bool> { get }
}

final class LoginRepositoryImp: LoginRepository {
    var isLoggedIn: Observable<Bool> {
        return .just(true)
    }
}

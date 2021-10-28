//
//  TipsViewModel.swift
//  AloTips
//
//  Created by Admin on 8/25/21.
//

import Foundation
import CommonFramework
import RxSwift
import RxCocoa

class TipsViewModel {
    
    // MARK: - Properties
    var loadingBehavior = BehaviorRelay<Bool>(value: false)

    private var tipsSubject = PublishSubject<Array<TipModel>>()
    var tipsObservable: Observable<Array<TipModel>> {
        return tipsSubject
    }
    
    private var errorSubject = PublishSubject<BaseAPIError>()
    var errorObservable: Observable<BaseAPIError> {
        return errorSubject
    }
    
    private var tipService: TipService!
    
    // MARK: - Init functions
    init(tipsService: TipService) {
        self.tipService = tipsService
    }
}

// MARK: - Public functions
extension TipsViewModel {
    /**
     This function is used to call get tips API
     - parameter paramater: paramater was userId
     */
    func requestGetTips(paramater: Dictionary<String, Any>) {
        loadingBehavior.accept(true)
        tipService.getTips(paramater: paramater) { [weak self] result in
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            switch result {
            case .success(let tipResponseModel):
                self.tipsSubject.onNext(tipResponseModel?.tips ?? Array<TipModel>())
            case .failure(let error):
                self.errorSubject.onNext(error)
            }
        }
    }
}


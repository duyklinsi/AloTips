//
//  TipsViewController.swift
//  AloTips
//
//  Created by Admin on 8/24/21.
//

import UIKit
import RxSwift
import RxCocoa
import CommonFramework

class TipsViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var tipsViewModel: TipsViewModel!
    let disposeBag = DisposeBag()
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
        subscribeToLoading()
        subscribeToResponse()
        subcribeToError()
    }
}

// MARK: - Private functions
extension TipsViewController {
    private func setupUI() {
        tableView.register(cellWithClass: TipCell.self)
    }
    
    private func setupData() {
        // init tips view model
        if tipsViewModel == nil {
            tipsViewModel = TipsViewModel(tipsService: TipService())
        }
        
        // request get tips
        tipsViewModel.requestGetTips(paramater: ["date_filter": "",
                                                 "userId": "jLvz5D3slWP8wNzOZWtDVgGrq6Q2"])
    }
    
    private func subscribeToResponse() {
        tipsViewModel.tipsObservable
            .bind(to: tableView
                    .rx
                    .items(cellIdentifier: "TipCell", cellType: TipCell.self)) { row, tip, cell in
                print(row)
            }
            .disposed(by: disposeBag)
    }
    
    private func subcribeToError() {
        tipsViewModel.errorObservable
            .subscribe(onNext:{ [weak self] (error) in
                guard let self = self else { return }
                self.showAlert(title: error.title, message: error.description)
            })
            .disposed(by: disposeBag)
    }
    
    private func subscribeToLoading() {
        tipsViewModel.loadingBehavior
            .subscribe (onNext: {isLoading in
                isLoading ? LoadingManager.shared.show() : LoadingManager.shared.hide()
            })
            .disposed(by: disposeBag)
    }
}

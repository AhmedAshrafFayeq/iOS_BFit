//
//  HomeViewController.swift
//  BFit
//
//  Created by Ahmed Fayeq on 25/07/2022.
//

import UIKit
import SwiftUI
import RxSwift
import RxCocoa
import Alamofire

class HomeViewController: UIViewController {
    
    //MARK: - Variables
    private var exerciseViewModel: ExerciseViewModelProtocol?
    private let disposeBag = DisposeBag()
    private var child: UIHostingController<HeaderView>?
    
    private let tableView : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .clear
        table.register(ExerciseTableViewCell.self, forCellReuseIdentifier: ExerciseTableViewCell.identifier)
        return table
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: view.bounds.height / 4.5, width: view.bounds.width, height: view.bounds.height - view.bounds.height / 4.5)
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        configureHeaderView()
        child?.view.addSubview(tableView)
        tableView.delegate = self
        configureViewModel()
    }
    
    //MARK: - Customize Header  for the TableView
    private func configureHeaderView() {
        child = UIHostingController(rootView: HeaderView(showSettingsView: {
            self.didTabSettingsButton()
        }))
        child?.view.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height )
        // First, add the view of the child to the view of the parent
        self.view.addSubview(child?.view ?? UIView())
        // Then, add the child to the parent
        self.addChild(child ?? UIHostingController<HeaderView>(rootView: HeaderView(showSettingsView: {
            self.didTabSettingsButton()
        })))
    }
    //MARK: - Settings button method
    private func didTabSettingsButton() {
        let settingsVC = SettingsViewController()
        settingsVC.modalPresentationStyle = .fullScreen
        let navgation = UINavigationController(rootViewController: settingsVC)
        present(navgation, animated: true, completion: nil)
        
    }
    
    //MARK: - View Model Configuration
    private func configureViewModel() {
        exerciseViewModel = ExerciseViewModel()
        self.showLoading()
        exerciseViewModel?.getExerciseData(completion: { [weak self] isSuccess in
            self?.exerciseViewModel?.getExerciseImages(completion: { [weak self] isSuccess in
                self?.exerciseViewModel?.combineExerciseData()
                self?.bindTableViewWithExercise()
                self?.hideLoading()
            })
        })
    }
    
    //MARK: - Binding TableView
    func bindTableViewWithExercise() {
        
        exerciseViewModel?.exerciseCombineBehaviourSubject.bind(to: tableView.rx.items(cellIdentifier: ExerciseTableViewCell.identifier, cellType: ExerciseTableViewCell.self)) { row ,item , cell in
            cell.configureCell(model: item)
            cell.selectionStyle = .none
        }.disposed(by: disposeBag)
        
        // Did Tap On Item
        tableView.rx.modelSelected(HomeModel.self).subscribe(onNext: { [weak self] (model) in
            let exerciseDetailVC = ExerciseDetailViewController()
            exerciseDetailVC.model = model
            exerciseDetailVC.exerciseBehaviorSubject = BehaviorSubject(value: model.vaiations ?? [HomeModel]())
            let navigationController = UINavigationController(rootViewController: exerciseDetailVC)
            navigationController.modalPresentationStyle = .fullScreen
            self?.present(navigationController, animated: true, completion: nil)
        }).disposed(by: disposeBag)
    }
}

// MARK: - extension for TableView Delegate
extension HomeViewController : UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}

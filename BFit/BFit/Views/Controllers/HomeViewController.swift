//
//  HomeViewController.swift
//  BFit
//
//  Created by Ahmed Fayeq on 25/07/2022.
//

import UIKit
import RxSwift
import RxCocoa
import ProgressHUD

class HomeViewController: UIViewController {
    
    //MARK: - Variables
    private var exerciseViewModel: ExerciseViewModelProtocol?
    private let disposeBag = DisposeBag()
    
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
        tableView.frame = view.bounds
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        configureViewModel()
    }
    
    //MARK: - View Model Configuration
    private func configureViewModel() {
        exerciseViewModel = ExerciseViewModel()
        exerciseViewModel?.getExerciseData(completion: { [weak self] isSuccess in
            self?.exerciseViewModel?.getExerciseImages(completion: { [weak self] isSuccess in
                self?.bindTableViewWithExercise()
            })
        })
    }
    
    //MARK: - Binding TableView
    func bindTableViewWithExercise() {
        var list = [HomeModel]()
        var behaviourSubject = BehaviorSubject(value: list)
        
        Observable.combineLatest(exerciseViewModel!.exerciseBehaviorSubject, exerciseViewModel!.exerciseImageBehaviorSubject).map { exercises, images in
            for (e1, e2) in zip(exercises, images).sorted(by: { $0.0.exerciseBase == $1.0.exerciseBase }) {
                list.append(HomeModel(exercise: e1, image: e2))
            }
            return list
        }.bind(to: behaviourSubject).disposed(by: disposeBag)
        
        behaviourSubject = BehaviorSubject(value: list)

        behaviourSubject.bind(to: tableView.rx.items(cellIdentifier: ExerciseTableViewCell.identifier, cellType: ExerciseTableViewCell.self)) { row ,item , cell in
            print("hey \(item.exercise.name) hey \(item.image.id)")
            cell.configureCell(model: item)
        }.disposed(by: disposeBag)
        
        
        
        // Did Tap On Item
        tableView.rx.modelSelected(Exercise.self).subscribe(onNext: { [weak self] (model) in
//            let newsVC = NewsDetailsViewController()
//            newsVC.configureView(model: model)
//            let navigationController = UINavigationController(rootViewController: newsVC)
//            navigationController.modalPresentationStyle = .fullScreen
//            self?.present(navigationController, animated: true, completion: nil)
            
        }).disposed(by: disposeBag)
        
    }
    
}

// MARK: - extension for TableView Delegate
extension HomeViewController : UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

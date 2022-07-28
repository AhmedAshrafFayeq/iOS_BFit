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
        configureHeaderView()
        tableView.delegate = self
        configureViewModel()
    }
    
    //MARK: - Customize Header  for the TableView
    func configureHeaderView() {
        let  headerView = ExerciseHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height / 7))
        tableView.tableHeaderView = headerView
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
        var homeModelList = [HomeModel]()
        var behaviourSubject = BehaviorSubject(value: homeModelList)
        
        Observable.combineLatest(exerciseViewModel!.exerciseBehaviorSubject, exerciseViewModel!.exerciseImageBehaviorSubject).map { exercises, images in
            let homeModelSortedList = zip(exercises, images).sorted(by: { $0.0.exerciseBase == $1.0.exerciseBase })
            for (exercise, image) in  homeModelSortedList {
                homeModelList.append(HomeModel(exercise: exercise, image: image))
            }
            return homeModelList
        }.bind(to: behaviourSubject).disposed(by: disposeBag)
        
        behaviourSubject = BehaviorSubject(value: homeModelList)

        behaviourSubject.bind(to: tableView.rx.items(cellIdentifier: ExerciseTableViewCell.identifier, cellType: ExerciseTableViewCell.self)) { row ,item , cell in
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
        return 70
    }
    
}

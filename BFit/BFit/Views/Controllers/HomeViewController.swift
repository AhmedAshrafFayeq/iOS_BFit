//
//  HomeViewController.swift
//  BFit
//
//  Created by Ahmed Fayeq on 25/07/2022.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire

protocol SettingsButtonActionDelegate {
    func didTabSettingsButton()
}

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
        let  headerView = ExerciseHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height / 5))
        headerView.delegate = self
        tableView.tableHeaderView = headerView
    }
    
    //MARK: - View Model Configuration
    private func configureViewModel() {
        exerciseViewModel = ExerciseViewModel()
        self.showLoading()
        exerciseViewModel?.getExerciseData(completion: { [weak self] isSuccess in
            self?.exerciseViewModel?.getExerciseImages(completion: { [weak self] isSuccess in
                self?.bindTableViewWithExercise()
                self?.hideLoading()
            })
        })
    }
    
    //MARK: - Binding TableView
    func bindTableViewWithExercise() {
        var homeModelList = [HomeModel]()
        var behaviourSubject = BehaviorSubject(value: homeModelList)
        var exercisesVariation = [HomeModel]()
        
        Observable.combineLatest(exerciseViewModel!.exerciseBehaviorSubject, exerciseViewModel!.exerciseImageBehaviorSubject).map { exercises, images in
            let homeModelSortedList = zip(exercises, images).sorted(by: { $0.0.exerciseBase == $1.0.exerciseBase })
            for (exercise, image) in  homeModelSortedList {
                for v in exercise.variations {
                    for (ex, im) in homeModelSortedList {
                        if ex.id == v && exercise.id != v {
                            exercisesVariation.append(HomeModel(exercise: ex, image: im, vaiations: exercisesVariation))
                        }
                    }
                }
                homeModelList.append(HomeModel(exercise: exercise, image: image, vaiations: exercisesVariation))
                exercisesVariation.removeAll()
            }
            return homeModelList
        }.bind(to: behaviourSubject).disposed(by: disposeBag)
        
        behaviourSubject = BehaviorSubject(value: homeModelList)
        behaviourSubject.bind(to: tableView.rx.items(cellIdentifier: ExerciseTableViewCell.identifier, cellType: ExerciseTableViewCell.self)) { row ,item , cell in
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

//MARK: - Extension for Setting Button Delegate
extension HomeViewController: SettingsButtonActionDelegate {

    func didTabSettingsButton() {
        let settingsVC = SettingsViewController()
        settingsVC.modalPresentationStyle = .fullScreen
        let navgation = UINavigationController(rootViewController: settingsVC)
        present(navgation, animated: true, completion: nil)
        
    }
}

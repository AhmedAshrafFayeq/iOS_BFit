//
//  HomeViewController.swift
//  BFit
//
//  Created by Ahmed Fayeq on 25/07/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - Variables
    var exerciseViewModel: ExerciseViewModelProtocol?
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureViewModel()
    }
    
    //MARK: - View Model Configuration
    private func configureViewModel() {
        exerciseViewModel = ExerciseViewModel()
        exerciseViewModel?.getExerciseData()
    }
    
}

//
//  ExerciseDetailViewController.swift
//  BFit
//
//  Created by Ahmed Fayeq on 28/07/2022.
//

import UIKit
import SDWebImage
import RxSwift
import RxCocoa
import ProgressHUD

class ExerciseDetailViewController: UIViewController {
    
    //MARK: - Vars
    var model: HomeModel?
    var exerciseBehaviorSubject: BehaviorSubject<[HomeModel]>?
    private var exerciseDetailViewModel: ExerciseDetailViewModelProtocol?
    private let disposeBag = DisposeBag()
    
    private let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.isScrollEnabled = true
        return v
    }()
    
    private let scrollContentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let exerciseNameLabel: UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.adjustsFontSizeToFitWidth = false
        return label
    }()
    
    private let imageCollectionView: UICollectionView = {
        // Layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero,  collectionViewLayout: layout)
        collectionView.register(ExerciseImageCollectionViewCell.self, forCellWithReuseIdentifier: ExerciseImageCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private let placeholderImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.tintColor = .gray
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let variationsCollectionView: UICollectionView = {
        // Layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero,  collectionViewLayout: layout)
        collectionView.register(ExerciseVariationCollectionViewCell.self, forCellWithReuseIdentifier: ExerciseVariationCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    public let exerciseDescriptionLabel : UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .gray
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.adjustsFontSizeToFitWidth = false
        return label
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavBar()
        setupView()
        configureConstraints()
        configureView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = CGRect(x: 0, y: navigationController?.navigationBar.frame.height ?? 70, width: view.bounds.size.width, height: view.bounds.size.height)
        scrollContentView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.frame.size.height * 1.5)
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: view.frame.size.height * 1.5)
    }
    
    
    //MARK: - Navbar Configuration
    func configureNavBar() {
        // set the left buton and title to the navBar
        navigationItem.title = model?.exercise.name
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .done, target: self, action: #selector(didTabBackButton))
        navigationController?.navigationBar.tintColor = .appThemeColor()
    }
    
    @objc private func didTabBackButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Layouts and Cosntraints
    private func setupView() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        scrollContentView.addSubview(exerciseNameLabel)
        scrollContentView.addSubview(placeholderImageView)
        scrollContentView.addSubview(imageCollectionView)
        scrollContentView.addSubview(exerciseDescriptionLabel)
        scrollContentView.addSubview(variationsCollectionView)

        variationsCollectionView.delegate = self
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            exerciseNameLabel.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor,constant: 16),
            exerciseNameLabel.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor,constant: -16),
            exerciseNameLabel.topAnchor.constraint(equalTo: scrollContentView.topAnchor,constant: 50),
            
            imageCollectionView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor,constant: 20),
            imageCollectionView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor,constant: -20),
            imageCollectionView.topAnchor.constraint(equalTo: exerciseNameLabel.bottomAnchor,constant: 20),
            imageCollectionView.heightAnchor.constraint(equalToConstant: 300),
            
            placeholderImageView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor,constant: 20),
            placeholderImageView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor,constant: -20),
            placeholderImageView.topAnchor.constraint(equalTo: exerciseNameLabel.bottomAnchor,constant: 20),
            placeholderImageView.heightAnchor.constraint(equalToConstant: 300),
            
            imageCollectionView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor,constant: 20),
            imageCollectionView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor,constant: -20),
            imageCollectionView.topAnchor.constraint(equalTo: placeholderImageView.bottomAnchor,constant: 20),
            
            exerciseDescriptionLabel.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor,constant: 20),
            exerciseDescriptionLabel.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor,constant: -20),
            exerciseDescriptionLabel.topAnchor.constraint(equalTo: placeholderImageView.bottomAnchor,constant: 20),
            exerciseDescriptionLabel.bottomAnchor.constraint(equalTo: variationsCollectionView.topAnchor,constant: 20),
            
            variationsCollectionView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor,constant: 20),
            variationsCollectionView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor,constant: -20),
            variationsCollectionView.topAnchor.constraint(equalTo: exerciseDescriptionLabel.bottomAnchor,constant: 20),
            variationsCollectionView.heightAnchor.constraint(equalToConstant: 300),
            
        ])
    }
    
    private func configureView() {
        exerciseNameLabel.text = model?.exercise.name
        exerciseDescriptionLabel.text = model?.exercise.exerciseDescription
        placeholderImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        placeholderImageView.sd_setImage(with: URL(string: model?.image.image ?? ""), placeholderImage: UIImage(named: "placeholder"))
        
        configureViewModel()
        bindCollectionViewWithExerciseVariation()
    }
    
    //MARK: - View Model Configuration
    private func configureViewModel() {
        exerciseDetailViewModel = ExerciseDetailViewModel()
        exerciseDetailViewModel?.getExerciseInfoData(completion: { [weak self] isSuccess in
            self?.bindCollectionViewWithExerciseInfo()
        })
    }
    
    //MARK: - Binding ImageCollectionView
    func bindCollectionViewWithExerciseInfo() {
        exerciseDetailViewModel?.exerciseInfoBehaviorSubject.bind(to: imageCollectionView.rx.items(cellIdentifier: ExerciseImageCollectionViewCell.identifier, cellType: ExerciseImageCollectionViewCell.self)) { row ,item , cell in
            cell.configureCell(image: item.image)
        }.disposed(by: disposeBag)
    }
    
    //MARK: - Binding VariationCollectionView
    func bindCollectionViewWithExerciseVariation() {
        exerciseBehaviorSubject?.bind(to: variationsCollectionView.rx.items(cellIdentifier: ExerciseVariationCollectionViewCell.identifier, cellType: ExerciseVariationCollectionViewCell.self)) { row ,item , cell in
            cell.configureCell(model: item)
        }.disposed(by: disposeBag)
        
        
        // Did Tap On Item
        variationsCollectionView.rx.modelSelected(HomeModel.self).subscribe(onNext: { [weak self] (model) in
            let exerciseDetailVC = ExerciseDetailViewController()
            exerciseDetailVC.model = model
            exerciseDetailVC.exerciseBehaviorSubject = BehaviorSubject(value: model.vaiations ?? [HomeModel]())
            let navigationController = UINavigationController(rootViewController: exerciseDetailVC)
            navigationController.modalPresentationStyle = .fullScreen
            self?.present(navigationController, animated: true, completion: nil)
        }).disposed(by: disposeBag)
    }
}


//MARK: - Extension for collectionview delegate and dataSource
extension ExerciseDetailViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width / 2.5, height: 230)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
    }
    
}

//
//  ExerciseVariationCollectionViewCell.swift
//  BFit
//
//  Created by Ahmed Fayeq on 28/07/2022.
//

import UIKit
import SDWebImage

class ExerciseVariationCollectionViewCell: UICollectionViewCell {
   //MARK: - Vars
    static let identifier = "ExerciseVariationCollectionViewCell"

    private let exerciseImageView : UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        image.tintColor = .gray
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let exersiseNameLabel : UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.adjustsFontSizeToFitWidth = false
        return label
    }()
    
    //MARK: - Initilizers
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        setupLayouts()
        configureConstraints()
    }
    

    required init?(coder: NSCoder) {
        fatalError()
    }
  //MARK: - Layouts / Constraints
    private func setupLayouts(){
        contentView.addSubview(exerciseImageView)
        contentView.addSubview(exersiseNameLabel)
    
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = .zero
        contentView.layer.cornerRadius = 12
        contentView.layer.shadowRadius = 10
        contentView.layer.shadowOpacity = 0.3
    }
    
    private func configureConstraints(){
        NSLayoutConstraint.activate([
            exerciseImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            exerciseImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            exerciseImageView.heightAnchor.constraint(equalToConstant: 150),
            exerciseImageView.widthAnchor.constraint(equalToConstant: 150),
            
            exersiseNameLabel.topAnchor.constraint(equalTo: exerciseImageView.bottomAnchor,constant: 8),
            exersiseNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            exersiseNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10),
        ])
    }
    
    //MARK: - Cell Configuration
    func configureCell(model: HomeModel ){
        self.exersiseNameLabel.text = model.exercise.name
        exerciseImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        exerciseImageView.sd_setImage(with: URL(string: model.image.image), placeholderImage: UIImage(named: "placeholder"))
    }
}

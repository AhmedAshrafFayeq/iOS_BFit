//
//  ExerciseTableViewCell.swift
//  BFit
//
//  Created by Ahmed Fayeq on 26/07/2022.
//

import UIKit
import SDWebImage

class ExerciseTableViewCell: UITableViewCell {
    
    //MARK: - Vars
    static let identifier = "ExerciseTableViewCell"

    private let exerciseImageView : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.image = UIImage(systemName: "placeholder")
        image.layer.cornerRadius = 7
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .systemPink
        return image
    }()
    
    private let exerciseNameLabel : UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.adjustsFontSizeToFitWidth = false
        return label
    }()
    
    //MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier : String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setupView()
        configureConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    //MARK: - Layouts and Cosntraints
    private func setupView(){
        contentView.addSubview(exerciseImageView)
        contentView.addSubview(exerciseNameLabel)
        
    }
    
    private func configureConstrains(){
        NSLayoutConstraint.activate([
            exerciseImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            exerciseImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            exerciseImageView.widthAnchor.constraint(equalToConstant: 50),
            exerciseImageView.heightAnchor.constraint(equalToConstant: 50),
            
            exerciseNameLabel.centerYAnchor.constraint(equalTo: exerciseImageView.centerYAnchor),
            exerciseNameLabel.leadingAnchor.constraint(equalTo: exerciseImageView.trailingAnchor, constant: 20),
            exerciseNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    //MARK: - Cell Configuration
    func configureCell(model: HomeModel){
        self.exerciseNameLabel.text = model.exercise.name
        if let url = URL(string: model.image.image) {
//            imgView.sd_setShowActivityIndicatorView(true)
//            imgView.sd_setIndicatorStyle(.gray)
            self.exerciseImageView.sd_setImage(with: url, completed: nil)
        }else {
            self.exerciseImageView.image = UIImage(named: "placeholder")
        }
    }
}

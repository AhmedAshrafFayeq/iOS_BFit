//
//  ExerciseHeaderView.swift
//  BFit
//
//  Created by Ahmed Fayeq on 28/07/2022.
//

import UIKit

class ExerciseHeaderView: UIView {
    
    //MARK: - Vars
    
    private let logoImageView : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.image = UIImage(named: "logo")
        image.clipsToBounds = true
        image.layer.cornerRadius = 30
        image.tintColor = .systemPink
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    public let titleLabel : UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .label
        label.text = "Top Exercises"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.adjustsFontSizeToFitWidth = false
        return label
    }()
    

    //MARK: - Initlizaers
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        self.clipsToBounds = true
        
        setupViews()
        configureConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    

    //MARK: - Layouts and Constraints
    private func setupViews(){
        addSubview(logoImageView)
        addSubview(titleLabel)
    }

    private func configureConstraints(){
        NSLayoutConstraint.activate([
            
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
            logoImageView.topAnchor.constraint(equalTo: topAnchor,constant: 20),
            logoImageView.widthAnchor.constraint(equalToConstant: 120 ),
            logoImageView.heightAnchor.constraint(equalToConstant: 120 ),

            titleLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 5),
            titleLabel.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50)

        ])
    }
}

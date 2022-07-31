//
//  ExerciseHeaderView.swift
//  BFit
//
//  Created by Ahmed Fayeq on 28/07/2022.
//

import UIKit

class ExerciseHeaderView: UIView {
    
    //MARK: - Vars
    var delegate: SettingsButtonActionDelegate?
    
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
        label.numberOfLines = 1
        label.textColor = .label
        label.text = "TOP_EXERCISES_LABEL_TITLE".localized(forLanguageCode: NSLocale.preferredLanguages[0])
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.adjustsFontSizeToFitWidth = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let settingButton : UIButton = {
        let button =  UIButton()
        button.setImage(UIImage(systemName: "gearshape",withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)), for: .normal)
        button.tintColor = .appThemeColor()
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(didTabSettingsButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        addSubview(settingButton)
    }
    
    private func configureConstraints(){
        NSLayoutConstraint.activate([
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 5),
            logoImageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -5),
            logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -25),
            logoImageView.widthAnchor.constraint(equalToConstant: 120),
            logoImageView.heightAnchor.constraint(equalToConstant: 120 ),
            
            titleLabel.leadingAnchor.constraint(equalTo: logoImageView.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor),

            settingButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            settingButton.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor),
            settingButton.widthAnchor.constraint(equalToConstant: 70 ),
            settingButton.heightAnchor.constraint(equalToConstant: 70 ),
        ])
    }
    
    //MARK: - Settings Buttons Action
    @objc private func didTabSettingsButton (){
        delegate?.didTabSettingsButton()
    }
}

//
//  SettingsViewController.swift
//  BFit
//
//  Created by Ahmed Fayeq on 29/07/2022.
//

import UIKit
import SwiftUI
import LanguageManager_iOS

class SettingsViewController: UIViewController {
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureButtons()
    }
    
    //MARK: - Configure NavBar Button
    private func configureButtons(){
        navigationItem.leftBarButtonItem = UIBarButtonItem( image: UIImage(systemName: "chevron.backward") ,style: .done, target: self, action: #selector(didTabBackButton))
        navigationController?.navigationBar.tintColor = .appThemeColor()
    }
    
    @objc private func didTabBackButton(){
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupView() {
        title = "SETTINGS_TITLE".localized(forLanguageCode: NSLocale.preferredLanguages[0])
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        //view.addSubview(tableView)
        
        addSettingsSwiftUIView()
        
    }
    
    //MARK: - Extension for SettingsView Methods
    private func addSettingsSwiftUIView() {
        let child = UIHostingController(rootView: SettingsView())
        child.view.frame = CGRect(x: 0, y: navigationController?.navigationBar.frame.height ?? 120, width: view.frame.width, height: 70)
        // First, add the view of the child to the view of the parent
        self.view.addSubview(child.view)
        // Then, add the child to the parent
        self.addChild(child)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        child.view.addGestureRecognizer(tap)
    }
    
    // didTap on changeLanguage
    @objc private func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        showAlert()
    }
    
    //MARK: - Change Language
    private func showAlert() {
        let alert = UIAlertController(title: "CHANGE_LANGUAGE".localized(forLanguageCode: NSLocale.preferredLanguages[0]), message: "CHOOSE_LANGUAGE".localized(forLanguageCode: NSLocale.preferredLanguages[0]), preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "English", style: .default, handler: { [weak self] (action) in
            UserDefaults.standard.setValue(["en"], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
            self?.changeLanguage(selectedLanguage: .en)
        }))
        alert.addAction(UIAlertAction(title: "Deutsch", style: .default, handler: { [weak self](action) in
            UserDefaults.standard.setValue(["de"], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
            self?.changeLanguage(selectedLanguage: .de)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { [weak self](action) in
            self?.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    private func changeLanguage (selectedLanguage :Languages?) {
        DispatchQueue.main.async {
            // change the language
            LanguageManager.shared.setLanguage(language: selectedLanguage ?? .en)
            {  title -> UIViewController in
                let vc = HomeViewController()
                
                // the view controller that you want to show after changing the language
                return vc
            } animation: { view in
                // do custom animation
                view.transform = CGAffineTransform(scaleX: 2, y: 2)
                view.alpha = 0
                
            }
        }
    }
    
}

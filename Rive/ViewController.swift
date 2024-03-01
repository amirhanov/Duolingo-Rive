//
//  ViewController.swift
//  Rive
//
//  Created by Рустам Амирханов on 22.02.2024.
//

import UIKit
import RiveRuntime
import AudioToolbox

class ViewController: UIViewController {
    
    enum constant {
        static let fileName = "duolingo_chest"
        static let inputName = "Tappped"
    }
    
    // MARK: Properties
    
    lazy private var  riveView: RiveView = {
        let riveView = RiveView()
        riveView.translatesAutoresizingMaskIntoConstraints = false
        return riveView
    }()
    
    lazy private var triggerButton: UIButton = {
        let button = AnimationButton()
        button.setTitle("OPEN", for: .normal)
        button.setTitleColor(UIColor(red: 21/255, green: 31/255, blue: 35/255, alpha: 1), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.backgroundColor = UIColor(red: 108/255, green: 189/255, blue: 242/255, alpha: 1)
        button.layer.shadowColor = UIColor(red: 71/255, green: 150/255, blue: 207/255, alpha: 1).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 0.0
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(triggerButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "You earned a total of gems!"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Complete Daily Quests every day to earn more rewards!"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white.withAlphaComponent(0.7)
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var riveModel = RiveViewModel(fileName: constant.fileName)
    
    // MARK: Lifetime
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubview()
        addConstraints()
        setupStackView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        riveModel.setView(riveView)
    }
    
    // MARK: Methods
    
    private func setupView() {
        view.backgroundColor = UIColor(red: 21/255, green: 31/255, blue: 35/255, alpha: 1)
    }
    
    private func addSubview() {
        view.addSubview(riveView)
        view.addSubview(stackView)
        view.addSubview(triggerButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            riveView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            riveView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            riveView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -16),
            riveView.heightAnchor.constraint(equalToConstant: 274),
            riveView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -137),
            
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            triggerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            triggerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            triggerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            triggerButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupStackView() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
    }
    
    // MARK: OBJC
    
    @objc private func triggerButtonTapped() {
        riveModel.triggerInput(constant.inputName)
        triggerButton.setTitle("CONTINUE", for: .normal)
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
}

// MARK: UIButton

class AnimationButton: UIButton {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIView.animate(withDuration: 0.3) {
            self.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: 0.3) {
            self.transform = .identity
        }
    }
}

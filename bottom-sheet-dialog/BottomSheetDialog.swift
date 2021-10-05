//
//  BottomSheetDialog.swift
//  bottom-sheet-dialog
//
//  Created by Wallace Baldenebre on 04/10/21.
//

import UIKit
import SnapKit

class BottomSheetDialog: UIViewController {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Selecione uma opção"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = 8.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let maxDimmedAlpha: CGFloat = 0.6
    lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = maxDimmedAlpha
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var buttonOne = UIButton(frame: .zero)
    lazy var buttonTwo = UIButton(frame: .zero)
    lazy var spacer = UIView(frame: .zero)
    let defaultHeight: CGFloat = 250
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        initTapGesture()
    }
    
    private func initTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleCloseAction))
        dimmedView.addGestureRecognizer(tapGesture)
        setupPanGesture()
    }
    
    @objc func handleCloseAction() {
        animateDismissView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateShowDimmedView()
        animatePresentContainer()
    }
    
    func setupView() {
        view.backgroundColor = .clear
        
        buttonOne = Button(frame: .zero).DefaultButton(self,
                                                       title: "Button One",
                                                       selector: #selector(buttonOneAction))
        
        buttonTwo = Button(frame: .zero).DefaultButton(self,
                                                       title: "Button Two",
                                                       selector: #selector(buttonTwoAction))
    }
    
    @objc func buttonOneAction(sender: UIButton!) {
        print("LOG >> BUTTON ONE")
    }
    
    @objc func buttonTwoAction(sender: UIButton!) {
        print("LOG >> BUTTON TWO")
    }
    
    func setupConstraints() {
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(buttonOne)
        contentStackView.addArrangedSubview(buttonTwo)
        contentStackView.addArrangedSubview(spacer)
        
        containerView.addSubview(contentStackView)
        
        buttonOne.snp.makeConstraints { make in
            make.topMargin.equalTo(titleLabel).inset(15)
            make.height.equalTo(50)
        }
        
        buttonTwo.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        dimmedView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            self.containerViewHeightConstraint = make.height.equalTo(defaultHeight).constraint.layoutConstraints.first
            self.containerViewBottomConstraint = make.bottom.equalTo(defaultHeight).constraint.layoutConstraints.first
        }
        
        contentStackView.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(32)
            make.bottom.equalTo(containerView).inset(20)
            make.leading.equalTo(containerView).offset(20)
            make.trailing.equalTo(containerView).inset(20)
        }
        
        spacer.snp.makeConstraints { make in
            make.height.equalTo(25)
        }
    }
    
    func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(gesture:)))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        view.addGestureRecognizer(panGesture)
    }
    
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        containerViewHeightConstraint?.constant = defaultHeight
        view.layoutIfNeeded()
    }
    
    func animatePresentContainer() {
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    func animateShowDimmedView() {
        dimmedView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = self.maxDimmedAlpha
        }
    }
    
    func animateDismissView() {
        dimmedView.alpha = maxDimmedAlpha
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = self.defaultHeight
            self.view.layoutIfNeeded()
        }
    }
}


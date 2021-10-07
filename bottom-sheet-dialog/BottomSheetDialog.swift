//
//  BottomSheetDialogView.swift
//  bottomsheetdialog-ios
//
//  Created by Wallace on 06/10/21.
//

import UIKit
import SnapKit

class BottomSheetDialog: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = ""
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        return label
    }()
    
    private lazy var contentStackView: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = 12.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var contentHorizontalButtonsStackView: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.spacing = 12.0
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = hexStringToUIColor(hex: "#F5F5F5")
        return view
    }()
    
    private lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = maxDimmedAlpha
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var defaultHeight: CGFloat = 350
    private var dismissibleHeight: CGFloat = 250
    private let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 64
    private var currentContainerHeight: CGFloat = 350
    
    private lazy var buttonOne = UIButton(frame: .zero)
    private lazy var buttonTwo = UIButton(frame: .zero)
    private let maxDimmedAlpha: CGFloat = 0.6
    private var style: DialogStyleEnum!
    private var isScrollable: Bool = false
    
    private var containerViewHeightConstraint: NSLayoutConstraint?
    private var containerViewBottomConstraint: NSLayoutConstraint?
    
    init?(style: DialogStyleEnum, isScrollable: Bool, title: String, description: String) {
        super.init(nibName: nil, bundle: nil)
        self.titleLabel.text = title
        self.descriptionLabel.text = description
        self.isScrollable = isScrollable
        self.setStyle(style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupPanGestureHandleClose()
        setupPanGestureInteraction()
    }
    
    private func setStyle(_ style: DialogStyleEnum) {
        self.style = style
        /*
         switch style {
         case .SIMPLE:
         // TODO
         case .SIMPLE_SINGLE_BUTTON:
         // TODO
         case .SIMPLE_DOUBLE_BUTTON:
         // TODO
         case .SIMPLE_BUTTON_BY_SIDE:
         // TODO
         }
         */
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
        self.buttonOne = Button(frame: .zero).Build(
            context: self,
            style: .RED,
            title: "Button One",
            selector: #selector(buttonOneAction)
        )
        
        self.buttonTwo = Button(frame: .zero).Build(
            context: self,
            style: .DEFAULT,
            title: "Button Two",
            selector: #selector(buttonTwoAction)
        )
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
        contentStackView.addArrangedSubview(descriptionLabel)
        
        if style == .BUTTONS_SIDE_BY_SIDE {
            contentHorizontalButtonsStackView.addArrangedSubview(buttonOne)
            contentHorizontalButtonsStackView.addArrangedSubview(buttonTwo)
            contentStackView.addArrangedSubview(contentHorizontalButtonsStackView)
        } else {
            contentStackView.addArrangedSubview(buttonOne)
            contentStackView.addArrangedSubview(buttonTwo)
        }
        
        containerView.addSubview(contentStackView)
        
        buttonOne.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().inset(15)
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
            //make.bottom.equalTo(containerView).inset(20)
            make.leading.equalTo(containerView).offset(20)
            make.trailing.equalTo(containerView).inset(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.height.equalTo(90)
        }
    }
    
    func setupPanGestureHandleClose() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleCloseAction))
        dimmedView.addGestureRecognizer(tapGesture)
    }
    
    func setupPanGestureInteraction() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(gesture:)))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        view.addGestureRecognizer(panGesture)
    }
    
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        if isScrollable {
            let translation = gesture.translation(in: view)
            let isDraggingDown = translation.y > 0
            let newHeight = currentContainerHeight - translation.y
            
            switch gesture.state {
            case .changed:
                if newHeight < maximumContainerHeight {
                    containerViewHeightConstraint?.constant = newHeight
                    view.layoutIfNeeded()
                }
            case .ended:
                if newHeight < dismissibleHeight {
                    self.animateDismissView()
                } else if newHeight < defaultHeight {
                    animateContainerHeight(defaultHeight)
                } else if newHeight < maximumContainerHeight && isDraggingDown {
                    animateContainerHeight(defaultHeight)
                } else if newHeight > defaultHeight && !isDraggingDown {
                    animateContainerHeight(maximumContainerHeight)
                }
            default:
                break
            }
        } else {
            containerViewHeightConstraint?.constant = defaultHeight
            view.layoutIfNeeded()
        }
    }
    
    func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            self.containerViewHeightConstraint?.constant = height
            self.view.layoutIfNeeded()
        }
        currentContainerHeight = height
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

//
//  BottomSheetDialogView.swift
//  bottomsheetdialog-ios
//
//  Created by Wallace on 06/10/21.
//

import UIKit
import SnapKit

class BottomSheetDialog: UIViewController {
    
    private var pickBar: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.alpha = 0.4
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.center = .zero
        label.sizeToFit()
        return label
    }()
    
    private lazy var contentVerticalButtonsStackView: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = 10.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var contentHorizontalButtonsStackView: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.spacing = 6.0
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
    
    private var defaultHeight: CGFloat = 340
    private var dismissibleHeight: CGFloat = 240
    private let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 64
    private var currentContainerHeight: CGFloat = 340
    
    private lazy var buttonOne = UIButton(frame: .zero)
    private lazy var buttonTwo = UIButton(frame: .zero)
    private var image: UIImageView?
    private var icon: UIImage?
    private let maxDimmedAlpha: CGFloat = 0.6
    private var isScrollable: Bool? = false
    private var style: DialogStyleEnum?
    private var containerViewHeightConstraint: NSLayoutConstraint?
    private var containerViewBottomConstraint: NSLayoutConstraint?
    
    private var titleDialog: String?
    private var descriptionDialog: String?
    private var titleFirstButton: String? = ""
    private var titleSecondButton: String? = ""
    private var actionFirstButton: (() -> Void)?
    private var actionSecondButton: (() -> Void)?
    
    init?(
        style: DialogStyleEnum? = nil,
        isScrollable: Bool? = nil,
        icon: UIImage? = nil,
        titleLabel: String? = nil, description: String? = nil,
        titleFirstButton: String, actionFirstButton: @escaping () -> Void,
        titleSecondButton: String? = nil, actionSecondButton: (() -> Void)? = nil
    ) {
        super.init(nibName: nil, bundle: nil)
        self.icon = icon
        self.titleDialog = titleLabel
        self.descriptionDialog = description
        self.isScrollable = isScrollable
        self.titleFirstButton = titleFirstButton
        self.actionFirstButton = actionFirstButton
        self.titleSecondButton = titleSecondButton
        self.actionSecondButton = actionSecondButton
        self.style = style
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
    
    private func setStyle() {
        if self.style == nil || self.style == .DEFAULT {
            contentVerticalButtonsStackView.addArrangedSubview(buttonOne)
            contentVerticalButtonsStackView.addArrangedSubview(buttonTwo)
            
            if icon == nil {
                defaultHeight = defaultHeight - 30
                dismissibleHeight = dismissibleHeight - 30
                currentContainerHeight = currentContainerHeight - 30
            }
            
            if titleDialog == nil {
                defaultHeight = defaultHeight - 30
                dismissibleHeight = dismissibleHeight - 30
                currentContainerHeight = currentContainerHeight - 30
            }
            
            if descriptionDialog == nil {
                defaultHeight = defaultHeight - 70
                dismissibleHeight = dismissibleHeight - 70
                currentContainerHeight = currentContainerHeight - 70
            }
            
            if titleSecondButton == nil || actionSecondButton == nil {
                defaultHeight = defaultHeight - 50
                dismissibleHeight = dismissibleHeight - 50
                currentContainerHeight = currentContainerHeight - 50
            }
        } else if self.style != nil && self.style == .SIDE_BY_SIDE {
            contentHorizontalButtonsStackView.addArrangedSubview(buttonOne)
            contentHorizontalButtonsStackView.addArrangedSubview(buttonTwo)
            contentVerticalButtonsStackView.addArrangedSubview(contentHorizontalButtonsStackView)
            
            defaultHeight = 270
            dismissibleHeight = 170
            currentContainerHeight = 270
        } else {
            contentVerticalButtonsStackView.addArrangedSubview(buttonOne)
            contentVerticalButtonsStackView.addArrangedSubview(buttonTwo)
        }
        
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
        self.buttonOne = BlueButton(frame: .zero).build(
            context: self,
            title: titleFirstButton!,
            selector: #selector(firstButtonActionPressed)
        )
        
        titleSecondButton?.onExecute{ _ in
            self.buttonTwo = WhiteButton(frame: .zero).build(
                context: self,
                title: titleSecondButton!,
                selector: #selector(secondButtonActionPressed)
            )
        }
    }
    
    @objc func firstButtonActionPressed(sender: UIButton!) {
        animateDismissView()
        actionFirstButton!()
    }
    
    @objc func secondButtonActionPressed(sender: UIButton!) {
        animateDismissView()
        actionSecondButton!()
    }
    
    func setupConstraints() {
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        
        containerView.addSubview(pickBar)
        
        icon?.onExecute { _view in
            image = UIImageView(image: _view)
            containerView.addSubview(image!)
        }
        
        titleLabel.onExecute { _view in
            self.titleLabel.text = titleDialog
            containerView.addSubview(_view)
        }
        
        descriptionLabel.onExecute { _view in
            self.descriptionLabel.text = descriptionDialog
            containerView.addSubview(_view)
        }
        
        self.setStyle()
        
        containerView.addSubview(contentVerticalButtonsStackView)
        
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
        
        pickBar.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(8)
            make.centerX.equalToSuperview()
            make.width.equalTo(70)
            make.height.equalTo(4)
        }
        
        icon?.onExecute { _view in
            image!.snp.makeConstraints { make in
                make.topMargin.equalTo(pickBar).offset(30)
                make.centerX.equalToSuperview()
                make.width.equalTo(30)
                make.height.equalTo(30)
            }
        }
        
        titleDialog?.onExecute { _ in
            titleLabel.snp.makeConstraints { make in
                if icon == nil { make.topMargin.equalTo(pickBar).offset(30) }
                icon?.onExecute { _view in make.topMargin.equalTo(image!).offset(40) }
                
                make.centerX.equalToSuperview()
                make.height.equalTo(30)
            }
        }
        
        descriptionDialog?.onExecute { _ in
            descriptionLabel.snp.makeConstraints { make in
                make.topMargin.equalTo(titleLabel).offset(30)
                make.centerX.equalToSuperview()
                make.height.equalTo(70)
            }
        }
        
        contentVerticalButtonsStackView.snp.makeConstraints { make in
            if descriptionDialog == nil { make.topMargin.equalTo(titleLabel).offset(35) }
            descriptionDialog?.onExecute { _ in make.topMargin.equalTo(descriptionLabel).offset(70) }
            
            make.leading.equalTo(containerView).offset(20)
            make.trailing.equalTo(containerView).inset(20)
        }
        
        buttonOne.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        titleSecondButton?.onExecute { _ in
            buttonTwo.snp.makeConstraints { make in
                make.height.equalTo(50)
            }
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
        if isScrollable == true {
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
            let translation = gesture.translation(in: view)
            let newHeight = currentContainerHeight - translation.y
            
            if gesture.state == .ended {
                if newHeight < dismissibleHeight {
                    self.animateDismissView()
                }
            }
        }
    }
    
    func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.3) {
            self.containerViewHeightConstraint?.constant = height
            self.view.layoutIfNeeded()
        }
        currentContainerHeight = height
    }
    
    func animatePresentContainer() {
        UIView.animate(withDuration: 0.2) {
            self.containerViewBottomConstraint?.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    func animateShowDimmedView() {
        dimmedView.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.dimmedView.alpha = self.maxDimmedAlpha
        }
    }
    
    func animateDismissView() {
        dimmedView.alpha = maxDimmedAlpha
        UIView.animate(withDuration: 0.3) {
            self.dimmedView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
        }
        
        UIView.animate(withDuration: 0.2) {
            self.containerViewBottomConstraint?.constant = self.defaultHeight
            self.view.layoutIfNeeded()
        }
    }
}

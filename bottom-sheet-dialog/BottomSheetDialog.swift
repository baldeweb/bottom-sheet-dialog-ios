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
        let label = UILabel()
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
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var contentHorizontalButtonsStackView: UIStackView = {
        let spacer = UIView()
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 6.0
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = hexStringToUIColor(hex: "#FFFFFF")
        return view
    }()
    
    private lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = maxDimmedAlpha
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var defaultHeight: CGFloat = UIScreen.main.bounds.height
    private var dismissibleHeight: CGFloat = UIScreen.main.bounds.height - 100
    private let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 64
    private var currentContainerHeight: CGFloat = UIScreen.main.bounds.height
    
    private lazy var layout: UIViewController? = nil
    private lazy var buttonAction = UIButton()
    private lazy var buttonReturn = UIButton()
    private var image: UIImageView?
    private var icon: UIImage?
    private let maxDimmedAlpha: CGFloat = 0.6
    private var isScrollable: Bool? = false
    private var style: DialogStyleEnum?
    private var containerViewHeightConstraint: NSLayoutConstraint?
    private var containerViewBottomConstraint: NSLayoutConstraint?
    
    private var titleDialog: String?
    private var descriptionDialog: String?
    private var titleActionButton: String? = ""
    private var titleReturnButton: String? = ""
    private var actionButton: (() -> Void)?
    private var actionReturnButton: (() -> Void)?
    
    init?(
        layout: UIViewController,
        style: DialogStyleEnum? = nil,
        isScrollable: Bool? = nil,
        icon: UIImage? = nil,
        titleLabel: String? = nil,
        titleActionButton: String? = nil,
        actionButton: (() -> Void)? = nil,
        titleReturnButton: String? = nil,
        actionReturnButton: (() -> Void)? = nil
    ) {
        super.init(nibName: nil, bundle: nil)
        self.layout = layout
        self.style = style
        self.isScrollable = isScrollable
        self.icon = icon
        self.titleDialog = titleLabel
        self.titleActionButton = titleActionButton
        self.actionButton = actionButton
        self.titleReturnButton = titleReturnButton
        self.actionReturnButton = actionReturnButton
    }
    
    init?(
        style: DialogStyleEnum? = nil,
        isScrollable: Bool? = nil,
        icon: UIImage? = nil,
        titleLabel: String? = nil,
        description: String? = nil,
        titleActionButton: String? = nil,
        actionButton: (() -> Void)? = nil,
        titleReturnButton: String? = nil,
        actionReturnButton: (() -> Void)? = nil
    ) {
        super.init(nibName: nil, bundle: nil)
        self.style = style
        self.isScrollable = isScrollable
        self.icon = icon
        self.titleDialog = titleLabel
        self.descriptionDialog = description
        self.titleActionButton = titleActionButton
        self.actionButton = actionButton
        self.titleReturnButton = titleReturnButton
        self.actionReturnButton = actionReturnButton
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
        if self.style != nil && self.style == .SIDE_BY_SIDE {
            contentHorizontalButtonsStackView.addArrangedSubview(buttonReturn)
            contentHorizontalButtonsStackView.addArrangedSubview(buttonAction)
            contentVerticalButtonsStackView.addArrangedSubview(contentHorizontalButtonsStackView)
        } else {
            if actionButton != nil {
                contentVerticalButtonsStackView.addArrangedSubview(buttonAction)
            }
            
            if actionReturnButton != nil {
                contentVerticalButtonsStackView.addArrangedSubview(buttonReturn)
            }
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
        if titleActionButton != nil {
            self.buttonAction = BlueButton(frame: .zero).build(
                context: self,
                title: titleActionButton!,
                selector: #selector(firstButtonActionPressed)
            )
        }
        
        if titleReturnButton != nil {
            self.buttonReturn = WhiteButton(frame: .zero).build(
                context: self,
                title: titleReturnButton!,
                selector: #selector(secondButtonActionPressed)
            )
        }
    }
    
    @objc func firstButtonActionPressed(sender: UIButton!) {
        animateDismissView()
        actionButton!()
    }
    
    @objc func secondButtonActionPressed(sender: UIButton!) {
        animateDismissView()
        actionReturnButton!()
    }
    
    func setupConstraints() {
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        
        containerView.addSubview(pickBar)
        
        if icon != nil {
            image = UIImageView(image: icon)
            containerView.addSubview(image!)
        }
        
        if titleDialog != nil {
            self.titleLabel.text = titleDialog
            containerView.addSubview(titleLabel)
        }
        
        if descriptionDialog != nil {
            self.descriptionLabel.text = descriptionDialog
            containerView.addSubview(descriptionLabel)
        }
        
        if layout != nil {
            embed(containerView, layout!)
        }
        
        containerView.addSubview(contentVerticalButtonsStackView)
        
        self.setStyle()
        
        dimmedView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.greaterThanOrEqualTo(0)
            self.containerViewHeightConstraint = make.height.greaterThanOrEqualTo(0).constraint.layoutConstraints.first
            self.containerViewBottomConstraint = make.bottom.equalTo(defaultHeight).constraint.layoutConstraints.first
        }
        
        pickBar.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(8)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(4)
        }
        
        if icon != nil {
            image!.snp.makeConstraints { make in
                make.topMargin.equalTo(pickBar).offset(30)
                make.centerX.equalToSuperview()
                make.width.equalTo(30)
                make.height.equalTo(30)
            }
        }
        
        if titleDialog != nil {
            titleLabel.snp.makeConstraints { make in
                if icon == nil { make.topMargin.equalTo(pickBar).offset(30) }
                if icon != nil { make.topMargin.equalTo(image!).offset(40) }
                
                if layout == nil { make.bottomMargin.equalTo(pickBar).offset(30) }
                if layout != nil && icon != nil {
                    make.topMargin.equalTo(image!).offset(40)
                }
                
                make.leading.equalTo(containerView).offset(20)
                make.trailing.equalTo(containerView).inset(20)
                make.height.equalTo(30)
            }
        }
        
        if descriptionDialog != nil {
            descriptionLabel.snp.makeConstraints { make in
                if titleDialog != nil { make.topMargin.equalTo(titleLabel.snp.bottom).offset(6) }
                make.leading.equalTo(containerView).offset(20)
                make.trailing.equalTo(containerView).inset(20)
                make.height.greaterThanOrEqualTo(0)
            }
        }
        
        if layout != nil {
            layout!.view.snp.makeConstraints { make in
                if titleDialog != nil { make.topMargin.equalTo(titleLabel.snp.bottomMargin).offset(20) }
                make.leading.equalTo(containerView).offset(20)
                make.trailing.equalTo(containerView).inset(20)
                make.height.greaterThanOrEqualTo(0)
            }
        }
        
        contentVerticalButtonsStackView.snp.makeConstraints { make in
            if layout != nil {
                make.topMargin.equalTo(layout!.view.snp.bottomMargin).offset(20)
            } else {
                if descriptionDialog == nil && titleDialog != nil {
                    make.topMargin.equalTo(titleLabel).offset(35)
                }
                if descriptionDialog != nil { make.topMargin.equalTo(descriptionLabel.snp.bottomMargin).offset(30) }
            }
            make.leading.equalTo(containerView).offset(20)
            make.trailing.equalTo(containerView).inset(20)
            make.bottomMargin.equalTo(containerView)
            make.height.greaterThanOrEqualTo(0)
        }
        
        if titleActionButton != nil || actionButton != nil {
            buttonAction.snp.makeConstraints { make in
                make.height.equalTo(50)
            }
        }
        
        if titleReturnButton != nil || actionReturnButton != nil {
            buttonReturn.snp.makeConstraints { make in
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
            print("LOG >> [handlePanGesture] newHeight: \(newHeight)")
            
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

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
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var contentHorizontalButtonsStackView: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView()
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
        titleActionButton: String,
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
        titleActionButton: String,
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
    
//    override func viewDidLayoutSubviews() {
//        setupHeight()
//    }
    
    private func setupHeight() {
        let iconHeight = (self.image?.frame.size.height ?? 0.0) as CGFloat
        let titleHeight = self.titleLabel.frame.size.height as CGFloat
        let descriptionHeight = self.descriptionLabel.frame.size.height as CGFloat
        let layoutHeight = (self.layout?.view.frame.size.height ?? 0.0) as CGFloat
        let contentVerticalHeight = self.contentVerticalButtonsStackView.frame.size.height as CGFloat
        let contentHorizontalHeight = self.contentHorizontalButtonsStackView.frame.size.height as CGFloat
        
        print("LOG >> \nicon: \(iconHeight) | title: \(titleHeight) | description: \(descriptionHeight) | \nlayout: \(layoutHeight) | containerVertical: \(contentVerticalHeight) | containerHorizontal: \(contentHorizontalHeight)")
        
        self.defaultHeight = iconHeight + titleHeight + descriptionHeight + layoutHeight + contentVerticalHeight + contentHorizontalHeight
        self.dismissibleHeight = (iconHeight + titleHeight + descriptionHeight + layoutHeight + contentVerticalHeight + contentHorizontalHeight) - 100
        self.currentContainerHeight = iconHeight + titleHeight + descriptionHeight + layoutHeight + contentVerticalHeight + contentHorizontalHeight
        
        print("LOG >> \ndefaultHeight: \(self.defaultHeight) | dismissibleHeight: \(self.dismissibleHeight) | currentContainerHeight: \(self.currentContainerHeight)")
    }
    
    private func setStyle() {
        if self.style == nil || self.style == .DEFAULT {
            contentVerticalButtonsStackView.addArrangedSubview(buttonAction)
            contentVerticalButtonsStackView.addArrangedSubview(buttonReturn)
            
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
            
            if titleReturnButton == nil || actionReturnButton == nil {
                defaultHeight = defaultHeight - 50
                dismissibleHeight = dismissibleHeight - 50
                currentContainerHeight = currentContainerHeight - 50
            }
        } else if self.style != nil && self.style == .SIDE_BY_SIDE {
            contentHorizontalButtonsStackView.addArrangedSubview(buttonReturn)
            contentHorizontalButtonsStackView.addArrangedSubview(buttonAction)
            contentVerticalButtonsStackView.addArrangedSubview(contentHorizontalButtonsStackView)
            
            defaultHeight = 270
            dismissibleHeight = 170
            currentContainerHeight = 270
        } else {
            contentVerticalButtonsStackView.addArrangedSubview(buttonAction)
            contentVerticalButtonsStackView.addArrangedSubview(buttonReturn)
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
        self.buttonAction = BlueButton(frame: .zero).build(
            context: self,
            title: titleActionButton!,
            selector: #selector(firstButtonActionPressed)
        )
        
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
            embed(view, layout!)
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
            self.containerViewHeightConstraint = make.height.equalTo(defaultHeight).constraint.layoutConstraints.first
            self.containerViewBottomConstraint = make.bottom.equalTo(defaultHeight).constraint.layoutConstraints.first
        }
        
        pickBar.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(8)
            make.centerX.equalToSuperview()
            make.width.equalTo(70)
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
                
                make.centerX.equalToSuperview()
                make.height.equalTo(30)
            }
        }
        
        if descriptionDialog != nil {
            descriptionLabel.snp.makeConstraints { make in
                make.topMargin.equalTo(titleLabel).offset(30)
                make.centerX.equalToSuperview()
                make.height.equalTo(70)
            }
        }
        
        if layout != nil {
            layout?.view.snp.makeConstraints { make in
                make.topMargin.equalTo(titleLabel.snp.bottomMargin).offset(20)
                make.leading.equalTo(containerView).offset(20)
                make.trailing.equalTo(containerView).inset(20)
                make.height.greaterThanOrEqualTo(0)
            }
        }
        
        contentVerticalButtonsStackView.snp.makeConstraints { make in
            if layout != nil {
                make.topMargin.equalTo(layout!.view.snp.bottomMargin).offset(20)
            } else {
                if descriptionDialog == nil { make.topMargin.equalTo(titleLabel).offset(35) }
                if descriptionDialog != nil { make.topMargin.equalTo(descriptionLabel).offset(70) }
            }
            make.leading.equalTo(containerView).offset(20)
            make.trailing.equalTo(containerView).inset(20)
            make.height.greaterThanOrEqualTo(0)
        }
        
        buttonAction.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        if titleReturnButton != nil {
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

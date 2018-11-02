//
//  PopupVeiwController.swift
//  Test1
//
//  Created by Masoud Heydari on 11/1/18.
//  Copyright © 2018 Masoud Heydari. All rights reserved.
//

import UIKit

protocol CustomPopupViewControllerDelegate: class {
    /// It is called when pop up is dismissed by tap outside
    func popupViewControllerDidDismiss(sender: CustomPopupViewController)
}

// optional func
extension CustomPopupViewControllerDelegate {
    func popupViewControllerDidDismiss(sender: CustomPopupViewController) {}
}

public class CustomPopupViewController: UIViewController {
    
    public enum PopupPosition {
        /// Align center X, center Y with offset param
        case center(CGPoint?)
        
        /// Top left anchor point with offset param
        case topLeft(CGPoint?)
        
        /// Top right anchor point with offset param
        case topRight(CGPoint?)
        
        /// Bottom left anchor point with offset param
        case bottomLeft(CGPoint?)
        
        /// Bottom right anchor point with offset param
        case bottomRight(CGPoint?)
        
        /// Top anchor, align center X with top padding param
        case top(CGFloat)
        
        /// Left anchor, align center Y with left padding param
        case left(CGFloat)
        
        /// Bottom anchor, align center X with bottom padding param
        case bottom(CGFloat)
        
        /// Right anchor, align center Y with right padding param
        case right(CGFloat)
    }
    
    /// Popup width, it's nil if width is determined by view's intrinsic size
    private(set) public var popupWidth: CGFloat?
    
    /// Popup height, it's nil if width is determined by view's intrinsic size
    private(set) public var popupHeight: CGFloat?
    
    /// Popup position, default is center
    private(set) public var position: PopupPosition = .center(nil)
    
    /// Background alpha, default is 0.5
    public var backgroundAlpha: CGFloat = 0.5
    
    /// Background color, default is black
    public var backgroundColor = UIColor.black
    
    /// Allow tap outside popup to dismiss, default is true
    public var canTapOutsideToDismiss = true
    
    /// Corner radius, default is 0 (no rounded corner)
    public var cornerRadius: CGFloat = 0
    
    /// Shadow enabled, default is true
    public var shadowEnabled = true
    
    /// The pop up view controller. It's not mandatory.
    private(set) public var contentController: UIViewController?
    
    /// The pop up view
    private(set) public var contentView: UIView?
    
    /// The delegate to receive pop up event
    weak var delegate: CustomPopupViewControllerDelegate?
    
    private var containerView = UIView()
    
    /// NOTE: Don't use this init method
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public init(contentController: UIViewController, position: PopupPosition = .center(nil), popupWidth: CGFloat? = nil, popupHeight: CGFloat? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.contentController = contentController
        self.contentView = contentController.view
        self.popupWidth = popupWidth
        self.popupHeight = popupHeight
        self.position = position
        
        commonInit()
    }
    
    public init(contentView: UIView, position: PopupPosition = .center(nil), popupWidth: CGFloat? = nil, popupHeight: CGFloat? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.contentView = contentView
        self.popupWidth = popupWidth
        self.popupHeight = popupHeight
        self.position = position
        
        commonInit()
    }
    
    private func commonInit() {
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupViews()
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        guard let location = touch?.location(in: self.view) else { return }
        if !containerView.frame.contains(location) {
            print("Tapped outside the custom popup")
            self.delegate?.popupViewControllerDidDismiss(sender: self)
            self.dismiss(animated: true)
        }else {
            print("Tapped inside the custom popup")
        }
    }
    
    
    // MARK: - Setup
    private func addDismissGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissTapGesture(gesture:)))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupUI() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView?.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = backgroundColor.withAlphaComponent(backgroundAlpha)
        
        if cornerRadius > 0 {
            contentView?.layer.cornerRadius = cornerRadius
            contentView?.layer.masksToBounds = true
        }
        
        if shadowEnabled {
            containerView.layer.shadowOpacity = 0.5
            containerView.layer.shadowColor = UIColor.black.cgColor
            containerView.layer.shadowOffset = CGSize(width: 5, height: 5)
            containerView.layer.shadowRadius = 5
        }
    }
    
    private func setupViews() {
        if let contentController = contentController {
            addChild(contentController)
        }
        
        addViews()
        addSizeConstraints()
        addPositionConstraints()
    }
    
    private func addViews() {
        view.addSubview(containerView)
        
        if let contentView = contentView {
            containerView.addSubview(contentView)
            contentView.topAnchor.constraint(equalTo: self.containerView.topAnchor).isActive = true
            contentView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor).isActive = true
            contentView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor).isActive = true
            contentView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor).isActive = true
        }
    }
    
    // MARK: - Add constraints
    private func addSizeConstraints() {
        if let popupWidth = popupWidth {
            containerView.widthAnchor.constraint(equalToConstant: popupWidth).isActive = true
        }
        
        if let popupHeight = popupHeight {
            containerView.heightAnchor.constraint(equalToConstant: popupHeight).isActive = true
        }
    }
    
    private func addPositionConstraints() {
        switch position {
        case .center(let offset):
            addCenterPositionConstraints(offset: offset)
            
        case .topLeft(let offset):
            addTopLeftPositionConstraints(offset: offset)
            
        case .topRight(let offset):
            addTopRightPositionConstraints(offset: offset)
            
        case .bottomLeft(let offset):
            addBottomLeftPositionConstraints(offset: offset)
            
        case .bottomRight(let offset):
            addBottomRightPositionConstraints(offset: offset)
            
        case .top(let offset):
            addTopPositionConstraints(offset: offset)
            
        case .left(let offset):
            addLeftPositionConstraints(offset: offset)
            
        case .bottom(let offset):
            addBottomPositionConstraints(offset: offset)
            
        case .right(let offset):
            addRightPositionConstraints(offset: offset)
        }
    }
    
    private func addCenterPositionConstraints(offset: CGPoint?) {
        containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: offset?.x ?? 0).isActive = true
        containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: offset?.y ?? 0).isActive = true
    }
    
    private func addTopLeftPositionConstraints(offset: CGPoint?) {
        containerView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: offset?.x ?? 0).isActive = true
        containerView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: offset?.y ?? 0).isActive = true
    }
    
    private func addTopRightPositionConstraints(offset: CGPoint?) {
        containerView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: offset?.x ?? 0).isActive = true
        containerView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: offset?.y ?? 0).isActive = true
    }
    
    private func addBottomLeftPositionConstraints(offset: CGPoint?) {
        containerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: offset?.x ?? 0).isActive = true
        containerView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: offset?.y ?? 0).isActive = true
    }
    
    private func addBottomRightPositionConstraints(offset: CGPoint?) {
        containerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: offset?.x ?? 0).isActive = true
        containerView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: offset?.y ?? 0).isActive = true
    }
    
    private func addTopPositionConstraints(offset: CGFloat) {
        containerView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: offset).isActive = true
        containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: offset).isActive = true
    }
    
    private func addLeftPositionConstraints(offset: CGFloat) {
        containerView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: offset).isActive = true
        containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: offset).isActive = true
    }
    
    private func addBottomPositionConstraints(offset: CGFloat) {
        containerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: offset).isActive = true
        containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: offset).isActive = true
    }
    
    private func addRightPositionConstraints(offset: CGFloat) {
        containerView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: offset).isActive = true
        containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: offset).isActive = true
    }
    
    // MARK: - Actions
    @objc func dismissTapGesture(gesture: UIGestureRecognizer) {
//        dismiss(animated: true) {
//            print(1)
//            self.delegate?.popupViewControllerDidDismiss(sender: self)
//        }
    }
}

// MARK: - UIGestureRecognizerDelegate
extension CustomPopupViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        print(2)
        guard let touchView = touch.view, canTapOutsideToDismiss else {
            return false
        }
        if !touchView.isDescendant(of: containerView){
            dismiss(animated: true) {
                self.delegate?.popupViewControllerDidDismiss(sender: self)
            }
        }
        
        return !touchView.isDescendant(of: containerView)
    }
}

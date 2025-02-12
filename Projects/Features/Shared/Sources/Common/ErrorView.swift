//
//  ErrorView.swift
//  Shared
//
//  Created by Jeans Ruiz on 8/2/20.
//

import UIKit
import UI

public class ErrorView: NiblessView {

  private lazy var mainStackView: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [imageView, titleLabel, messageLabel, retryButton])
    stack.axis = .vertical
    stack.alignment = .center
    stack.distribution = .fill
    stack.spacing = 16.0
    return stack
  }()

  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(name: "Error003")
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  private let titleLabel = TVBoldLabel(frame: .zero)
  let messageLabel = TVRegularLabel(frame: .zero)
  private let retryButton = LoadableButton(frame: .zero)

  var retry: (() -> Void)?

  public override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }

  private func setupUI() {
    constructHierarchy()
    activateConstraints()
    configureViews()
  }

  private func constructHierarchy() {
    addSubview(mainStackView)
  }

  private func activateConstraints() {
    activateConstraintsForStackView()
    activateConstraintsForImage()
  }

  private func activateConstraintsForStackView() {
    mainStackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      mainStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
      mainStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
      mainStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8)
    ])
  }

  private func activateConstraintsForImage() {
    imageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 10/8)
    ])
  }

  private func configureViews() {
    backgroundColor = .systemBackground

    titleLabel.text = "Oops!"
    titleLabel.tvSize = .custom(25)
    messageLabel.numberOfLines = 0

    retryButton.setTitle("Retry", for: .normal)
    retryButton.defaultTitle = "Retry"
    retryButton.backgroundColor = .systemBlue
    retryButton.setTitleColor(.white, for: .normal) // MARK: - TODO, change?
    retryButton.titleLabel?.font = Font.sanFrancisco.of(type: .regular, with: .normal)

    retryButton.contentEdgeInsets = UIEdgeInsets(top: 7, left: 15, bottom: 7, right: 15)

    retryButton.layer.cornerRadius = 5

    retryButton.addTarget(self, action: #selector(retryAction), for: .touchUpInside)
  }

  @objc private func retryAction() {
    retryButton.defaultShowLoadingView()
    retry?()
  }
}

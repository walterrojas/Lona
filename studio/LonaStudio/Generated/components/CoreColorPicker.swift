import ColorPicker

// LONA: KEEP ABOVE

import AppKit
import Foundation

// MARK: - CoreColorPicker

public class CoreColorPicker: NSBox {

  // MARK: Lifecycle

  public init(_ parameters: Parameters) {
    self.parameters = parameters

    super.init(frame: .zero)

    setUpViews()
    setUpConstraints()

    update()
  }

  public convenience init(colorValue: ColorPickerColor) {
    self.init(Parameters(colorValue: colorValue))
  }

  public convenience init() {
    self.init(Parameters())
  }

  public required init?(coder aDecoder: NSCoder) {
    self.parameters = Parameters()

    super.init(coder: aDecoder)

    setUpViews()
    setUpConstraints()

    update()
  }

  // MARK: Public

  public var colorValue: ColorPickerColor {
    get { return parameters.colorValue }
    set {
      if parameters.colorValue != newValue {
        parameters.colorValue = newValue
      }
    }
  }

  public var onChangeColorValue: ColorPickerHandler {
    get { return parameters.onChangeColorValue }
    set { parameters.onChangeColorValue = newValue }
  }

  public var parameters: Parameters {
    didSet {
      if parameters != oldValue {
        update()
      }
    }
  }

  // MARK: Private

  private var colorPickerView = ColorPicker()

  private func setUpViews() {
    boxType = .custom
    borderType = .noBorder
    contentViewMargins = .zero

    addSubview(colorPickerView)
  }

  private func setUpConstraints() {
    translatesAutoresizingMaskIntoConstraints = false
    colorPickerView.translatesAutoresizingMaskIntoConstraints = false

    let heightAnchorConstraint = heightAnchor.constraint(equalToConstant: 240)
    let colorPickerViewTopAnchorConstraint = colorPickerView.topAnchor.constraint(equalTo: topAnchor)
    let colorPickerViewBottomAnchorConstraint = colorPickerView.bottomAnchor.constraint(equalTo: bottomAnchor)
    let colorPickerViewLeadingAnchorConstraint = colorPickerView.leadingAnchor.constraint(equalTo: leadingAnchor)
    let colorPickerViewTrailingAnchorConstraint = colorPickerView.trailingAnchor.constraint(equalTo: trailingAnchor)

    NSLayoutConstraint.activate([
      heightAnchorConstraint,
      colorPickerViewTopAnchorConstraint,
      colorPickerViewBottomAnchorConstraint,
      colorPickerViewLeadingAnchorConstraint,
      colorPickerViewTrailingAnchorConstraint
    ])
  }

  private func update() {
    colorPickerView.colorValue = colorValue
    colorPickerView.onChangeColorValue = handleOnChangeColorValue
  }

  private func handleOnChangeColorValue(_ arg0: SwiftColor) {
    onChangeColorValue?(arg0)
  }
}

// MARK: - Parameters

extension CoreColorPicker {
  public struct Parameters: Equatable {
    public var colorValue: ColorPickerColor
    public var onChangeColorValue: ColorPickerHandler

    public init(colorValue: ColorPickerColor, onChangeColorValue: ColorPickerHandler = nil) {
      self.colorValue = colorValue
      self.onChangeColorValue = onChangeColorValue
    }

    public init() {
      self.init(colorValue: nil)
    }

    public static func ==(lhs: Parameters, rhs: Parameters) -> Bool {
      return lhs.colorValue == rhs.colorValue
    }
  }
}

// MARK: - Model

extension CoreColorPicker {
  public struct Model: LonaViewModel, Equatable {
    public var id: String?
    public var parameters: Parameters
    public var type: String {
      return "CoreColorPicker"
    }

    public init(id: String? = nil, parameters: Parameters) {
      self.id = id
      self.parameters = parameters
    }

    public init(_ parameters: Parameters) {
      self.parameters = parameters
    }

    public init(colorValue: ColorPickerColor, onChangeColorValue: ColorPickerHandler = nil) {
      self.init(Parameters(colorValue: colorValue, onChangeColorValue: onChangeColorValue))
    }

    public init() {
      self.init(colorValue: nil)
    }
  }
}

// LONA: KEEP BELOW

extension CoreColorPicker {
    convenience init(<#parameters#>) {
        <#statements#>
    }
}

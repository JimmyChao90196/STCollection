import SwiftUI

public struct STFlexFieldList<ReturnedView: View>: View {
    
    @FocusState.Binding public var isFocusedOn: STTextFieldType?
    @State var currentValue: String? = nil
    @State var currentValues: [STTextFieldType: String] = [:]
    var textFields: [InputFieldType]
    var isDisableAutoCorrecting: Bool = true
    var foregroundColor: Color = .ST_595757
    var isShowIcon: Bool = true
    var style: STFieldStyle = .normal
    var spacing: CGFloat = 10
    var titleSpacing: CGFloat = 5
    var titleColor: Color = .ST_1B0851
    
    var returnedTextField: (AnyView, STTextFieldType, String?) -> ReturnedView
    var returnValue: ((String) -> Void)?
    var onSubmit: (() -> Void)?
    
    public init(
        isFocusedOn: FocusState<STTextFieldType?>.Binding,
        textFields: [InputFieldType],
        isDisableAutoCorrecting: Bool = true,
        foregroundColor: Color = .ST_595757,
        isShowIcon: Bool = false,
        style: STFieldStyle = .normal,
        spacing: CGFloat = 10,
        titleSpacing: CGFloat = 5,
        titleColor: Color = .ST_1B0851,
        returnedTextField: @escaping (AnyView, STTextFieldType, String?) -> ReturnedView,
        onSubmit: (() -> Void)? = nil
    ) {
        _isFocusedOn = isFocusedOn
        self.textFields = textFields
        self.isDisableAutoCorrecting = isDisableAutoCorrecting
        self.foregroundColor = foregroundColor
        self.isShowIcon = isShowIcon
        self.style = style
        self.spacing = spacing
        self.titleSpacing = titleSpacing
        self.titleColor = titleColor
        self.returnedTextField = returnedTextField
        self.onSubmit = onSubmit
    }
    
    public var body: some View {
        VStack(spacing: spacing) {
            ForEach(Array(textFields.enumerated()), id: \.element) { index, element in
                returnedTextField(
                    AnyView(createTextFieldView(for: element, index: index)),
                    findField(for: element),
                    currentValues[findField(for: element)]
                )
            }
        }
    }
    
    // Find textfield type
    private func findField(for element: InputFieldType) -> STTextFieldType {
        switch element {
        case .secure(_, let textFieldType):
            return textFieldType
        case .text(_, let textFieldType):
            return textFieldType
        case .date(_, let textFieldType, _):
            return textFieldType
        }
    }
    
    // Create Input views
    @ViewBuilder
    private func createTextFieldView(for element: InputFieldType, index: Int) -> some View {
        VStack(alignment: .leading, spacing: titleSpacing) {
            switch element {
                
            case .secure(let binding, let textFieldType):
                
                STSecureField(
                    password: binding,
                    style: style,
                    placeholder: textFieldType.placeholder,
                    isShowIcon: self.isShowIcon,
                    isFieldFocus: $isFocusedOn,
                    fieldType: textFieldType) { value in
                        
                        currentValues[textFieldType] = value
                        //onChange?(value)
                    }
                    .fieldSetting(keyboardType: .asciiCapable)
                    .id(textFieldType.title)
                    .onSubmit {
                        submitAction(index: index)
                        onSubmit?()
                    }
                    .onTapGesture {}
                    .disableAutocorrection(isDisableAutoCorrecting)
                
                
            case .text(let binding, let textFieldType):
                
                STTextFeild(
                    inputData: binding,
                    placeholder: textFieldType.placeholder,
                    isShowIcon: self.isShowIcon,
                    foregroundColor: foregroundColor,
                    style: style,
                    fieldType: textFieldType) { value in
                        currentValues[textFieldType] = value
                    }
                .fieldSetting(keyboardType: textFieldType.keyboardType)
                .id(textFieldType.title)
                .focused($isFocusedOn, equals: textFieldType)
                .onSubmit {
                    submitAction(index: index)
                    onSubmit?()
                }
                .onTapGesture {}
                .disableAutocorrection(isDisableAutoCorrecting)
                
                
            case .date(let binding, let textFieldType, let restriction):
                
                STDateField(
                    placeholder: textFieldType.placeholder,
                    selectedDate: binding,
                    foregroundColor: foregroundColor,
                    style: style,
                    dateRestriction: restriction)
                .id(textFieldType.title)
                .onTapGesture {}
            }
        }
    }
    
    // MARK: Helper function -
    // Switch focus to the next text field based on the current index
    private func submitAction(index: Int) {
        let nextIndex = index + 1
        if nextIndex < textFields.count {
            switch textFields[nextIndex] {
            case .text(_, let nextType):
                isFocusedOn = nextType
            case .date(_, let nextType, _):
                isFocusedOn = nextType
            case .secure(_, let nextType):
                isFocusedOn = nextType
            }
        } else {
            isFocusedOn = nil
        }
    }
}

import SwiftUI

@available(*, deprecated, message: "The STFlexFieldList protocol will not be supported in the future update.")
public struct STFlexFieldList<ReturnedView: View>: View {
    
    @FocusState.Binding public var isFocusedOn: STTextFieldType?
    @State var currentValue: String? = nil
    @State var currentValues: [STTextFieldType: String] = [:]
    var textFields: [InputFieldType]
    var axis: Axis.Set = .vertical
    var isDisableAutoCorrecting: Bool = true
    var foregroundColor: Color = .ST_595757
    var isShowIcon: Bool = true
    var style: STFieldStyle = .normal
    var spacing: CGFloat = 10
    var titleSpacing: CGFloat = 5
    var titleColor: Color = .ST_1B0851
    
    
    // View
    var returnedTextField: (AnyView, STTextFieldType, String?) -> ReturnedView
    
    // Error
    @State var isEmpty: [STTextFieldType: (Bool, LocalizedStringKey?)] = [:]
    @State var isValid: [STTextFieldType: (Bool, LocalizedStringKey?)] = [:]
    @State var isStepValid: [STTextFieldType: [String: (LocalizedStringKey, Bool)]] = [:]
    
    var errorHandeling: ((
        [STTextFieldType: (Bool, LocalizedStringKey?)],
        [STTextFieldType: (Bool, LocalizedStringKey?)],
        [STTextFieldType: [String: (LocalizedStringKey, Bool)]]
    ) -> Void)?
    
    var returnValue: ((String) -> Void)?
    var onSubmit: (() -> Void)?
    
    public init(
        isFocusedOn: FocusState<STTextFieldType?>.Binding,
        textFields: [InputFieldType],
        axis: Axis.Set = .vertical,
        isDisableAutoCorrecting: Bool = true,
        foregroundColor: Color = .ST_595757,
        isShowIcon: Bool = false,
        style: STFieldStyle = .normal,
        spacing: CGFloat = 10,
        titleSpacing: CGFloat = 5,
        titleColor: Color = .ST_1B0851,
        returnedTextField: @escaping (AnyView, STTextFieldType, String?) -> ReturnedView,
        errorHandeling: ((
        [STTextFieldType: (Bool, LocalizedStringKey?)],
        [STTextFieldType: (Bool, LocalizedStringKey?)],
        [STTextFieldType: [String: (LocalizedStringKey, Bool)]]
    ) -> Void)? = nil,
        onSubmit: (() -> Void)? = nil
    ) {
        _isFocusedOn = isFocusedOn
        self.textFields = textFields
        self.axis = axis
        self.isDisableAutoCorrecting = isDisableAutoCorrecting
        self.foregroundColor = foregroundColor
        self.isShowIcon = isShowIcon
        self.style = style
        self.spacing = spacing
        self.titleSpacing = titleSpacing
        self.titleColor = titleColor
        self.returnedTextField = returnedTextField
        self.errorHandeling = errorHandeling
        self.onSubmit = onSubmit
    }
    
    public var body: some View {
        
        switch axis {
        
        case .vertical:
            VStack(spacing: spacing) {
                ForEach(Array(textFields.enumerated()), id: \.element) { index, element in
                    returnedTextField(
                        AnyView(createTextFieldView(for: element, index: index)),
                        findField(for: element),
                        currentValues[findField(for: element)]
                    )
                }
            }
            
        default:
            HStack(spacing: spacing) {
                ForEach(Array(textFields.enumerated()), id: \.element) { index, element in
                    returnedTextField(
                        AnyView(createTextFieldView(for: element, index: index)),
                        findField(for: element),
                        currentValues[findField(for: element)]
                    )
                }
            }
        }
    }
    
    // Find textfield type
    private func findField(for element: InputFieldType) -> STTextFieldType {
        switch element {
        case .secure(_, let textFieldType, _):
            return textFieldType
        case .text(_, let textFieldType, _):
            return textFieldType
        case .date(_, let textFieldType, _, _):
            return textFieldType
        }
    }
    
    // Create Input views
    @ViewBuilder
    private func createTextFieldView(for element: InputFieldType, index: Int) -> some View {
        VStack(alignment: .leading, spacing: titleSpacing) {
            switch element {
                
            case .secure(let binding, let textFieldType, let validator):
                
                STSecureField(
                    password: binding,
                    style: style,
                    placeholder: textFieldType.placeholder,
                    isShowIcon: self.isShowIcon,
                    isFieldFocus: $isFocusedOn,
                    fieldType: textFieldType) { value in
                        
                        currentValues[textFieldType] = value
                        isEmpty[textFieldType] = validator?.isEmpty() ?? (false, nil)
                        isValid[textFieldType] = validator?.validate() ?? (false, nil)
                        isStepValid[textFieldType] = validator?.stepValidate() ?? [:]
                        
                        errorHandeling?(isEmpty, isValid, isStepValid)
                    }
                    .fieldSetting(keyboardType: .asciiCapable)
                    .id(textFieldType.title)
                    .onSubmit {
                        
                        onSubmit?()
                    }
                    .onTapGesture {}
                    .disableAutocorrection(isDisableAutoCorrecting)
                
                
            case .text(let binding, let textFieldType, let validator):
                
                STTextFeild(
                    inputData: binding,
                    placeholder: textFieldType.placeholder,
                    isShowIcon: self.isShowIcon,
                    foregroundColor: foregroundColor,
                    style: style,
                    fieldType: textFieldType) { value in
                        currentValues[textFieldType] = value
                        
                        isEmpty[textFieldType] = validator?.isEmpty() ?? (false, nil)
                        isValid[textFieldType] = validator?.validate() ?? (false, nil)
                        isStepValid[textFieldType] = validator?.stepValidate() ?? [:]
                        
                        errorHandeling?(isEmpty, isValid, isStepValid)
                    }
                .fieldSetting(keyboardType: textFieldType.keyboardType)
                .id(textFieldType.title)
                .focused($isFocusedOn, equals: textFieldType)
                .onSubmit {
                    onSubmit?()
                }
                .onTapGesture {}
                .disableAutocorrection(isDisableAutoCorrecting)
                
                
            case .date(let binding, let textFieldType, let restriction, _):
                
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
    private func submitAction(index: Int) {
        let nextIndex = index + 1
        if nextIndex < textFields.count {
            switch textFields[nextIndex] {
            case .text(_, let nextType, _):
                isFocusedOn = nextType
            case .date(_, let nextType, _, _):
                isFocusedOn = nextType
            case .secure(_, let nextType, _):
                isFocusedOn = nextType
            }
        } else {
            isFocusedOn = nil
        }
    }

    private func errorHandeler(validator: Validator) {
        
    }
}

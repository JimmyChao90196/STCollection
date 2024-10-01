import SwiftUI

public struct STFlexFieldList<ReturnedView: View>: View {
    
    @FocusState.Binding public var isFocusedOn: STTextFieldType?
    var textFields: [InputFieldType]
    var foregroundColor: Color = .ST_595757
    var style: STFieldStyle = .normal
    var spacing: CGFloat = 10
    var titleSpacing: CGFloat = 5
    var titleColor: Color = .ST_1B0851
    
    var returnedTextField: (AnyView, STTextFieldType) -> ReturnedView
    
    public init(
        isFocusedOn: FocusState<STTextFieldType?>.Binding,
        textFields: [InputFieldType],
        foregroundColor: Color = .ST_595757,
        style: STFieldStyle = .normal,
        spacing: CGFloat = 10,
        titleSpacing: CGFloat = 5,
        titleColor: Color = .ST_1B0851,
        returnedTextField: @escaping (AnyView, STTextFieldType) -> ReturnedView
    ) {
        _isFocusedOn = isFocusedOn
        self.textFields = textFields
        self.foregroundColor = foregroundColor
        self.style = style
        self.spacing = spacing
        self.titleSpacing = titleSpacing
        self.titleColor = titleColor
        self.returnedTextField = returnedTextField
    }
    
    public var body: some View {
        VStack(spacing: spacing) {
            ForEach(Array(textFields.enumerated()), id: \.element) { index, element in
                returnedTextField(
                    AnyView(createTextFieldView(for: element, index: index)),
                    findField(for: element)
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
                    isShowIcon: false,
                    isFieldFocus: $isFocusedOn,
                    fieldType: textFieldType)
                .fieldSetting(keyboardType: .asciiCapable)
                .onSubmit { submitAction(index: index) }
                .onTapGesture {}
                
            case .text(let binding, let textFieldType):
                
                STTextFeild(
                    inputData: binding,
                    placeholder: textFieldType.placeholder,
                    foregroundColor: foregroundColor,
                    style: style)
                .fieldSetting(keyboardType: textFieldType.keyboardType)
                .focused($isFocusedOn, equals: textFieldType)
                .padding(.bottom, 8)
                .onTapGesture {}
                .onSubmit {
                    submitAction(index: index)
                }
                
            case .date(let binding, let textFieldType, let restriction):

                STDateField(
                    placeholder: textFieldType.placeholder,
                    selectedDate: binding,
                    foregroundColor: foregroundColor,
                    style: style,
                    dateRestriction: restriction)
                .onTapGesture {}
                .padding(.bottom, 8)
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

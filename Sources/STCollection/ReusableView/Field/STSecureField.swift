import SwiftUI

public enum STFieldStyle {
    case normal
    case block
    case outlineBlock
    case original
    case webField
}

public struct STSecureField: View {
    
    @Binding var password: String
    var style: STFieldStyle = .normal
    let placeholder: LocalizedStringKey
    var fontWeight: Font.Weight = .regular
    
    @State var isShowingPassword: Bool = false
    @State var isShowIcon: Bool = false
    @FocusState.Binding var isFieldFocus: STTextFieldType?
    let fieldType: STTextFieldType
    var onChange: ((String) -> Void)?
    
    public init(
        password: Binding<String>,
        style: STFieldStyle = .normal,
        placeholder: LocalizedStringKey,
        isShowingPassword: Bool = false,
        isShowIcon: Bool = true,
        isFieldFocus: FocusState<STTextFieldType?>.Binding,
        fieldType: STTextFieldType,
        fontWeight: Font.Weight = .regular,
        onChange: ((String) -> Void)? = nil
    ) {
        self._password = password
        self.style = style
        self.placeholder = placeholder
        self.isShowingPassword = isShowingPassword
        self.isShowIcon = isShowIcon
        self._isFieldFocus = isFieldFocus
        self.fieldType = fieldType
        self.fontWeight = fontWeight
        self.onChange = onChange
        }
    
    public var body: some View {
        HStack {
            
            if fieldType.icon != nil && style != .original && isShowIcon {
                fieldType.icon
            }
            
            Group {
                ZStack {
                    TextField("", text: $password)
                        .placeholder(placeholder, when: password.isEmpty)
                        .focused($isFieldFocus, equals: fieldType)
                        .opacity(isShowingPassword ? 1: 0)
                    
                    SecureField("", text: $password)
                        .placeholder(placeholder, when: password.isEmpty)
                        .focused($isFieldFocus, equals: fieldType)
                        .opacity(isShowingPassword ? 0: 1)
                }
            }
            .onChange(of: password) { _, value in
                onChange?(value)
            }
            .customDynamicSize(font: .callout, ...DynamicTypeSize.accessibility1)
            .fontWeight(.bold)
            .autocapitalization(.none)
            .multilineTextAlignment(.leading)
            .padding(5)
            .frame(maxWidth: .infinity)
            
            Button {
                isShowingPassword.toggle()
                isFieldFocus = fieldType
            } label: {
                Image(systemName: isShowingPassword ? "eye" : "eye.slash")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 27, height: 27)
            }
            .frame(maxWidth: 30, alignment: .trailing)
            .foregroundStyle(Color(hex: "#77330D"))
            .padding(.trailing)
        }
        .doubleIf(style == .normal, style == .original, then: { view in
            view
                .padding(.horizontal, 5)
                .innerShadow(.white, 5)
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.black.opacity(0.25), lineWidth: 1)
                }
        }, elseIf: { view in
            view
        }, else: { view in
            view
                .padding(.horizontal, 10)
                .padding(.vertical)
                .bubbleStyle(.ST_CBD8E8, 20)
        })
        
        .padding(.horizontal, 1)
        .onDisappear {
            isFieldFocus = nil
        }
    }
}

#Preview {
    
    @FocusState var isFocusedOn: STTextFieldType?
    
    STSecureField(
        password: .constant(""), style: .block,
        placeholder: "asdfasd",
        isFieldFocus: $isFocusedOn,
        fieldType: TextFieldTypeRegistry.password)
}

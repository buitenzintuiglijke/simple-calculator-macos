import SwiftUI

@main
struct CalculatorApp: App {
    var body: some Scene {
        WindowGroup { CalculatorView() }
            .windowResizability(.contentSize)
    }
}

struct CalculatorView: View {
    @State private var display = "0"
    @State private var stored: Double?
    @State private var operation: String?
    @State private var startNew = true
    private let rows = [["AC", "±", "%", "÷"], ["7", "8", "9", "×"], ["4", "5", "6", "−"], ["1", "2", "3", "+"], ["0", ".", "⌫", "="]]

    var body: some View {
        VStack(spacing: 10) {
            Text(display).font(.system(size: 42, weight: .light, design: .rounded))
                .lineLimit(1).minimumScaleFactor(0.3)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.vertical, 18).accessibilityLabel("Result: " + display)
            ForEach(rows, id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(row, id: \.self) { key in
                        Button { press(key) } label: {
                            Text(key).font(.title2).frame(width: 60, height: 52)
                        }
                        .buttonStyle(.plain)
                        .background(["÷", "×", "−", "+", "="].contains(key) ? Color.orange : Color.gray.opacity(0.25))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .accessibilityLabel(key == "⌫" ? "Delete last digit" : key)
                    }
                }
            }
            Text("Simple Calculator").font(.caption).foregroundStyle(.secondary)
        }
        .padding(20).frame(width: 310)
    }

    private func show(_ value: Double) {
        display = value.isFinite ? String(format: "%.12g", value) : "Error"
    }

    private func calculate() {
        guard let left = stored, let right = Double(display), let op = operation else { return }
        switch op {
        case "+": show(left + right)
        case "−": show(left - right)
        case "×": show(left * right)
        case "÷": if right == 0 { display = "Error" } else { show(left / right) }
        default: break
        }
        stored = nil
        operation = nil
    }

    private func press(_ key: String) {
        switch key {
        case "AC": display = "0"; stored = nil; operation = nil; startNew = true
        case "±": if let n = Double(display) { show(-n) }
        case "%": if let n = Double(display) { show(n / 100) }
        case "⌫":
            if !startNew { display = String(display.dropLast()); if display.isEmpty || display == "-" { display = "0" } }
        case "+", "−", "×", "÷":
            if !startNew { calculate() }
            stored = Double(display); operation = key; startNew = true
        case "=": calculate(); startNew = true
        default:
            if startNew || display == "Error" { display = key == "." ? "0." : key; startNew = false }
            else if key == "." { if !display.contains(".") { display += "." } }
            else if display.count < 15 { display = display == "0" ? key : display + key }
        }
    }
}

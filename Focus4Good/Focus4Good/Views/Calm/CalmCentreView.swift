import SwiftUI

struct CalmCentreView: View {

    @State private var showBraindump = false
    @State private var showBreathe = false
    @State private var showJPMR = false
    @State private var showASMR = false
    @State private var showDeepFocus = false

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    Button { showBraindump = true } label: { braindumpCard }
                        .buttonStyle(.plain)

                    relaxationToolsGrid
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)
                .padding(.bottom, 32)
            }
            .background(Color.white.ignoresSafeArea())
            .navigationTitle("Calm Centre")
            .navigationDestination(isPresented: $showBraindump) { BraindumpHomeView() }
            .navigationDestination(isPresented: $showBreathe) { BreatheSessionView() }
            .navigationDestination(isPresented: $showJPMR) { JPMRSessionView() }
            .navigationDestination(isPresented: $showASMR) { SensorySootheView() }
            .navigationDestination(isPresented: $showDeepFocus) { DeepFocusBrowseView() }
        }
    }

    // MARK: - Subviews

    private var braindumpCard: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color(hex: "FFF7F2"))

            HStack(spacing: 4) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Braindump")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(Color(hex: "1C1C1E"))

                    Text("Get the noise out of your\nhead.")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundStyle(Color(hex: "8E8E93"))
                        .lineLimit(3)
                        .minimumScaleFactor(0.85)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.leading, 18)

                Spacer(minLength: 4)

                Image("BRAINDUMPCARD")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 160)
                    .padding(.trailing, 6)
            }
            .padding(.vertical, 6)
        }
        .frame(height: 175)
    }

    private var relaxationToolsGrid: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            // 1. 4-7-8 Breathing Exercise
            toolCard(
                title: "4-7-8 Breathing\nExercise",
                subtitle: "Calm your mind\nin a few breaths.",
                imageName: "breathe",
                bgColor: Color(hex: "F2FAF5"),
                action: { showBreathe = true }
            )

            // 2. JPMR
            toolCard(
                title: "JPMR",
                subtitle: "Relax your body,\none muscle at a time.",
                imageName: "JPMR",
                bgColor: Color(hex: "F0F6FE"),
                action: { showJPMR = true }
            )

            // 3. ASMR Sounds
            toolCard(
                title: "ASMR Sounds",
                subtitle: "Soothing audio for\na quieter mind.",
                imageName: "ASMR",
                bgColor: Color(hex: "FFF2F5"),
                action: { showASMR = true }
            )

            // 4. Deep Focus
            toolCard(
                title: "Deep Focus",
                subtitle: "Stay present,\none step at a time.",
                imageName: "DEEPFOCUS",
                bgColor: Color(hex: "F5F2FE"),
                action: { showDeepFocus = true }
            )
        }
    }

    private func toolCard(
        title: String,
        subtitle: String,
        imageName: String,
        bgColor: Color,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Spacer(minLength: 4)

                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 125)

                VStack(spacing: 4) {
                    Text(title)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(Color(hex: "1C1C1E"))
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .minimumScaleFactor(0.9)

                    Text(subtitle)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(Color(hex: "8E8E93"))
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .minimumScaleFactor(0.85)
                }
                .padding(.horizontal, 8)

                Spacer(minLength: 8)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 220)
            .background(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(bgColor)
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    CalmCentreView()
        .environment(CalmCentreStore.shared)
}

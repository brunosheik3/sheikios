import SwiftUI

struct ContentView: View {
    private enum Screen {
        case home
        case terminal
    }

    @State private var screen: Screen = .home

    var body: some View {
        ZStack {
            switch screen {
            case .home:
                HomeView(showTerminal: { transition(to: .terminal) })
                    .transition(.opacity.combined(with: .move(edge: .leading)))
            case .terminal:
                TerminalView(goBack: { transition(to: .home) })
                    .transition(.opacity.combined(with: .move(edge: .trailing)))
            }
        }
        .preferredColorScheme(.dark)
    }

    private func transition(to destination: Screen) {
        withAnimation(.easeInOut(duration: 0.28)) {
            screen = destination
        }
    }
}

private struct HomeView: View {
    let showTerminal: () -> Void

    var body: some View {
        ZStack {
            Image("IntroPhoto")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            LinearGradient(
                colors: [.black.opacity(0.12), AppTheme.navy.opacity(0.82), AppTheme.ink.opacity(0.97)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 0) {
                Spacer()

                Text("SHEIK")
                    .font(.system(size: 46, weight: .black, design: .rounded))
                    .tracking(3)
                    .foregroundStyle(.white)

                Text("CONEXÃO LOCAL")
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .tracking(2.4)
                    .foregroundStyle(AppTheme.sky)
                    .padding(.top, 4)

                Text("Uma interface direta para acompanhar seus dispositivos e arquivos.")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(AppTheme.muted)
                    .padding(.top, 16)
                    .fixedSize(horizontal: false, vertical: true)

                VStack(spacing: 12) {
                    StatusCard(
                        icon: "dot.radiowaves.left.and.right",
                        title: "Dispositivo",
                        detail: "Pronto para conectar"
                    )
                    StatusCard(
                        icon: "folder.fill",
                        title: "Arquivos",
                        detail: "Selecione quando estiver pronto"
                    )
                }
                .padding(.top, 28)

                Button(action: showTerminal) {
                    HStack(spacing: 10) {
                        Image(systemName: "terminal.fill")
                        Text("ABRIR TERMINAL")
                    }
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 17)
                    .background(AppTheme.blue, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                    .foregroundStyle(.white)
                }
                .buttonStyle(.plain)
                .padding(.top, 20)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 28)
        }
    }
}

private struct StatusCard: View {
    let icon: String
    let title: String
    let detail: String

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(AppTheme.sky)
                .frame(width: 42, height: 42)
                .background(AppTheme.blue.opacity(0.22), in: RoundedRectangle(cornerRadius: 13, style: .continuous))

            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.white)
                Text(detail)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(AppTheme.muted)
            }
            Spacer()
        }
        .padding(14)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(.white.opacity(0.12), lineWidth: 1)
        }
    }
}

private struct TerminalView: View {
    let goBack: () -> Void

    var body: some View {
        ZStack {
            Image("TerminalPhoto")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .saturation(0)

            Color.black.opacity(0.74).ignoresSafeArea()

            VStack(spacing: 0) {
                HStack {
                    Button(action: goBack) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 17, weight: .bold))
                            .frame(width: 42, height: 42)
                            .background(.white.opacity(0.11), in: Circle())
                    }
                    .buttonStyle(.plain)

                    VStack(alignment: .leading, spacing: 2) {
                        Text("SHEIK")
                            .font(.system(size: 17, weight: .black, design: .rounded))
                            .tracking(1.4)
                        Text("TERMINAL")
                            .font(.system(size: 10, weight: .bold, design: .rounded))
                            .tracking(1.8)
                            .foregroundStyle(AppTheme.sky)
                    }
                    Spacer()
                    Circle()
                        .fill(AppTheme.blue)
                        .frame(width: 10, height: 10)
                }
                .foregroundStyle(.white)
                .padding(.horizontal, 22)
                .padding(.top, 14)

                Spacer()

                VStack(alignment: .leading, spacing: 14) {
                    TerminalLine(prefix: "sheik", text: "sessão visual iniciada")
                    TerminalLine(prefix: "status", text: "aguardando ação")
                    TerminalLine(prefix: "interface", text: "azul ativo")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
                .background(AppTheme.ink.opacity(0.82), in: RoundedRectangle(cornerRadius: 22, style: .continuous))
                .overlay {
                    RoundedRectangle(cornerRadius: 22, style: .continuous)
                        .stroke(AppTheme.blue.opacity(0.52), lineWidth: 1)
                }
                .padding(22)
            }
        }
    }
}

private struct TerminalLine: View {
    let prefix: String
    let text: String

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 8) {
            Text("›")
                .foregroundStyle(AppTheme.sky)
            Text(prefix)
                .foregroundStyle(AppTheme.blue)
            Text(text)
                .foregroundStyle(.white.opacity(0.86))
        }
        .font(.system(.footnote, design: .monospaced).weight(.medium))
    }
}

#Preview {
    ContentView()
}

# Garbanzo System

Garbanzo System é um rice completo de **Hyprland + Quickshell** para Arch Linux (testado em CachyOS), com UX no padrão do r/unixporn (barra superior + dock inferior) e visual inspirado no **Zenless Zone Zero** (ZZZ): paleta laranja/amarelo/preto, painéis angulares, cantos chanfrados e tipografia bold.

> Projeto baseado na UX do post do r/unixporn "[Hyprland] Project Sekai Inspired Quickshell" (u/Single-Flamingo-8194) e no visual do ZZZ. Assets de ícones: Zenless Zone Zero Wiki (Fandom). Conceito de UI: Figma "Zenless Website UI Concept".

## Estrutura

```
garbanzo/
├── hypr/                 # configs do Hyprland
├── quickshell/           # shell Quickshell (QML)
│   ├── shell.qml         # entry point
│   ├── shell.json        # settings do usuário
│   ├── config/           # singletons de config/tema
│   ├── components/       # primitivos reutilizáveis
│   ├── modules/          # bar, dock, launcher, notifications, osd, lockscreen
│   ├── services/         # integrações de sistema
│   └── assets/           # ícones, imagens, shaders
├── scripts/              # install, setup, reload
├── wallpapers/
└── docs/
```

## Requisitos

- Arch Linux / CachyOS
- Hyprland (>= 0.40)
- Quickshell (>= 0.2, git recomendado)
- Qt 6.8+
- Fontes: JetBrains Mono Nerd Font, Rajdhani (ou similar bold), Material Symbols
- Utilitários: brightnessctl, pamixer/pactl, networkmanager, bluez, grim, slurp, wl-clipboard, swww/swaybg, hyprlock, hypridle

## Instalação rápida

```bash
git clone https://github.com/prunbo/garbanzo.git
cd garbanzo
chmod +x scripts/install.sh
./scripts/install.sh
```

O script copia as configs para `~/.config/hypr` e `~/.config/quickshell/garbanzo`, instala dependências via pacman/paru e adiciona o autostart.

## Uso

- Recarregar o shell: `./scripts/reload-quickshell.sh`
- Trocar tema/cores: edite `quickshell/config/Theme.qml` ou `shell.json`.
- Adicionar apps ao dock: edite `shell.json` -> `dock.pinned`.

## Referência visual
Descrições detalhadas das telas do ZZZ usadas como referência: `docs/ZZZ_UI_REFERENCE.md`.
Imagens de referência: `quickshell/assets/reference/`.

## Créditos

- UX: r/unixporn (post Project Sekai inspired Quickshell).
- Visual: Zenless Zone Zero (HoYoverse) — uso não comercial/fan.
- Ícones: Zenless Zone Zero Wiki (Fandom).
- Conceito UI: Figma "Zenless Website UI Concept".
path">
/home/user/garbanzo/README.md
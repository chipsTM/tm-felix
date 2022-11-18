Animation@ g_anim;
float g_dt = 0;
int g_width;
int g_height;

enum Character {
    Felix,
    PausePhant,
    DVD,
};

void Render() {
    if (g_anim !is null) {
        g_anim.Render();
    }
}

void OnSettingsChanged() {
    SelectCharacter();
}

void Update(float dt) {
    g_dt += dt;
    auto app = cast<CTrackMania>(GetApp());
    if (app.ManiaPlanetScriptAPI.DisplaySettings is null) {
        app.ManiaPlanetScriptAPI.DisplaySettings_LoadCurrent();
    }
    auto windowSize = app.ManiaPlanetScriptAPI.DisplaySettings.WindowSize;

    g_width = windowSize.x;
    g_height = windowSize.y;
}

void SelectCharacter() {
    switch (g_char) {
        case Character::Felix:
            trace("Felix");
            @g_anim = Felix(UI::LoadTexture("src/Felix.png"));
            break;
        case Character::PausePhant:
            trace("PausePhant");
            @g_anim = PausePhant(UI::LoadTexture("src/PausePhant.png"));
            break;
        case Character::DVD:
            trace("DVD Logo");
            @g_anim = DVD(UI::LoadTexture("src/DVD_white.png"));
            break;
        default:
            break;
    }
}

void Main() {
    SelectCharacter();
}
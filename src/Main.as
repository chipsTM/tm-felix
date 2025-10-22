Animation@ g_anim;
float g_dt = 0;
int g_width;
int g_height;

enum Character {
    ArachFelixWhite,
    ArachFelixBlack,
    ArachFelixOrange,
    ArachFelixSiamese,
    PausePhant,
    DVD,
    FelixOriginal,
};

void Render() {
    if (g_anim !is null) {
        g_anim.Render();
    }
    isSettingsOpen = false;
}

void Update(float dt) {
    g_dt += dt;
    UpdateWindowSize();
}

void UpdateWindowSize() {
#if TURBO
    g_width = Draw::GetWidth();
    g_height = Draw::GetHeight();
#else
    auto app = cast<CTrackMania>(GetApp());
    if (app.ManiaPlanetScriptAPI.DisplaySettings is null) {
        app.ManiaPlanetScriptAPI.DisplaySettings_LoadCurrent();
    }
    auto windowSize = app.ManiaPlanetScriptAPI.DisplaySettings.WindowFullSize;
    g_width = windowSize.x;
    g_height = windowSize.y;
#endif
}

void SelectCharacter() {
    switch (g_char) {
        case Character::ArachFelixWhite:
            // trace("ArachFelixWhite");
            @g_anim = ArachFelix(UI::LoadTexture("src/Images/felixWhite.png"));
            break;
        case Character::ArachFelixBlack:
            // trace("ArachFelixBlack");
            @g_anim = ArachFelix(UI::LoadTexture("src/Images/felixBlack.png"));
            break;
        case Character::ArachFelixOrange:
            // trace("ArachFelixOrange");
            @g_anim = ArachFelix(UI::LoadTexture("src/Images/felixOrange.png"));
            break;
        case Character::ArachFelixSiamese:
            // trace("ArachFelixSiamese");
            @g_anim = ArachFelix(UI::LoadTexture("src/Images/felixSiamese.png"));
            break;
        case Character::FelixOriginal:
            // trace("Felix (Original)");
            @g_anim = Felix(UI::LoadTexture("src/Images/Felix.png"));
            break;
        case Character::PausePhant:
            // trace("PausePhant");
            @g_anim = PausePhant(UI::LoadTexture("src/Images/PausePhant.png"));
            break;
        case Character::DVD:
            // trace("DVD Logo");
            @g_anim = DVD(UI::LoadTexture("src/Images/DVD_white.png"));
            break;
        default:
            break;
    }
}

void Main() {
    UpdateWindowSize();
    SelectCharacter();
}
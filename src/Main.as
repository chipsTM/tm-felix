Felix@ g_cat;
float g_dt = 0;
int g_width;
int g_height;

void Render() {
#if TMNEXT
    g_cat.Render();
#endif
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

void Main() {
#if TMNEXT
    UI::Texture@ catTexture = UI::LoadTexture("src/Cat Sprite Sheet.png");
    @g_cat = Felix(catTexture);
#endif
}
Felix@ g_cat;
float g_dt = 0;
int g_width;
int g_height;

enum Animation {
    Idle1,
    Idle2,
    Clean1,
    Clean2,
    Movement1,
    Movement2,
    Sleep,
    Paw,
    Jump,
    Scared   
};

class Felix {
    vec2 position;
    int scaleFactor = 3;
    uint animationTick = 0;
    Animation curAnimation = Animation::Movement2;
    Resources::Texture@ atlas;
    int loops = 0;
    int times = 10;
    int curXDir = -1;
    int curYDir = -1;

    dictionary aniFrames = {
        { tostring(Animation::Idle1), 4},
        { tostring(Animation::Idle2), 4},
        { tostring(Animation::Clean1), 4},
        { tostring(Animation::Clean2), 4},
        { tostring(Animation::Movement1), 8},
        { tostring(Animation::Movement2), 8},
        { tostring(Animation::Sleep), 4},
        { tostring(Animation::Paw), 6},
        { tostring(Animation::Jump), 7},
        { tostring(Animation::Scared), 8}
    };

    Felix(Resources::Texture@ at) {
        @atlas = @at;
        position = vec2(Math::Rand(0, g_width), Math::Rand(0, g_height));
    }

    void Render() {
        auto drawlist = UI::GetForegroundDrawList();

        int windowFlags = UI::WindowFlags::NoTitleBar | UI::WindowFlags::NoCollapse | UI::WindowFlags::AlwaysAutoResize | UI::WindowFlags::NoDocking | UI::WindowFlags::NoInputs;
        
        UI::PushStyleColor(UI::Col::WindowBg, vec4(0,0,0,0));
        UI::Begin("Felix", windowFlags);
        
        // we add 1 to the y component of uv to remove artifacting
        drawlist.AddImage(atlas, position, vec2(32*scaleFactor*curXDir,32*scaleFactor), 0xFFFFFFFF, vec4(32*animationTick, 32*curAnimation+1, 32, 32));
        
        uint frames = uint(aniFrames[tostring(curAnimation)]);
        if (g_dt >= 100) {
            if (position.x >= g_width - 32) {
                curXDir = -1;
            } else if (position.x <= 32) {
                curXDir = 1;
            }

            if (position.y >= g_height - 32) {
                curYDir = -1;
            } else if (position.y <= 32) {
                curYDir = 1;
            }

            if (curAnimation == Animation::Movement1) {
                position.x += curXDir * 3;
                position.y += curYDir * 1;
            } else if (curAnimation == Animation::Movement2) {
                position.x += curXDir * 6;
                position.y += curYDir * 1;
            } else if (curAnimation == Animation::Jump) {
                position.x += curXDir * 3;
                position.y += curYDir * 5;
            }

            if (animationTick >= frames - 1) {
                animationTick = 0;
            } else {
                animationTick += 1;
            }
            g_dt = 0;
            if (loops >= times * frames - 1){
                curAnimation = Animation(Math::Rand(0,10));
                loops = 0;
                if (curAnimation == Animation::Jump || curAnimation == Animation::Scared || curAnimation == Animation::Paw) {
                    times = 1;
                } else {
                    times = Math::Rand(10,20);
                }
                curYDir = 0;
                while (curYDir == 0) {
                    curYDir = Math::Rand(-1,2);
                }
            } else {
                loops += 1;
            }
        }

        UI::End();
        UI::PopStyleColor();
    }
}

void Render() {
#if TMNEXT
    g_cat.Render();
#endif
}

void Update(float dt) {
    g_dt += dt;
    auto app = cast<CTrackMania>(GetApp());
    auto windowSize = app.ManiaPlanetScriptAPI.DisplaySettings.WindowSize;

    g_width = windowSize.x;
    g_height = windowSize.y;
}

void Main() {
#if TMNEXT
    Resources::Texture@ catTexture = Resources::GetTexture("src/Cat Sprite Sheet.png");
    @g_cat = Felix(catTexture);
#endif
}
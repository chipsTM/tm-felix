enum FelixAnimation {
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

class Felix : Animation {
    vec2 position;
    int scaleFactor = 3;
    uint animationTick = 0;
    FelixAnimation curAnimation = FelixAnimation::Movement2;
    UI::Texture@ atlas;
    int sprite_width = 32;
    int sprite_height = 32;
    int loops = 0;
    int times = 10;
    int curXDir = -1;
    int curYDir = -1;

    dictionary aniFrames = {
        { tostring(FelixAnimation::Idle1), 4},
        { tostring(FelixAnimation::Idle2), 4},
        { tostring(FelixAnimation::Clean1), 4},
        { tostring(FelixAnimation::Clean2), 4},
        { tostring(FelixAnimation::Movement1), 8},
        { tostring(FelixAnimation::Movement2), 8},
        { tostring(FelixAnimation::Sleep), 4},
        { tostring(FelixAnimation::Paw), 6},
        { tostring(FelixAnimation::Jump), 7},
        { tostring(FelixAnimation::Scared), 8}
    };

    Felix(UI::Texture@ at) {
        @atlas = @at;
        position = vec2(Math::Rand(0, g_width), Math::Rand(0, g_height));
    }

    void Render() override {
        auto drawlist = UI::GetForegroundDrawList();

        UI::PushStyleColor(UI::Col::WindowBg, vec4(0,0,0,0));
        UI::PushStyleColor(UI::Col::Border, vec4(0,0,0,0));
        int windowFlags = UI::WindowFlags::NoTitleBar | UI::WindowFlags::NoCollapse | UI::WindowFlags::AlwaysAutoResize | UI::WindowFlags::NoDocking | UI::WindowFlags::NoInputs;
        UI::Begin("Felix", windowFlags);
        
        // we add 1 to the y component of uv to remove artifacting
        drawlist.AddImage(atlas, position, vec2(sprite_width*scaleFactor*curXDir,sprite_height*scaleFactor), 0xFFFFFFFF, vec4(sprite_width*animationTick, sprite_height*curAnimation+1, sprite_width, sprite_height));
        
        uint frames = uint(aniFrames[tostring(curAnimation)]);
        if (g_dt >= 100) {
            if (position.x >= g_width - sprite_width) {
                curXDir = -1;
            } else if (position.x <= sprite_width) {
                curXDir = 1;
            }

            if (position.y >= g_height - sprite_height) {
                curYDir = -1;
            } else if (position.y <= sprite_height) {
                curYDir = 1;
            }

            if (curAnimation == FelixAnimation::Movement1) {
                position.x += curXDir * 3;
                position.y += curYDir * 1;
            } else if (curAnimation == FelixAnimation::Movement2) {
                position.x += curXDir * 6;
                position.y += curYDir * 1;
            } else if (curAnimation == FelixAnimation::Jump) {
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
                curAnimation = FelixAnimation(Math::Rand(0,10));
                loops = 0;
                if (curAnimation == FelixAnimation::Jump || curAnimation == FelixAnimation::Scared || curAnimation == FelixAnimation::Paw) {
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
        UI::PopStyleColor(2);
    }
}